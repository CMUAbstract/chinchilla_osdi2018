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
#include "pins.h"

void init()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();

    GPIO(PORT_LED_1, DIR) |= BIT(PIN_LED_1);
    //GPIO(PORT_LED_2, DIR) |= BIT(PIN_LED_2);
	INIT_CONSOLE();
	__enable_interrupt();
}

int main(){
	init();
	GPIO(PORT_LED_1, OUT) |= BIT(PIN_LED_1);
	//GPIO(PORT_LED_2, OUT) |= BIT(PIN_LED_2);

	while (1) {
		PRINTF("test\r\n");
	}
	return 0;
}
