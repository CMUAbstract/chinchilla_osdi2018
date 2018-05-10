#include <msp430.h>

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include <libmspbuiltins/builtins.h>
#ifdef LOGIC
#define LOG(...)
#define PRINTF(...)
#define BLOCK_PRINTF(...)
#define BLOCK_PRINTF_BEGIN(...)
#define BLOCK_PRINTF_END(...)
#define INIT_CONSOLE(...)
#else
#include <libio/log.h>
#endif
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

#ifdef ALPACA
#include <libalpaca/alpaca.h>
void no_chkpt_start(){};
void no_chkpt_end(){};
#endif
#ifdef RATCHET
#include <libratchet/ratchet.h>
#define no_chkpt_start()
#define no_chkpt_end()
#endif
#include "param.h"
#include "pins.h"
__nv uint32_t nv_cnt;
#define SEED 4L
#define ITER 100
#define CHAR_BIT 8
static const char bits[256] =
{
	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,  /* 0   - 15  */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 16  - 31  */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 32  - 47  */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 48  - 63  */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 64  - 79  */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 80  - 95  */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 96  - 111 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 112 - 127 */
	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,  /* 128 - 143 */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 144 - 159 */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 160 - 175 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 176 - 191 */
	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,  /* 192 - 207 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 208 - 223 */
	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,  /* 224 - 239 */
	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8   /* 240 - 255 */
};

// #define SHOW_PROGRESS_ON_LED
// #define BLOCK_DELAY


/* This is for progress reporting only */
__attribute__((interrupt(51)))
	void TimerB1_ISR(void){
		PMMCTL0 = PMMPW | PMMSWPOR;
		BITSET(TBCTL, TBCLR);
	}
__attribute__((section("__interrupt_vector_timer0_b1"),aligned(2)))
void(*__vector_timer0_b1)(void) = TimerB1_ISR;

static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}

void init()
{
	BITSET(TBCTL, (TBSSEL_1 | ID_3 | MC_2 | TBCLR));
	BITSET(TBCCTL1 , CCIE);
	TBCCR1 = 40;
#ifndef CONFIG_EDB
//		TBCTL &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
//		TBCTL |= 0x0200; //set 9 to one (SMCLK)
//		TBCTL |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
//		TBCTL &= 0xFFEF; //set bit 4 to zero
//		TBCTL |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
//		TBCTL |= 0x0002; //interrupt enable
#endif
	init_hw();
#ifdef CONFIG_EDB
	edb_init();
#endif

	INIT_CONSOLE();

	__enable_interrupt();
#ifdef LOGIC
	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);

	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
	GPIO(PORT_AUX3, OUT) &= ~BIT(PIN_AUX_3);
	// Output enabled
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_1);
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_2);
	GPIO(PORT_AUX3, DIR) |= BIT(PIN_AUX_3);
	//
	// Out high
	GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_2);
	// Out low
	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);
#else
#ifdef RATCHET
	if (cur_reg == regs_0) {
		PRINTF("%x\r\n", regs_1[0]);
	}
	else {
		PRINTF("%x\r\n", regs_0[0]);
	}
#else
	PRINTF("a%u.\r\n", curctx->cur_reg[15]);
#endif
#endif
}

/*
	 __attribute__((always_inline))
	 int btbl_bitcnt(uint32_t x)
	 {
	 int cnt = bits[ ((char *)&x)[0] & 0xFF ];

	 if (0L != (x >>= 8))
	 cnt += btbl_bitcnt(x);
	 return cnt;
	 }*/
