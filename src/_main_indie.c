//#include <msp430.h>
#include <msp430fr5969.h>
#define TXD BIT2
#define RXD BIT1
int main(){
	WDTCTL = WDTPW + WDTHOLD;
  	PM5CTL0 &= ~LOCKLPM5;       // Lock LPM5.
	P4DIR |= BIT0;
	P4OUT |= BIT0;

	P2DIR = 0xFF; // All P2.x outputs<
	P2OUT &= 0x00; // All P2.x reset
	P1SEL |= RXD + TXD ; // P1.1 = RXD, P1.2=TXD
	P1SEL2 |= RXD + TXD ; // P1.1 = RXD, P1.2=TXD
	P1OUT &= 0x00;
	UCA0CTL1 |= UCSSEL_2; // SMCLK
	UCA0BR0 = 0x08; // 1MHz 115200
	UCA0BR1 = 0x00; // 1MHz 115200
	UCA0MCTL = UCBRS2 + UCBRS0; // Modulation UCBRSx = 5
	UCA0CTL1 &= ~UCSWRST; // **Initialize USCI state machine**
	UC0IE |= UCA0RXIE; // Enable USCI_A0 RX interrupt
	__bis_SR_register(CPUOFF + GIE); // Enter LPM0 w/ int until Byte RXed
	while (1)
	{ }
	return 0;
}
#pragma vector=USCIAB0TX_VECTOR
__interrupt void USCI0TX_ISR(void)
{
	P1OUT |= TXLED; 
	UCA0TXBUF = string[i++]; // TX next character 
	if (i == sizeof string - 1) // TX over? 
		UC0IE &= ~UCA0TXIE; // Disable USCI_A0 TX interrupt 
	P1OUT &= ~TXLED; } 

#pragma vector=USCIAB0RX_VECTOR 
__interrupt void USCI0RX_ISR(void) 
{ 
	P1OUT |= RXLED; 
	if (UCA0RXBUF == 'a') // 'a' received?
	{ 
		i = 0; 
		UC0IE |= UCA0TXIE; // Enable USCI_A0 TX interrupt 
		UCA0TXBUF = string[i++]; 
	} 
	P1OUT &= ~RXLED;
}
