//#include <stdio.h>
//#include "test1.h"
#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

#include <libwispbase/wisp-base.h>
#include <libalpaca/alpaca.h>
#include <libmspbuiltins/builtins.h>
#include <libio/log.h>
#include <libmsp/mem.h>
#include <libmsp/periph.h>
#include <libmsp/clock.h>
#include <libmsp/watchdog.h>
#include <libmsp/gpio.h>

#ifdef CONFIG_LIBEDB_PRINTF
#include <libedb/edb.h>
#endif

#include "pins.h"
static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}
void init()
{
	// only for timers
	//	*timer &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	//	*timer |= 0x0200; //set 9 to one (SMCLK)
	//	*timer |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	//	*timer &= 0xFFEF; //set bit 4 to zero
	//	*timer |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	//	*timer |= 0x0002; //interrupt enable
	//	*timer &= ~(0x0020); //set bit 5 to zero(halt!)
	init_hw();
#ifdef CONFIG_EDB
	edb_init();
#endif

	INIT_CONSOLE();
	__enable_interrupt();
//	PRINTF(".%u.\r\n", curctx->task->idx);
}
int g1=1;
__attribute__((always_inline))
int func(int a, int b){
	return a + b;
}

int main() {
	int x = 5;
	int z = x+g1;
	int c = func(x, z);
	if (c < 1){
		c = x + z;
	}
	else{
		c = x - z;
	}
	for (int i=0; i<7; i++) {
		int a = i+9;
//		for (int j=0; j<1; j++) {
//			for (int k=0; k<1; k++) {
//			}
//			int a = j*2;
//		}
		g1 = a;
	}
	g1 = 3;
	int t = z-4;
	g1 = 3;
	t = z-4;
	g1 = 3;
	t = z-4;
	g1 = 3;
	t = z-4;
	PRINTF("End! %u, %u, %u, %u, %u\r\n", x, z, c, t, g1);
}