unsigned bit_count(uint32_t x)
{
	unsigned n = 0;
	/*
	 ** The loop will execute once for each bit of x set, this is in average
	 ** twice as fast as the shift/test method.
	 */
	if (x) do {
		n++;
	} while (0 != (x = x&(x-1))) ;
	return n;
}
int bitcount(uint32_t i)
{
	i = ((i & 0xAAAAAAAAL) >>  1) + (i & 0x55555555L);
	i = ((i & 0xCCCCCCCCL) >>  2) + (i & 0x33333333L);
	i = ((i & 0xF0F0F0F0L) >>  4) + (i & 0x0F0F0F0FL);
	i = ((i & 0xFF00FF00L) >>  8) + (i & 0x00FF00FFL);
	i = ((i & 0xFFFF0000L) >> 16) + (i & 0x0000FFFFL);
	return (int)i;
}
int ntbl_bitcount(uint32_t x)
{
	return
		bits[ (int) (x & 0x0000000FUL)       ] +
		bits[ (int)((x & 0x000000F0UL) >> 4) ] +
		bits[ (int)((x & 0x00000F00UL) >> 8) ] +
		bits[ (int)((x & 0x0000F000UL) >> 12)] +
		bits[ (int)((x & 0x000F0000UL) >> 16)] +
		bits[ (int)((x & 0x00F00000UL) >> 20)] +
		bits[ (int)((x & 0x0F000000UL) >> 24)] +
		bits[ (int)((x & 0xF0000000UL) >> 28)];
}
int BW_btbl_bitcount(uint32_t x)
{
	union 
	{ 
		unsigned char ch[4]; 
		long y; 
	} U; 

	U.y = x; 

	return bits[ U.ch[0] ] + bits[ U.ch[1] ] + 
		bits[ U.ch[3] ] + bits[ U.ch[2] ]; 
}
int AR_btbl_bitcount(uint32_t x)
{
	unsigned char * Ptr = (unsigned char *) &x ;
	int Accu ;

	Accu  = bits[ *Ptr++ ];
	Accu += bits[ *Ptr++ ];
	Accu += bits[ *Ptr++ ];
	Accu += bits[ *Ptr ];
	return Accu;
}
//	__attribute__((always_inline))
//int ntbl_bitcnt(uint32_t x)
//{
//	//	LOG("ntbl\r\n");
//
//	int cnt = bits[(int)(x & 0x0000000FL)];
//
//	if (0L != (x >>= 4))
//		cnt += ntbl_bitcnt(x);
//
//	return cnt;
//}
//non-recursive form
int ntbl_bitcnt(uint32_t x)
{
	int cnt = bits[(int)(x & 0x0000000FL)];

	while (0L != (x >>= 4)) {
		cnt += bits[(int)(x & 0x0000000FL)];
	}

	return cnt;
}

static int bit_shifter(uint32_t x)
{
	int i, n;
	for (i = n = 0; x && (i < (sizeof(uint32_t) * CHAR_BIT)); ++i, x >>= 1)
		n += (int)(x & 1L);
	return n;
}
int main()
{
#ifdef RATCHET
	init();
	restore_regs();
#endif
	unsigned n_0, n_1, n_2, n_3, n_4, n_5, n_6;
	uint32_t seed;
	unsigned iter;
	unsigned func;

	while (1) {
		nv_cnt = 0;
#ifdef LOGIC
		// Out high
		GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_1);
		// Out low
		GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
#endif
		for (unsigned cnt = 0; cnt < 1; ++cnt) {
		//for (unsigned cnt = 0; cnt < 20; ++cnt) {
			n_0=0;
			n_1=0;
			n_2=0;
			n_3=0;
			n_4=0;
			n_5=0;
			n_6=0;
			PRINTF("start\r\n");
#ifndef CONFIG_EDB
			//		PRINTF("TIME start is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
#endif

			for (func = 0; func < 7; func++) {
				LOG("func: %u\r\n", func);
				seed = (uint32_t)SEED;
				if(func == 0){
					for(iter = 0; iter < ITER; ++iter, seed += 13){
						n_0 += bit_count(seed);
					}
				}
				else if(func == 1){
					for(iter = 0; iter < ITER; ++iter, seed += 13){
						n_1 += bitcount(seed);
					}
				}
				else if(func == 2){
					for(iter = 0; iter < ITER; ++iter, seed += 13){
						n_2 += ntbl_bitcnt(seed);
					}
				}
				else if(func == 3){
					for(iter = 0; iter < ITER; ++iter, seed += 13){
						n_3 += ntbl_bitcount(seed);
					}
				}
				else if(func == 4){
					for(iter = 0; iter < ITER; ++iter, seed += 13){
						n_4 += BW_btbl_bitcount(seed);
					}
				}
				else if(func == 5){
					for(iter = 0; iter < ITER; ++iter, seed += 13){
						n_5 += AR_btbl_bitcount(seed);
					}
				}
				else if(func == 6){
					for(iter = 0; iter < ITER; ++iter, seed += 13){
						n_6 += bit_shifter(seed);
					}
				}
			}

			PRINTF("end\r\n");
#ifndef CONFIG_EDB
			//		PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
#endif
			no_chkpt_start();
			BLOCK_PRINTF_BEGIN();
			BLOCK_PRINTF("%u\r\n", n_0);
			BLOCK_PRINTF("%u\r\n", n_1);
			BLOCK_PRINTF("%u\r\n", n_2);
			BLOCK_PRINTF("%u\r\n", n_3);
			BLOCK_PRINTF("%u\r\n", n_4);
			BLOCK_PRINTF("%u\r\n", n_5);
			BLOCK_PRINTF("%u\r\n", n_6);
			BLOCK_PRINTF_END();
			no_chkpt_end();
		}
#ifdef LOGIC
		// Out high
		//GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_2);
		// Out low
		//GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);
		// tmp
#ifndef RATCHET
		unsigned tmp = curctx->cur_reg[15];
#endif
#endif
		end_run();
		PRINTF("cnt:");
		PRINTF("%04x", (unsigned)((nv_cnt>>16) & 0xffff));
		PRINTF("%04x\r\n",nv_cnt & 0xffff);
		}
		return 0;
	}
