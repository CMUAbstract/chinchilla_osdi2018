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
#include <libmspmath/msp-math.h>

#ifdef CONFIG_EDB
#include <libedb/edb.h>
#else
#define ENERGY_GUARD_BEGIN()
#define ENERGY_GUARD_END()
#endif

#ifdef ALPACA
#include <libalpaca/alpaca.h>
#endif
#ifdef RATCHET
#include <libratchet/ratchet.h>
#endif


#undef N // conflicts with us

#include "param.h"
#include "pins.h"

// #define SHOW_PROGRESS_ON_LED
// #define BLOCK_DELAY


/* This is for progress reporting only */

void no_chkpt_start(){};
void no_chkpt_end(){};

//#define KEY_SIZE_BITS	256
#define KEY_SIZE_BITS	64
#define DIGIT_BITS       8 // arithmetic ops take 8-bit args produce 16-bit result
#define DIGIT_MASK       0x00ff
#define NUM_DIGITS       (KEY_SIZE_BITS / DIGIT_BITS)

#if NUM_DIGITS < 2
#error The modular reduction implementation requires at least 2 digits
#endif

#define PRINT_HEX_ASCII_COLS 8

/** @brief Type large enough to store a product of two digits */
typedef uint16_t digit_t;

/** @brief Multi-digit integer */
typedef unsigned bigint_t[NUM_DIGITS * 2];

typedef struct {
    bigint_t n; // modulus
    digit_t e;  // exponent
} pubkey_t;

// Blocks are padded with these digits (on the MSD side). Padding value must be
// chosen such that block value is less than the modulus. This is accomplished
// by any value below 0x80, because the modulus is restricted to be above
// 0x80 (see comments below).
static __ro_nv const uint8_t PAD_DIGITS[] = { 0x01 };
#define NUM_PAD_DIGITS (sizeof(PAD_DIGITS) / sizeof(PAD_DIGITS[0]))

// To generate a key pair: see scripts/

// modulus: byte order: LSB to MSB, constraint MSB>=0x80
static __ro_nv const pubkey_t pubkey = {
//#include "../data/key256.txt"
#include "../data/key64.txt"
};

static __ro_nv const unsigned char PLAINTEXT[] =
#include "../data/plaintext.txt"
;

#define NUM_PLAINTEXT_BLOCKS (sizeof(PLAINTEXT) / (NUM_DIGITS - NUM_PAD_DIGITS) + 1)
#define CYPHERTEXT_SIZE (NUM_PLAINTEXT_BLOCKS * NUM_DIGITS)

uint8_t CYPHERTEXT[CYPHERTEXT_SIZE] = {0};
unsigned CYPHERTEXT_LEN = 0;

// Store in NV memory to reduce RAM footprint (might not even fit in RAM)
// Except with Mementos, which cannot handle NV state. With mementos
// these are allocated on the stack. Allocting them on the stack as
// opposed to letting them be (volatile) globals is a workaround
// for Mementos including the read-only globals into the checkpoint,
// if it is told to include any globals at all.
#ifndef MEMENTOS
bigint_t in_block;
bigint_t out_block;
bigint_t qxn;
bigint_t product;
#endif
unsigned overflow=0;
#if ENERGY == 0
__attribute__((interrupt(51))) 
void TimerB1_ISR(void){
	TBCTL &= ~(0x0002);
	if(TBCTL && 0x0001){
		overflow++;
		TBCTL |= 0x0004;
		TBCTL |= (0x0002);
		TBCTL &= ~(0x0001);	
	}
}
__attribute__((section("__interrupt_vector_timer0_b1"),aligned(2)))
void(*__vector_timer0_b1)(void) = TimerB1_ISR;
#endif

//__attribute__((always_inline))
void print_bigint(const bigint_t n, unsigned digits)
{
    int i;
    for (i = digits - 1; i >= 0; --i) {
#if ENERGY == 0
        PRINTF("%02x ", n[i]);
#endif
		}
}

//__attribute__((always_inline))
void log_bigint(const bigint_t n, unsigned digits)
{
    int i;
    for (i = digits - 1; i >= 0; --i) {
#if ENERGY == 0
        BLOCK_LOG("%02x ", n[i]);
#endif
		}
}

