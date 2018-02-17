#include <msp430.h>

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include <libwispbase/accel.h>
#include <libmspbuiltins/builtins.h>
#include <libio/log.h>
#include <libmsp/mem.h>
#include <libmsp/periph.h>
#include <libmsp/clock.h>
#include <libmsp/watchdog.h>
#include <libmsp/gpio.h>
#include <libmspmath/msp-math.h>

#ifdef CONFIG_EDB
#include <libedb/edb.h>
#else
#define ENERGY_GUARD_BEGIN()
#define ENERGY_GUARD_END()
#endif

#include <libalpaca/alpaca.h>

#include "pins.h"

void __loop_bound__(unsigned val){};
unsigned count = 0;
unsigned seed = 1;

/* This is for progress reporting only */

// Number of samples to discard before recording training set
#define NUM_WARMUP_SAMPLES 3

#define ACCEL_WINDOW_SIZE 3
#define MODEL_SIZE 16
#define SAMPLE_NOISE_FLOOR 10 // TODO: made up value

// Number of classifications to complete in one experiment
#define SAMPLES_TO_COLLECT 8

#ifdef ACCEL_16BIT_TYPE
typedef threeAxis_t accelReading;
#else // !ACCEL_16BIT_TYPE
typedef threeAxis_t_8 accelReading;
#endif // !ACCEL_16BIT_TYPE
static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}
unsigned overflow=0;
//__attribute__((interrupt(TIMERB1_VECTOR))) 
__attribute__((interrupt(51))) 
void TimerB1_ISR(void){
	TBCTL &= ~(0x0002);
	if(TBCTL && 0x0001){
		overflow++;
		TBCTL |= 0x0004;
		TBCTL |= (0x0002);
		TBCTL &= ~(0x0001);	
	}
}
__attribute__((section("__interrupt_vector_timer0_b1"),aligned(2)))
void(*__vector_timer0_b1)(void) = TimerB1_ISR;

typedef accelReading accelWindow[ACCEL_WINDOW_SIZE];

typedef struct {
    unsigned meanmag;
    unsigned stddevmag;
} features_t;

typedef enum {
    CLASS_STATIONARY,
    CLASS_MOVING,
} class_t;

typedef struct {
    features_t stationary[MODEL_SIZE];
    features_t moving[MODEL_SIZE];
} model_t;

typedef enum {
    MODE_IDLE = 3,
    MODE_TRAIN_STATIONARY = 2,
    MODE_TRAIN_MOVING = 1,
    MODE_RECOGNIZE = 0, // default
    //MODE_IDLE = (BIT(PIN_AUX_1) | BIT(PIN_AUX_2)),
    //MODE_TRAIN_STATIONARY = BIT(PIN_AUX_1),
   // MODE_TRAIN_MOVING = BIT(PIN_AUX_2),
   // MODE_RECOGNIZE = 0, // default
} run_mode_t;

typedef struct {
    unsigned totalCount;
    unsigned movingCount;
    unsigned stationaryCount;
} stats_t;


//__attribute__((always_inline))
void accel_sample(unsigned seed, accelReading* result){
//void ngleSample_(unsigned seed, accelReading* result){
//void ACCEL_singleSample_(unsigned seed, threeAxis_t_8* result){
	result->x = (seed*17)%85;
	result->y = (seed*17*17)%85;
	result->z = (seed*17*17*17)%85;
//	seed++;
//	return 1;
}
//__attribute__((always_inline))
void acquire_window(accelWindow window)
{
	accelReading sample;
	unsigned samplesInWindow = 0;

	while (__loop_bound__(3), samplesInWindow < ACCEL_WINDOW_SIZE) {
		accel_sample(seed, &sample);
		LOG("seed: %u\r\n", seed);
		seed++;
		LOG("acquire: sample %u %u %u\r\n", sample.x, sample.y, sample.z);

		window[samplesInWindow++] = sample;
	}
}

