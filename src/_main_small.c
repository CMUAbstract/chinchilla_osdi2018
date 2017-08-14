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

#ifdef DINO
#include <libdino/dino.h>
#endif

//#include "libtemplog/templog.h"
//#include "libtemplog/print.h"

#include "pins.h"
static void init_hw()
{
    msp_watchdog_disable();
    msp_gpio_unlock();
    msp_clock_setup();
}
void init()
{
	init_hw();
//	WISP_init();
#ifdef CONFIG_EDB
    //debug_setup();
    edb_init();
#endif

    INIT_CONSOLE();

    __enable_interrupt();
	PRINTF("test1\r\n");
}
void __loop_bound__(unsigned i) {}
int main() {
	unsigned x = 0;
	unsigned y = 0;
	unsigned z = 0;
	for (unsigned i = 0; i < 2; ++i) {
		for (unsigned j = 0; j < 10; ++j) {
			y++;
		}
		x++;
		for (unsigned k = 0; k < 7777; ++k) {
			z++;
		}
	}
//	do {
//		__loop_bound__(10000); 
//		x++;
//	} while(x < 10000);
//	while (__loop_bound__(10000), true) {
//		x++;
//		if (x == 10000) {
//			break;
//		}
//	}

	PRINTF("%u, %u, %u\r\n", x, y, z);
}