//__attribute__((always_inline))
void print_hex_ascii(const uint8_t *m, unsigned len)
{
    int i, j;
#if ENERGY == 0
		no_chkpt_start();
		BLOCK_PRINTF_BEGIN();
    for (i = 0; i < len; i += PRINT_HEX_ASCII_COLS) {
        for (j = 0; j < PRINT_HEX_ASCII_COLS && i + j < len; ++j)
            BLOCK_PRINTF("%02x ", m[i + j]);
        for (; j < PRINT_HEX_ASCII_COLS; ++j)
            BLOCK_PRINTF("   ");
        BLOCK_PRINTF(" ");
        for (j = 0; j < PRINT_HEX_ASCII_COLS && i + j < len; ++j) {
            char c = m[i + j];
            if (!(32 <= c && c <= 127)) // not printable
                c = '.';
            BLOCK_PRINTF("%c", c);
        }
        BLOCK_PRINTF("\r\n");
    }
		BLOCK_PRINTF_END();
		no_chkpt_end();
#endif
}

//__attribute__((always_inline))
void mult(bigint_t a, bigint_t b, bigint_t product)
{
    int i;
    unsigned digit;
    digit_t p, c, dp;
    digit_t carry = 0;

    BLOCK_LOG_BEGIN();
    BLOCK_LOG("mult: a = "); log_bigint(a, NUM_DIGITS); BLOCK_LOG("\r\n");
    BLOCK_LOG("mult: b = "); log_bigint(b, NUM_DIGITS); BLOCK_LOG("\r\n");
    BLOCK_LOG_END();

    for (digit = 0; digit < NUM_DIGITS * 2; ++digit) {
        LOG("mult: d=%u\r\n", digit);

        p = carry;
        c = 0;
        for (i = 0; i < NUM_DIGITS; ++i) {
            if (i <= digit && digit - i < NUM_DIGITS) {
                dp = a[digit - i] * b[i];

                c += dp >> DIGIT_BITS;
                p += dp & DIGIT_MASK;

                LOG("mult: i=%u a=%x b=%x dp=%x p=%x\r\n", i, a[digit - i], b[i], dp, p);
            }
        }

        c += p >> DIGIT_BITS;
        p &= DIGIT_MASK;

        product[digit] = p;
        carry = c;
    }

    BLOCK_LOG_BEGIN();
    BLOCK_LOG("mult: product = ");
    log_bigint(product, 2 * NUM_DIGITS);
    BLOCK_LOG("\r\n");
    BLOCK_LOG_END();

//		for (i = 0; i < 2 * NUM_DIGITS; ++i) {
//			a[i] = product[i];
//		}
}

//__attribute__((always_inline))
bool reduce_normalizable(bigint_t m, const bigint_t n, unsigned d)
{
	int i;
	unsigned offset;
	digit_t n_d;
	bool normalizable = true;

	offset = d + 1 - NUM_DIGITS; // TODO: can this go below zero
	LOG("reduce: normalizable: d=%u offset=%u\r\n", d, offset);

	for (i = d; i >= 0; --i) {// arb num
		LOG("normalizable: m[%u]=%x n[%u]=%x\r\n", i, m[i], i - offset, n[i-offset]);

		if (m[i] > n[i-offset]) {
			break;
		} else if (m[i] < n[i-offset]) {
			normalizable = false;
			break;
		}
	}

	LOG("normalizable: %u\r\n", normalizable);

	return normalizable;
}

//__attribute__((always_inline))
void reduce_normalize(bigint_t m, const bigint_t n, unsigned digit)
{
	int i;
	digit_t d, s, m_d, n_d;
	unsigned borrow, offset;

	offset = digit + 1 - NUM_DIGITS; // TODO: can this go below zero

	borrow = 0;
	for (i = 0; i < NUM_DIGITS; ++i) {
		m_d = m[i + offset];
		n_d = n[i];

		s = n_d + borrow;
		if (m_d < s) {
			m_d += 1 << DIGIT_BITS;
			borrow = 1;
		} else {
			borrow = 0;
		}
		d = m_d - s;

		LOG("normalize: m[%u]=%x n[%u]=%x b=%u d=%x\r\n",
				i + offset, m_d, i, n_d, borrow, d);

		m[i + offset] = d;
	}
}

