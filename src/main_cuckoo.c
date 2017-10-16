#include <msp430.h>

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include <libmspbuiltins/builtins.h>
#include <libio/log.h>
#include <libmsp/mem.h>
#include <libmsp/periph.h>
#include <libmsp/clock.h>
#include <libmsp/watchdog.h>
#include <libmsp/gpio.h>
//#include <libmspmath/msp-math.h>

#ifdef CONFIG_EDB
#include <libedb/edb.h>
#else
#define ENERGY_GUARD_BEGIN()
#define ENERGY_GUARD_END()
#endif
#include <libalpaca/alpaca.h>

#include "pins.h"

// #define SHOW_PROGRESS_ON_LED
#include <stdint.h>

//#define NUM_BUCKETS 256 // must be a power of 2
#define NUM_BUCKETS 128 // must be a power of 2
//#define NUM_BUCKETS 64 // must be a power of 2
#define MAX_RELOCATIONS 8

void __loop_bound__(unsigned val){};
typedef uint16_t value_t;
typedef uint16_t hash_t;
typedef uint16_t fingerprint_t;
typedef uint16_t index_t; // bucket index

#define NUM_KEYS (NUM_BUCKETS / 4) // shoot for 25% occupancy
#define INIT_KEY 0x1

#define TASK_MAIN                   1
#define TASK_GENERATE_KEY           2
#define TASK_INSERT_FINGERPRINT     3
#define TASK_INSERT_INDEX_1         4
#define TASK_INSERT_INDEX_2         5
#define TASK_INSERT_UPDATE          6
#define TASK_RELOCATE_VICTIM        7
#define TASK_RELOCATE_UPDATE        8
#define TASK_LOOKUP_FINGERPRINT     9
#define TASK_LOOKUP_INDEX_1        10
#define TASK_LOOKUP_INDEX_2        11
#define TASK_LOOKUP_CHECK          12
#define TASK_PRINT_RESULTS         13

#ifdef DINO

#define TASK_BOUNDARY(t) \
	DINO_TASK_BOUNDARY(NULL); \
SET_CURTASK(t); \

#define DINO_MANUAL_RESTORE_NONE() \
	DINO_MANUAL_REVERT_BEGIN() \
DINO_MANUAL_REVERT_END() \

#define DINO_MANUAL_RESTORE_PTR(nm, type) \
	DINO_MANUAL_REVERT_BEGIN() \
DINO_MANUAL_REVERT_PTR(type, nm); \
DINO_MANUAL_REVERT_END() \

#define DINO_MANUAL_RESTORE_VAL(nm, label) \
	DINO_MANUAL_REVERT_BEGIN() \
DINO_MANUAL_REVERT_VAL(nm, label); \
DINO_MANUAL_REVERT_END() \

#else // !DINO

#define TASK_BOUNDARY(t) SET_CURTASK(t)
#define TASK_BOUNDARY(t, a)

#define DINO_RESTORE_CHECK()
#define DINO_MANUAL_VERSION_PTR(...)
#define DINO_MANUAL_VERSION_VAL(...)
#define DINO_MANUAL_RESTORE_NONE()
#define DINO_MANUAL_RESTORE_PTR(...)
#define DINO_MANUAL_RESTORE_VAL(...)
#define DINO_MANUAL_REVERT_BEGIN(...)
#define DINO_MANUAL_REVERT_END(...)
#define DINO_MANUAL_REVERT_VAL(...)

#endif // !DINO
#define SET_CURTASK(t) curtask = t


static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}
//__attribute__((always_inline))
void print_filter(fingerprint_t *filter)
{
	unsigned i;
	BLOCK_PRINTF_BEGIN();
	for (i = 0; i < NUM_BUCKETS; ++i) {
		BLOCK_PRINTF("%04x ", filter[i]);
		if (i > 0 && (i + 1) % 8 == 0){
			BLOCK_PRINTF("\r\n");
		}
	}
	BLOCK_PRINTF_END();
}

//__attribute__((always_inline))
void log_filter(fingerprint_t *filter)
{
	unsigned i;
	BLOCK_LOG_BEGIN();
	for (i = 0; i < NUM_BUCKETS; ++i) {
		BLOCK_LOG("%04x ", filter[i]);
		if (i > 0 && (i + 1) % 8 == 0)
			BLOCK_LOG("\r\n");
	}
	BLOCK_LOG_END();
}