//__attribute__((always_inline))
void transform(accelWindow window)
{
	unsigned i = 0;

	LOG("transform\r\n");
//	LOG("sample %u %u %u\r\n", window[0].x, window[0].y, window[0].z);
//	LOG("sample %u %u %u\r\n", window[1].x, window[1].y, window[1].z);
//	LOG("sample %u %u %u\r\n", window[2].x, window[2].y, window[2].z);

	for (i = 0; i < ACCEL_WINDOW_SIZE; i++) {
		accelReading *sample = &window[i];

		if (sample->x < SAMPLE_NOISE_FLOOR ||
				sample->y < SAMPLE_NOISE_FLOOR ||
				sample->z < SAMPLE_NOISE_FLOOR) {

			LOG("transform: sample %u %u %u\r\n",
					sample->x, sample->y, sample->z);

			sample->x = (sample->x > SAMPLE_NOISE_FLOOR) ? sample->x : 0;
			sample->y = (sample->y > SAMPLE_NOISE_FLOOR) ? sample->y : 0;
			sample->z = (sample->z > SAMPLE_NOISE_FLOOR) ? sample->z : 0;
		}
	}
}

//__attribute__((always_inline))
void featurize(features_t *features, accelWindow aWin)
{
	LOG("feat %x\r\n", features);
	accelReading mean;
	accelReading stddev;

	mean.x = mean.y = mean.z = 0;
	stddev.x = stddev.y = stddev.z = 0;
	int i;
	for (i = 0; i < ACCEL_WINDOW_SIZE; i++) {
		mean.x += aWin[i].x;  // x
		mean.y += aWin[i].y;  // y
		mean.z += aWin[i].z;  // z
	}
	/*
		 mean.x = mean.x / ACCEL_WINDOW_SIZE;
		 mean.y = mean.y / ACCEL_WINDOW_SIZE;
		 mean.z = mean.z / ACCEL_WINDOW_SIZE;
		 */
	mean.x >>= 2;
	mean.y >>= 2;
	mean.z >>= 2;

	for (i = 0; i < ACCEL_WINDOW_SIZE; i++) {
		stddev.x += aWin[i].x > mean.x ? aWin[i].x - mean.x
			: mean.x - aWin[i].x;  // x
		stddev.y += aWin[i].y > mean.y ? aWin[i].y - mean.y
			: mean.y - aWin[i].y;  // y
		stddev.z += aWin[i].z > mean.z ? aWin[i].z - mean.z
			: mean.z - aWin[i].z;  // z
	}
	/*
		 stddev.x = stddev.x / (ACCEL_WINDOW_SIZE - 1);
		 stddev.y = stddev.y / (ACCEL_WINDOW_SIZE - 1);
		 stddev.z = stddev.z / (ACCEL_WINDOW_SIZE - 1);
		 */
	stddev.x >>= 2;
	stddev.y >>= 2;
	stddev.z >>= 2;

	unsigned meanmag = mean.x*mean.x + mean.y*mean.y + mean.z*mean.z;
	unsigned stddevmag = stddev.x*stddev.x + stddev.y*stddev.y + stddev.z*stddev.z;

	features->meanmag   = sqrt16(meanmag);
	features->stddevmag = sqrt16(stddevmag);

	LOG("featurize: mean %u sd %u\r\n", features->meanmag, features->stddevmag);
}