//__attribute__((always_inline))
void reduce_quotient(digit_t *quotient, bigint_t m, const bigint_t n, unsigned d)
{
	digit_t q, n_div;
	uint32_t n_q, qn;
	uint16_t m_dividend;

	// Divisor, derived from modulus, for refining quotient guess into exact value
	n_div = ((n[NUM_DIGITS - 1] << DIGIT_BITS) + n[NUM_DIGITS - 2]);

	LOG("reduce: quotient: r_n=%x m[d]=%x\r\n", n[NUM_DIGITS-1], m[d]);

	// Choose an initial guess for quotient
	if (m[d] == n[NUM_DIGITS - 1]) {
		q = (1 << DIGIT_BITS) - 1;
	} else {
		// TODO: The long todo described below applies here.
		q = ((m[d] << DIGIT_BITS) + m[d-1]) / n[NUM_DIGITS - 1];
		LOG("reduce quotient: m_dividend=%x q=%x\r\n", m_dividend, q);
	}

	// Refine quotient guess

	// TODO: An alternative to composing the digits into one variable, is to
	// have a loop that does the comparison digit by digit to implement the
	// condition of the while loop below.
	n_q = ((uint32_t)m[d] << (2 * DIGIT_BITS)) + (m[d-1] << DIGIT_BITS) + m[d-2];

	LOG("reduce: quotient: m[d]=%x m[d-1]=%x m[d-2]=%x n_q=%02x%02x\r\n",
			m[d], m[d-1], m[d-2],
			(uint16_t)((n_q >> 16) & 0xffff), (uint16_t)(n_q & 0xffff));

	LOG("reduce: quotient: q0=%x\r\n", q);

	q++;
	do {
		q--;
		// NOTE: yes, this result can be >16-bit because:
		//   n_n min = 0x80 (by constraint on modulus msb being set)
		//   => q max = 0xffff / 0x80 = 0x1ff
		//   n_div max = 0x80ff
		//   => qn max = 0x80ff * 0x1ff = 0x1017d01
		//
		// TODO:
		//
		// Approach (1): stick to 16-bit operations, and implement any wider
		// ops as part of this application, ie. a function operating on digits.
		//
		// Approach (2)*: implement the needed intrinsics in Clang's compiler-rt,
		// using libgcc's ones for inspiration (watching the calling convention
		// carefully).
		//
		qn = mult16(n_div, q);
		LOG("reduce: quotient: q=%x n_div=%x qn=%02x%02x\r\n", q, n_div,
				(uint16_t)((qn >> 16) & 0xffff), (uint16_t)(qn & 0xffff));
	} while (qn > n_q);

	// This is still not the final quotient, it may be off by one,
	// which we determine and fix in the 'compare' and 'add' steps.
	LOG("reduce: quotient: q=%x\r\n", q);

	*quotient = q;
}

//__attribute__((always_inline))
void reduce_multiply(bigint_t product, digit_t q, const bigint_t n, unsigned d)
{
	int i;
	unsigned offset, c;
	digit_t p, nd;

	// TODO: factor out shift outside of this task
	// As part of this task, we also perform the left-shifting of the q*m
	// product by radix^(digit-NUM_DIGITS), where NUM_DIGITS is the number
	// of digits in the modulus. We implement this by fetching the digits
	// of number being reduced at that offset.
	offset = d - NUM_DIGITS;
	LOG("reduce: multiply: offset=%u\r\n", offset);

	// Left-shift zeros
	for (i = 0; i < offset; ++i)
		product[i] = 0;

	c = 0;
	for (i = offset; i < 2 * NUM_DIGITS; ++i) {
		// This condition creates the left-shifted zeros.
		// TODO: consider adding number of digits to go along with the 'product' field,
		// then we would not have to zero out the MSDs
		p = c;
		if (i < offset + NUM_DIGITS) {
			nd = n[i - offset];
			p += q * nd;
		} else {
			nd = 0;
			// TODO: could break out of the loop  in this case (after CHAN_OUT)
		}

		LOG("reduce: multiply: n[%u]=%x q=%x c=%x m[%u]=%x\r\n",
				i - offset, nd, q, c, i, p);

		c = p >> DIGIT_BITS;
		p &= DIGIT_MASK;

		product[i] = p;
	}

	BLOCK_LOG_BEGIN();
	BLOCK_LOG("reduce: multiply: product = ");
	log_bigint(product, 2 * NUM_DIGITS);
	BLOCK_LOG("\r\n");
	BLOCK_LOG_END();
}

