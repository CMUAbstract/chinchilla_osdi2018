/* +++Date last modified: 05-Jul-1997 */

/*
 **  BITCNTS.C - Test program for bit counting functions
 **
 **  public domain by Bob Stout & Auke Reitsma
 */
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

#ifdef CONFIG_EDB
#include <libedb/edb.h>
#else
#define ENERGY_GUARD_BEGIN()
#define ENERGY_GUARD_END()
#endif

#include <libalpaca/alpaca.h>

#include "pins.h"
void __loop_bound__(unsigned val){};
static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}
void init()
{
	init_hw();
#ifdef CONFIG_EDB
	edb_init();
#endif
	INIT_CONSOLE();
	__enable_interrupt();
	PRINTF("a%u.\r\n", curctx->cur_reg[15]);
}

#define FUNCS  7

int bit_count(long x);
int bitcount(long i);
int ntbl_bitcount(long int x);
int BW_btbl_bitcount(long int x);
int AR_btbl_bitcount(long int x);
int ntbl_bitcnt(long x);
int btbl_bitcnt(long x);
static int bit_shifter(long int x);
static char bits[256] =
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
int ntbl_bitcnt(long x)
{
	int cnt = bits[(int)(x & 0x0000000FL)];

	//if (0L != (x >>= 4))
	//      cnt += ntbl_bitcnt(x);
	while (__loop_bound__(8), 0L != (x >>= 4)) {
		cnt += bits[(int)(x & 0x0000000FL)];
	}

	return cnt;
}

/*
 **  Count bits in each nybble
 **
 **  Note: Only the first 16 table entries are used, the rest could be
 **        omitted.
 */

int ntbl_bitcount(long int x)
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

/*
 **  Count bits in each byte
 **
 **  by Bruce Wedding, works best on Watcom & Borland
 */

int BW_btbl_bitcount(long int x)
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

/*
 **  Count bits in each byte
 **
 **  by Auke Reitsma, works best on Microsoft, Symantec, and others
 */

int AR_btbl_bitcount(long int x)
{
	unsigned char * Ptr = (unsigned char *) &x ;
	int Accu ;

	Accu  = bits[ *Ptr++ ];
	Accu += bits[ *Ptr++ ];
	Accu += bits[ *Ptr++ ];
	Accu += bits[ *Ptr ];
	return Accu;
}

int bitcount(long i)
{
	i = ((i & 0xAAAAAAAAL) >>  1) + (i & 0x55555555L);
	i = ((i & 0xCCCCCCCCL) >>  2) + (i & 0x33333333L);
	i = ((i & 0xF0F0F0F0L) >>  4) + (i & 0x0F0F0F0FL);
	i = ((i & 0xFF00FF00L) >>  8) + (i & 0x00FF00FFL);
	i = ((i & 0xFFFF0000L) >> 16) + (i & 0x0000FFFFL);
	return (int)i;
}

int bit_count(long x)
{
	int n = 0;
	/*
	 ** The loop will execute once for each bit of x set, this is in average
	 ** twice as fast as the shift/test method.
	 */
	if (x) do {
		__loop_bound__(32);
		n++;
	} while (0 != (x = x&(x-1))) ;
	return(n);
}

int main(void)
{
	int i;
	long j, n, seed;
	int iterations;
	static int (* pBitCntFunc[FUNCS])(long) = {
		bit_count,
		bitcount,
		ntbl_bitcnt,
		ntbl_bitcount,
		/*            btbl_bitcnt, DOESNT WORK*/
		BW_btbl_bitcount,
		AR_btbl_bitcount,
		bit_shifter
	};

	iterations=100;

	while (1) {
		__loop_bound__(999);
		PRINTF("start\r\n");
		for (i = 0; i < FUNCS; i++) {
			__loop_bound__(7);

			for (j = n = 0, seed = 3; j < iterations; j++, seed += 13) {
				__loop_bound__(100);
				n += pBitCntFunc[i](seed);
			}

			PRINTF("Bits: %u\n\r", n);
		}
		PRINTF("end\r\n");
	}
	return 0;
}

static int bit_shifter(long int x)
{
	int i, n;

	for (i = n = 0; __loop_bound__(32), x && (i < (sizeof(long) * 8)); ++i, x >>= 1) {
		n += (int)(x & 1L);
	}
	return n;
}