//__attribute__((always_inline))
class_t classify(features_t *features, model_t *model)
{
	LOG("cf %x\r\n", features);
	int move_less_error = 0;
	int stat_less_error = 0;
	features_t *model_features;
	int i;

	LOG("mean %u stddev %u\r\n", features->meanmag, features->stddevmag);
	for (i = 0; i < MODEL_SIZE; ++i) {
		model_features = &model->stationary[i];
		LOG("stat mean %u stddev %u\r\n", model_features->meanmag, model_features->stddevmag);

		long int stat_mean_err = (model_features->meanmag > features->meanmag)
			? (model_features->meanmag - features->meanmag)
			: (features->meanmag - model_features->meanmag);

		long int stat_sd_err = (model_features->stddevmag > features->stddevmag)
			? (model_features->stddevmag - features->stddevmag)
			: (features->stddevmag - model_features->stddevmag);

		model_features = &model->moving[i];
		LOG("moving mean %u stddev %u\r\n", model_features->meanmag, model_features->stddevmag);

		long int move_mean_err = (model_features->meanmag > features->meanmag)
			? (model_features->meanmag - features->meanmag)
			: (features->meanmag - model_features->meanmag);

		long int move_sd_err = (model_features->stddevmag > features->stddevmag)
			? (model_features->stddevmag - features->stddevmag)
			: (features->stddevmag - model_features->stddevmag);

		LOG("mme %x %x sme %x %x\r\n", (unsigned)(move_mean_err >> 16), (unsigned)(move_mean_err), (unsigned)(stat_mean_err >> 16), (unsigned)(stat_mean_err));
		if (move_mean_err < stat_mean_err) {
			move_less_error++;
		} else {
			stat_less_error++;
		}

		LOG("mse %x %x sse %x %x\r\n", (unsigned)(move_sd_err >> 16), (unsigned)(move_sd_err), (unsigned)(stat_sd_err >> 16), (unsigned)(stat_sd_err));
		if (move_sd_err < stat_sd_err) {
			move_less_error++;
		} else {
			stat_less_error++;
		}
	}
	LOG("me %u se %u\r\n", move_less_error, stat_less_error);

	class_t class = move_less_error > stat_less_error ?
		CLASS_MOVING : CLASS_STATIONARY;
	LOG("classify: class %u\r\n", class);

	return class;
}

//__attribute__((always_inline))
void record_stats(stats_t *stats, class_t class)
{
	/* stats->totalCount, stats->movingCount, and stats->stationaryCount have an
	 * nv-internal consistency requirement.  This code should be atomic. */

	stats->totalCount++;

	switch (class) {
		case CLASS_MOVING:

#if defined(SHOW_RESULT_ON_LEDS)
			blink(CLASSIFY_BLINKS, CLASSIFY_BLINK_DURATION, LED1);
#endif //SHOW_RESULT_ON_LEDS

			stats->movingCount++;
			break;

		case CLASS_STATIONARY:

#if defined(SHOW_RESULT_ON_LEDS)
			blink(CLASSIFY_BLINKS, CLASSIFY_BLINK_DURATION, LED2);
#endif //SHOW_RESULT_ON_LEDS

			stats->stationaryCount++;
			break;
	}

	LOG("stats: s %u m %u t %u\r\n",
			stats->stationaryCount, stats->movingCount, stats->totalCount);
}

//__attribute__((always_inline))
void print_stats(stats_t *stats)
{
	unsigned resultStationaryPct = stats->stationaryCount * 100 / stats->totalCount;
	unsigned resultMovingPct = stats->movingCount * 100 / stats->totalCount;

	unsigned sum = stats->stationaryCount + stats->movingCount;

	PRINTF("stats: s %u (%u%%) m %u (%u%%) sum/tot %u/%u: %c\r\n",
			stats->stationaryCount, resultStationaryPct,
			stats->movingCount, resultMovingPct,
			stats->totalCount, sum,
			sum == stats->totalCount && sum == SAMPLES_TO_COLLECT ? 'V' : 'X');
}

//__attribute__((always_inline))
void warmup_sensor()
{
	unsigned discardedSamplesCount = 0;
	accelReading sample;

	LOG("warmup\r\n");

	while (__loop_bound__(3), discardedSamplesCount++ < NUM_WARMUP_SAMPLES) {
		accel_sample(seed, &sample);
		LOG("seed: %u\r\n", seed);
		seed++;
	}
}