//__attribute__((always_inline))
int reduce_compare(bigint_t a, bigint_t b)
{
	LOG("reduce: compare\r\n");
	int i;
	int relation = 0;

	for (i = NUM_DIGITS * 2 - 1; i >= 0; --i) {
		LOG("reduce: compare: m[%u]=%x qn[%u]=%x\r\n", i, a[i], i, b[i]);
		if (a[i] > b[i]) {
			relation = 1;
			break;
		} else if (a[i] < b[i]) {
			relation = -1;
			break;
		}
	}
	LOG("reduce: compare: relation %d\r\n", relation);
	return relation;
}

//__attribute__((always_inline))
void reduce_add(bigint_t a, const bigint_t b, unsigned d)
{
	int i, j;
	unsigned offset, c;
	digit_t r, m, n;

	// TODO: factor out shift outside of this task
	// Part of this task is to shift modulus by radix^(digit - NUM_DIGITS)
	offset = d - NUM_DIGITS;

	c = 0;
	for (i = offset; i < 2 * NUM_DIGITS; ++i) {
		m = a[i];

		// Shifted index of the modulus digit
		j = i - offset;

		if (i < offset + NUM_DIGITS) {
			n = b[j];
		} else {
			n = 0;
			j = 0; // a bit ugly, we want 'nan', but ok, since for output only
			// TODO: could break out of the loop in this case (after CHAN_OUT)
		}

		r = c + m + n;

		LOG("reduce: add: m[%u]=%x n[%u]=%x c=%x r=%x\r\n", i, m, j, n, c, r);

		c = r >> DIGIT_BITS;
		r &= DIGIT_MASK;

		a[i] = r;
	}

	BLOCK_LOG_BEGIN();
	BLOCK_LOG("reduce: add: sum = ");
	log_bigint(a, 2 * NUM_DIGITS);
	BLOCK_LOG("\r\n");
	BLOCK_LOG_END();
}

//__attribute__((always_inline))
void reduce_subtract(bigint_t a, bigint_t b, unsigned d)
{
	int i;
	digit_t m, s, r, qn;
	unsigned borrow, offset;

	// TODO: factor out shifting logic from this task
	// The qn product had been shifted by this offset, no need to subtract the zeros
	offset = d - NUM_DIGITS;

	LOG("reduce: subtract: d=%u offset=%u\r\n", d, offset);

	borrow = 0;
	for (i = offset; i < 2 * NUM_DIGITS; ++i) {
		m = a[i];

		qn = b[i];

		s = qn + borrow;
		if (m < s) {
			m += 1 << DIGIT_BITS;
			borrow = 1;
		} else {
			borrow = 0;
		}
		r = m - s;

		LOG("reduce: subtract: m[%u]=%x qn[%u]=%x b=%u r=%x\r\n",
				i, m, i, qn, borrow, r);

		a[i] = r;
	}

	BLOCK_LOG_BEGIN();
	BLOCK_LOG("reduce: subtract: sum = ");
	log_bigint(a, 2 * NUM_DIGITS);
	BLOCK_LOG("\r\n");
	BLOCK_LOG_END();
}

//__attribute__((always_inline))
void reduce(bigint_t m, const bigint_t n)
{
	digit_t q;
	unsigned d;

	// Start reduction loop at most significant non-zero digit
	d = 2 * NUM_DIGITS;
	do {
		d--;
		LOG("reduce digits: p[%u]=%x\r\n", d, m[d]);
	} while (m[d] == 0 && d > 0);

	LOG("reduce digits: d=%x\r\n", d);

	if (reduce_normalizable(m, n, d)) {
		reduce_normalize(m, n, d);
	} else if (d == NUM_DIGITS - 1) {
		LOG("reduce: done: message < modulus\r\n");
		return;
	}

	while (d >= NUM_DIGITS) {
		reduce_quotient(&q, m, n, d);
		reduce_multiply(qxn, q, n, d);
		if (reduce_compare(m, qxn) < 0)
			reduce_add(m, n, d);
		reduce_subtract(m, qxn, d);
		d--;
	}

	BLOCK_LOG_BEGIN();
	BLOCK_LOG("reduce: num = ");
	log_bigint(m, NUM_DIGITS);
	BLOCK_LOG("\r\n");
	BLOCK_LOG_END();
}

