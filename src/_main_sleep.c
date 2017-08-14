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

#include "pins.h"
uint8_t volatile test = 0;
void __attribute__((interrupt(PORT3_VECTOR))) Port3_ISR(void) {
	P3IE |= BIT5;
	P3IFG &= ~BIT5;                        
	P3IES &= ~BIT5;
	PMMCTL0_H = PMMPW_H;                      // open PMM
	PM5CTL0 &= ~LOCKLPM5;                       // Clear LOCKIO and enable ports
	PMMCTL0_H = 0x00;
	__bic_SR_register_on_exit(LPM4_bits);
}
//__attribute__((interrupt(51))) 
//	void TimerB1_ISR(void){
//		TBCTL &= ~(0x0002);
//		if(TBCTL && 0x0001){
//			overflow++;
//			TBCTL |= 0x0004;
//			TBCTL |= (0x0002);
//			TBCTL &= ~(0x0001);	
//		}
//	}
//__attribute__((section("__interrupt_vector_timer0_b1"),aligned(2)))
//void(*__vector_timer0_b1)(void) = TimerB1_ISR;
int main() {
	// disable watchdog
	WDTCTL = WDTPW + WDTHOLD;
	// enable gpio
	PM5CTL0 &= ~LOCKLPM5;
	// set clock
	CSCTL0_H = CSKEY_H;
	CSCTL1 = DCORSEL + DCOFSEL_3;
	CSCTL2 = SELA_0 | SELS_3 | SELM_3;
	CSCTL3 = DIVA_0 | DIVS_0 | DIVM_0;
	// enable interrupt
	__enable_interrupt();

	// set everything to gpio with out 0
	P1SEL0 = 0;P2SEL0 = 0;P3SEL0 = 0;P4SEL0 = 0;PJSEL0 = 0;
	P1SEL1 = 0;P2SEL1 = 0;P3SEL1 = 0;P4SEL1 = 0;PJSEL1 = 0;
	P1DIR = 0xFF;
	P2DIR = 0xFF;
	P3DIR = 0xFF;
	P3DIR = 0xFF;
	PJDIR = 0xFF;
	P1OUT = 0x00;P2OUT = 0x00;P3OUT = 0x00;P4OUT = 0x00;PJOUT = 0x00;

	unsigned count = 0;
	// Pin 3.4 is for showing progress
	//P3DIR |= BIT4;
	//	P3DIR &= BIT5;
	// make [in 3.5 to receive interrupt
	P3DIR &= ~BIT5;
	P3IE |= BIT5;
	P3IES &= ~BIT5;
	P3IFG &= ~BIT5;

	//	__bic_SR_register_on_exit(LPM4_bits)
	while (1) {
		// oscillate pin 3.4 to show progress
		P3OUT |= BIT4;
		P3OUT &= ~BIT4;
#if 1
		if (count == 1000) {
//			P3DIR |= BIT4;
			//
			//	P3DIR &= BIT5;
			//P3IE |= BIT5;
			//P3IES &= ~BIT5;
			//P3IFG &= ~BIT5;
			P1OUT = 0xFF;P2OUT = 0xFF;P4OUT = 0xFF;PJOUT = 0xFF;

//			PMMCTL0_H = PMMPW_H;                      // open PMM
//			PMMCTL0_L |= PMMREGOFF;
//			PMMCTL0_L &= ~SVSHE;
//			PMMCTL0_H = 0x00;
//  		// go to sleep
//			__bis_SR_register(LPM4_bits + GIE);
			count = 0;
		}
#endif
		count++;
	}
	//__bis_SR_register(LPM4_bits + GIE);

	//	PRINTF("wake up\r\n");

}

