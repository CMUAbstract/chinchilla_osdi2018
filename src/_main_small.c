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
int g1=1;
__attribute__((always_inline))
int func(int a, int b){
	return a + b;
}
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
uint8_t* test(){
	return NULL;
}
typedef struct  _test_struct {
	int s_a;
	int s_b;
	int s_c;
} tstruct;
int main() {
	int x;
	int A[10];
	tstruct ts1;
	tstruct* pts = &ts1;
	pts->s_b = 1;
	A[2] = 1;
	*(test()) = 1;
	//A[0] = 1;
	for (int i = 0; i < 5; i++) {
		A[i]++;
	}
	int z = A[2];
	int zz = pts->s_b;
	int* p = A;
	int* p2 = p;
	(*p)++;

	PRINTF("%u\r\n", A[0]);
}