// TODO: to avoid having to wrap every thing printf macro (to prevent
// a mementos checkpoint in the middle of it, which could be in the
// middle of an EDB energy guard), make printf functions in libio
// and exclude libio from Mementos passes
//__attribute__((always_inline))
void print_stats(unsigned inserts, unsigned members, unsigned total)
{
	PRINTF("stats: inserts %u members %u total %u\r\n",
			inserts, members, total);
	while (__loop_bound__(999),members != 32) {
	}
}

static __nv unsigned curtask;

//__attribute__((always_inline))
static hash_t djb_hash(uint8_t* data, unsigned len)
{
	uint32_t hash = 5381;
	unsigned int i;

	for(i = 0; __loop_bound__(2), i < len; data++, i++) {
		hash = ((hash << 5) + hash) + (*data);
	}

	return hash & 0xFFFF;
}

//__attribute__((always_inline))
static index_t hash_fp_to_index(fingerprint_t fp)
{
	hash_t hash = djb_hash((uint8_t *)&fp, sizeof(fingerprint_t));
	return hash & (NUM_BUCKETS - 1); // NUM_BUCKETS must be power of 2
}

//__attribute__((always_inline))
static index_t hash_key_to_index(value_t fp)
{
	hash_t hash = djb_hash((uint8_t *)&fp, sizeof(value_t));
	return hash & (NUM_BUCKETS - 1); // NUM_BUCKETS must be power of 2
}

//__attribute__((always_inline))
static fingerprint_t hash_to_fingerprint(value_t key)
{
	return djb_hash((uint8_t *)&key, sizeof(value_t));
}

//__attribute__((always_inline))
static value_t generate_key(value_t prev_key)
{
	// insert pseufo-random integers, for testing
	// If we use consecutive ints, they hash to consecutive DJB hashes...
	// NOTE: we are not using rand(), to have the sequence available to verify
	// that that are no false negatives (and avoid having to save the values).
	return (prev_key + 1) * 17;
}

//__attribute__((always_inline))
static bool insert(fingerprint_t *filter, value_t key)
{
	fingerprint_t fp1, fp2, fp_victim, fp_next_victim;
	index_t index_victim, fp_hash_victim;
	unsigned relocation_count = 0;

	fingerprint_t fp = hash_to_fingerprint(key);

	index_t index1 = hash_key_to_index(key);

	index_t fp_hash = hash_fp_to_index(fp);
	index_t index2 = index1 ^ fp_hash;

	LOG("insert: key %04x fp %04x h %04x i1 %u i2 %u\r\n",
			key, fp, fp_hash, index1, index2);

	fp1 = filter[index1];
	LOG("insert: fp1 %04x\r\n", fp1);
	if (!fp1) { // slot 1 is free
		filter[index1] = fp;
	} else {
		fp2 = filter[index2];
		LOG("insert: fp2 %04x\r\n", fp2);
		if (!fp2) { // slot 2 is free
			filter[index2] = fp;
		} else { // both slots occupied, evict
//			if (rand() & 0x80) { // don't use lsb because it's systematic
			if (rand() & 0x80) { // don't use lsb because it's systematic
				index_victim = index1;
				fp_victim = fp1;
			} else {
				index_victim = index2;
				fp_victim = fp2;
			}

			LOG("insert: evict [%u] = %04x\r\n", index_victim, fp_victim);
			filter[index_victim] = fp; // evict victim

			do { // relocate victim(s)
				__loop_bound__(8);
				fp_hash_victim = hash_fp_to_index(fp_victim);
				index_victim = index_victim ^ fp_hash_victim;

				fp_next_victim = filter[index_victim];
				filter[index_victim] = fp_victim;

				LOG("insert: moved %04x to %u; next victim %04x\r\n",
						fp_victim, index_victim, fp_next_victim);

				fp_victim = fp_next_victim;
			} while (fp_victim && ++relocation_count < MAX_RELOCATIONS);

			if (fp_victim) {
				PRINTF("insert: lost fp %04x\r\n", fp_victim);
				return false;
			}
		}
	}

	return true;
}

