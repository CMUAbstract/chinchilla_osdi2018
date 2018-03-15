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
#ifdef LOGIC
	// Output enabled
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_1);
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_2);
	GPIO(PORT_AUX3, DIR) |= BIT(PIN_AUX_3);
	//
	// Out high
	GPIO(PORT_AUX3, OUT) |= BIT(PIN_AUX_3);
	// Out low
	GPIO(PORT_AUX3, OUT) &= ~BIT(PIN_AUX_3);
#endif
	for (unsigned i = 0; i < LOOP_IDX; ++i) {

	}
}


#define N 500
#define K 20
// This is to avoid arrays ending up
// in .bss (for Ratchet)
__nv unsigned vec[N];
const unsigned kernel[K] =
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1
};
__nv unsigned out[N-K+1];

int main()
{
#ifdef RATCHET
	init();
	restore_regs();
#endif

	while (1) {
#ifdef LOGIC
		// Out high
		GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_1);
		// Out low
		GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
#endif
#ifdef CONFIG_EDB
		PRINTF("start\r\n");
#endif

		// init vec
		for (unsigned i = 0; i < N; ++i)
			vec[i] = i;

		// init out
		for (unsigned i = 0; i < N-K+1; ++i)
			out[i] = 0;

		// Convolution: 5 window LPF
		for (unsigned i = 0; i < N-K+1; ++i)
			for (unsigned j = 0; j < K; ++j)
				out[i] += vec[i+j]*kernel[K-(j+1)];

#ifdef CONFIG_EDB
		no_chkpt_start();
		BLOCK_PRINTF_BEGIN();
		for (unsigned i = 0; i < 5; ++i)
			BLOCK_PRINTF("%u ", out[i]);
		BLOCK_PRINTF("\r\n");
		BLOCK_PRINTF_END();
		no_chkpt_end();
#endif
#ifdef LOGIC
		// Out high
		GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_2);
		// Out low
		GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);
		// tmp
#ifndef RATCHET
		unsigned tmp = curctx->cur_reg[15];
#endif
#endif
		end_run();
	}
	return 0;
}