void mod_mult(bigint_t a, bigint_t b, const bigint_t n, bigint_t product)
{
	mult(a, b, product);
	reduce(product, n);
}

void mod_exp(bigint_t out_block, bigint_t base, digit_t e, const bigint_t n)
{
	bigint_t product;
	int i;

	// Result initialized to 1
	out_block[0] = 0x1;
	for (i = 1; i < NUM_DIGITS; ++i)
		out_block[i] = 0x0;

	while (e > 0) { //arbitrary bound
		LOG("mod exp: e=%x\r\n", e);

		if (e & 0x1) {
			e >>= 1;
			mod_mult(out_block, base, n, product);
			for (unsigned i = 0; i < NUM_DIGITS; ++i)
				out_block[i] = product[i];
			if (e <= 0) {
				break;
			}
			else {
				mod_mult(base, base, n, product);
				for (unsigned i = 0; i < NUM_DIGITS; ++i)
					base[i] = product[i];
			}
		}
		else {
			e >>= 1;
			mod_mult(base, base, n, product);
			for (unsigned i = 0; i < NUM_DIGITS; ++i)
				base[i] = product[i];
		}
	}
}

void encrypt(uint8_t *cyphertext, unsigned *cyphertext_len,
		const uint8_t *message, unsigned message_length,
		const pubkey_t *k)
{
	int i;
	unsigned in_block_offset, out_block_offset;

	in_block_offset = 0;
	out_block_offset = 0;
	LOG("cyphertext len: %u\r\n", message_length);
	while (in_block_offset < message_length) { //arb bound
		LOG("Blk offset: %u\r\n", in_block_offset);

		for (i = 0; i < NUM_DIGITS - NUM_PAD_DIGITS; ++i)
			in_block[i] = (in_block_offset + i < message_length) ?
				message[in_block_offset + i] : 0xFF;
		for (i = 0; i < NUM_PAD_DIGITS; ++i)
			in_block[NUM_DIGITS - NUM_PAD_DIGITS + i] = PAD_DIGITS[i];

		//        BLOCK_LOG_BEGIN();
		//        BLOCK_LOG("in block: ");
		//        log_bigint(in_block, NUM_DIGITS);
		//        BLOCK_LOG("\r\n");
		//        BLOCK_LOG_END();

		mod_exp(out_block, in_block, k->e, k->n);

		//BLOCK_LOG_BEGIN();
		//BLOCK_LOG("out block: ");
		//log_bigint(out_block, NUM_DIGITS);
		//BLOCK_LOG("\r\n");
		//BLOCK_LOG_END();

		for (i = 0; i < NUM_DIGITS; ++i)
			cyphertext[out_block_offset + i] = out_block[i];

		in_block_offset += NUM_DIGITS - NUM_PAD_DIGITS;
		out_block_offset += NUM_DIGITS;
		LOG("Blk offset after: %u\r\n", in_block_offset);

	}

	*cyphertext_len = out_block_offset;
}
static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}

void init()
{
#ifndef CONFIG_EDB
	TBCTL &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	TBCTL |= 0x0200; //set 9 to one (SMCLK)
	TBCTL |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	TBCTL &= 0xFFEF; //set bit 4 to zero
	TBCTL |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	TBCTL |= 0x0002; //interrupt enable
#endif
	init_hw();
#ifdef CONFIG_EDB
	edb_init();
#endif

	INIT_CONSOLE();

	__enable_interrupt();
	//EIF_PRINTF(".%u.\r\n", curtask);
	PRINTF("a%u.\r\n", curctx->cur_reg[15]);
	for (unsigned i = 0; i < LOOP_IDX; ++i) {

	}
}

int main()
{
#ifdef RATCHET
	init();
	restore_regs();
#endif
	unsigned message_length;

	message_length = sizeof(PLAINTEXT) - 1; // exclude null byte

	while (1) {
#if ENERGY == 0
		PRINTF("start\r\n");
#endif
		PRINTF("TIME start is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
		encrypt(CYPHERTEXT, &CYPHERTEXT_LEN, PLAINTEXT, message_length, &pubkey);

		PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
#if ENERGY == 0
		PRINTF("end\r\n");
#endif
		end_run();
		//PRINTF("chkpt cnt: %u\r\n", chkpt_count);
		print_hex_ascii(CYPHERTEXT, CYPHERTEXT_LEN);
	}

	return 0;
}