//__attribute__((always_inline))
void train(features_t *classModel)
{
	accelWindow sampleWindow;
	features_t features;
	unsigned i;

	warmup_sensor();

	for (i = 0; i < MODEL_SIZE; ++i) {
		acquire_window(sampleWindow);
		transform(sampleWindow);
		featurize(&features, sampleWindow);

		classModel[i] = features;
	}

	//   PRINTF("train: done: mn %u sd %u\r\n",
	//          features.meanmag, features.stddevmag);
}

//__attribute__((always_inline))
void recognize(model_t *model)
{
#ifdef MEMENTOS_NONVOLATILE
	stats_t stats;
#else
	stats_t stats;
#endif
	accelWindow sampleWindow;
	features_t features;
	class_t class;
	unsigned i;

	stats.totalCount = 0;
	stats.stationaryCount = 0;
	stats.movingCount = 0;

	for (i = 0; i < SAMPLES_TO_COLLECT; ++i) {
		acquire_window(sampleWindow);
		transform(sampleWindow);
		LOG("bf mean %u stddev %u\r\n", features.meanmag, features.stddevmag);
		featurize(&features, sampleWindow);
		LOG("af mean %u stddev %u\r\n", features.meanmag, features.stddevmag);
		class = classify(&features, model);
		record_stats(&stats, class);
	}

	print_stats(&stats);
}

//__attribute__((always_inline))
run_mode_t select_mode(uint8_t *prev_pin_state)
{
	uint8_t pin_state = 1;

	count++;
	LOG("count: %u\r\n", count);
	if(count >= 2) pin_state = 2;
	if(count >= 3) pin_state = 0;
	if(count >= 4) {   
		PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
		end_run();
		PRINTF("chkpt cnt: %u\r\n", chkpt_count);
		PRINTF("a%u.\r\n", curctx->cur_reg[15]);
		PRINTF("done\r\n");
		count = 0;
		seed = 1;
		pin_state = 1;
		//		exit(0);
	}
	// Don't re-launch training after finishing training
	if ((pin_state == MODE_TRAIN_STATIONARY ||
				pin_state == MODE_TRAIN_MOVING) &&
			pin_state == *prev_pin_state) {
		pin_state = MODE_IDLE;
	} else {
		*prev_pin_state = pin_state;
	}

	LOG("selectMode: pins %04x\r\n", pin_state);

	return (run_mode_t)pin_state;
}

//__attribute__((always_inline))
static void init_accel()
{
#ifdef ACCEL_16BIT_TYPE
	threeAxis_t accelID = {0};
#else
	threeAxis_t_8 accelID = {0};
#endif
}

void init()
{
#ifndef CONFIG_EDB
	TBCTL &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	TBCTL |= 0x0200; //set 9 to one (SMCLK)
	TBCTL |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	TBCTL &= 0xFFEF; //set bit 4 to zero
	TBCTL |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	TBCTL |= 0x0002; //interrupt enable
#endif
	init_hw();
#ifdef CONFIG_EDB
	edb_init();
#endif

	INIT_CONSOLE();

	__enable_interrupt();
	init_accel();

	//PRINTF("a%u.\r\n", curctx->cur_reg[15]);
}

int main()
{
	// "Globals" must be on the stack because Mementos doesn't handle real
	// globals correctly
	uint8_t prev_pin_state = MODE_IDLE;

	model_t model;

	while (1) {
		__loop_bound__(8);
		//PRINTF("start\r\n");
		PRINTF("TIME start is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
		run_mode_t mode = select_mode(&prev_pin_state);
		switch (mode) {
			case MODE_TRAIN_STATIONARY:
				LOG("mode: stationary\r\n");
				train(model.stationary);
				break;
			case MODE_TRAIN_MOVING:
				LOG("mode: moving\r\n");
				train(model.moving);
				break;
			case MODE_RECOGNIZE:
				LOG("mode: recognize\r\n");
				recognize(&model);
				break;
			default:
				LOG("mode: idle\r\n");
				break;
		}
	}

	return 0;
}
