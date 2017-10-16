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
#include <libalpaca/alpaca.h>

#ifdef CONFIG_EDB
#include <libedb/edb.h>
#else
#define ENERGY_GUARD_BEGIN()
#define ENERGY_GUARD_END()
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
	uint8_t a = 0x77;
	unsigned b = 0xFFFF;
	uint8_t c = 0x44;
	for (int i = 0; i < 500; ++i) {
		__loop_bound__(999);
		a = 1;
	}

	PRINTF("%u %u %u\r\n", a, b, c);
	PRINTF(".%u.\r\n", curctx->cur_reg[15]);
	return 0;
}