//__attribute__((always_inline))
static bool lookup(fingerprint_t *filter, value_t key)
{
	fingerprint_t fp = hash_to_fingerprint(key);

	index_t index1 = hash_key_to_index(key);

	index_t fp_hash = hash_fp_to_index(fp);
	index_t index2 = index1 ^ fp_hash;

	LOG("lookup: key %04x fp %04x h %04x i1 %u i2 %u\r\n",
			key, fp, fp_hash, index1, index2);
	LOG("f[%u] %04x f[%u] %04x\r\n",
			index1, filter[index1], index2, filter[index2]);

	return filter[index1] == fp || filter[index2] == fp;
}
unsigned overflow=0;
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

void init()
{
#ifdef BOARD_MSP_TS430
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
	//PRINTF(".%u.\r\n", curctx->cur_reg[15]);
}
#if 0
void write_stack(){
	unsigned j;
	__asm__ volatile ("MOV R1, %0" :"=m"(j)); // j = SP
	PRINTF("stack pointer: %u\r\n", j);
	//	char* sp;
	//	sp = (char*)j;
	//	for (unsigned ii=0; ii<500;++ii){
	//		sp-=2;
	//		*((unsigned*)(sp)) = 0x2222;
	//	}
}
void test_stack(){
	int a[300];
	for (unsigned i = 0; i < 300; i++){
		a[i] = 0;
	}
}
#define TOS 0x2400
void print_stack(){
	unsigned j;
	bool overflow = true;
	__asm__ volatile ("MOV R1, %0" :"=m"(j)); // j = SP
	char* sp;
	sp = (char*)j;
	PRINTF("stack address: %u\r\n", j); 
	for (unsigned ii=0; ii<500;++ii){
		sp-=2;
		PRINTF("stack value(%u): %u\r\n", (unsigned)sp, *((unsigned*)(sp)));
		if (*((unsigned*)(sp)) == 0x2222){
			PRINTF("used stack address up to %u\r\n", sp+2);
			PRINTF("max stack size is %u\r\n", TOS-(unsigned)sp-2);
			overflow = false;
			break;
		}
	}
	if(overflow){
		PRINTF("overflow!!\r\n");
	}
}
#endif
int main()
{

	unsigned i;
	value_t key;
	// Mementos can't handle globals: it restores them to .data, when they are
	// in .bss... So, for now, just keep all data on stack.

	// Can't use C initializer because it gets converted into
	// memset, but the memset linked in by GCC is of the wrong calling
	// convention, but we can't override with our own memset because C runtime
	// calls memset with GCC's calling convention. Catch 22.
	static fingerprint_t filter[NUM_BUCKETS];

	//	unsigned count = 0;
	while (1) {
		__loop_bound__(999);
		PRINTF("start\r\n");
		for (i = 0; i < NUM_BUCKETS; ++i)
			filter[i] = 0;

		key = INIT_KEY;
		unsigned inserts = 0;
		for (i = 0; i < NUM_KEYS; ++i) {
			key = generate_key(key);
			bool success = insert(filter, key);
			LOG("insert: key %04x success %u\r\n", key, success);
			if (!success)
				PRINTF("insert: key %04x failed\r\n", key);
			//log_filter(filter);

			inserts += success;

		}
		LOG("inserts/total: %u/%u\r\n", inserts, NUM_KEYS);

		key = INIT_KEY;
		unsigned members = 0;
		for (i = 0; i < NUM_KEYS; ++i) {
			key = generate_key(key);
			bool member = lookup(filter, key);
			LOG("lookup: key %04x member %u\r\n", key, member);
			if (!member) {
				fingerprint_t fp = hash_to_fingerprint(key);
				PRINTF("lookup: key %04x fp %04x not member\r\n", key, fp);
			}
			members += member;
		}
		LOG("members/total: %u/%u\r\n", members, NUM_KEYS);

		//PRINTF("REAL TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
		PRINTF("end\r\n");
		update_checkpoints_pair();
		PRINTF("chkpt cnt: %u\r\n", chkpt_count);
		PRINTF(".%u.\r\n", curctx->cur_reg[15]);
		print_filter(filter);
		print_stats(inserts, members, NUM_KEYS);
		//print_stack();
		//		count++;
		//		if(count == 5){
		//			count = 0;
		//			exit(0);
		//		}
	}

	return 0;
}
