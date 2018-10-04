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

#ifdef CHINCHILLA
#include <libchinchilla/chinchilla.h>
#endif
#ifdef RATCHET
#include <libratchet/ratchet.h>
#endif
#if ENERGY == 1
#include <libedb/edb.h>
#endif

#include "param.h"
#include "pins.h"

#define TIMER 0

#if TIMER == 1
__attribute__((interrupt(51)))
	void TimerB1_ISR(void){
		PMMCTL0 = PMMPW | PMMSWPOR;
		BITSET(TBCTL, TBCLR);
	}
__attribute__((section("__interrupt_vector_timer0_b1"),aligned(2)))
void(*__vector_timer0_b1)(void) = TimerB1_ISR;
#endif

//__nv uint32_t nv_cnt;
#define TEST_SAMPLE_DATA

#define NIL 0 // like NULL, but for indexes, not real pointers

#define DICT_SIZE         512
#define BLOCK_SIZE         64

#define NUM_LETTERS_IN_SAMPLE        2
#define LETTER_MASK             0x00FF
#define LETTER_SIZE_BITS             8
#define NUM_LETTERS (LETTER_MASK + 1)
typedef unsigned index_t;
typedef unsigned letter_t;
typedef unsigned sample_t;
// NOTE: can't use pointers, since need to ChSync, etc
typedef struct _node_t {
	letter_t letter; // 'letter' of the alphabet
	index_t sibling; // this node is a member of the parent's children list
	index_t child;   // link-list of children
} node_t;

typedef struct _dict_t {
	node_t nodes[DICT_SIZE];
	unsigned node_count;
} dict_t;

typedef struct _log_t {
	index_t data[BLOCK_SIZE];
	unsigned count;
	unsigned sample_count;
} log_t;
//__attribute__((always_inline))
void print_log(log_t *log)
{
	unsigned i;
#if ENERGY == 0
	BLOCK_PRINTF_BEGIN();
	BLOCK_PRINTF("rate: samples/block: %u/%u\r\n",
			log->sample_count, log->count);
	//	BLOCK_PRINTF("compressed block:\r\n");
	//	for (i = 0; __loop_bound__(64),i < log->count; ++i) {
	//
	//		BLOCK_PRINTF("%04x ", log->data[i]);
	//		if (i > 0 && ((i + 1) & (8 - 1)) == 0){
	//		}
	//		BLOCK_PRINTF("\r\n");
	//	}
	//	if ((log->count & (8 - 1)) != 0){
	//	}
	//	BLOCK_PRINTF("\r\n");
	BLOCK_PRINTF_END();
#endif
	if (log->sample_count != 353) {
		exit(0);
	}
}

static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}
#if OVERHEAD > 0
bool restored = 0;
uint32_t counter = 0;
#endif
sample_t acquire_sample(letter_t prev_sample)
{
	//letter_t sample = rand() & 0x0F;
	letter_t sample = (prev_sample + 1) & 0x03;
	return sample;
}

void init_dict(dict_t *dict)
{
	letter_t l;

	LOG("init dict\r\n");
	dict->node_count = 0;

	for (l = 0; l < NUM_LETTERS; ++l) {
		node_t *node = &dict->nodes[l];
		node->letter = l;
		node->sibling = 0;
		node->child = 0;

		dict->node_count++;
	}
}

index_t find_child(letter_t letter, index_t parent, dict_t *dict)
{
	node_t *parent_node = &dict->nodes[parent];

	LOG("find child: l %u p %u c %u\r\n", letter, parent, parent_node->child);

	if (parent_node->child == NIL) {
		LOG("find child: not found (no children)\r\n");
		return NIL;
	}

	index_t sibling = parent_node->child;
	while (sibling != NIL) { //bound: temp

		node_t *sibling_node = &dict->nodes[sibling];

		LOG("find child: l %u, s %u l %u s %u\r\n", letter,
				sibling, sibling_node->letter, sibling_node->sibling);

		if (sibling_node->letter == letter) { // found
			LOG("find child: found %u\r\n", sibling);
			return sibling;
		} else {
			sibling = sibling_node->sibling;
		}
	}

	LOG("find child: not found (no match)\r\n");
	return NIL;
}

void add_node(letter_t letter, index_t parent, dict_t *dict)
{
	if (dict->node_count == DICT_SIZE) {
#if ENERGY == 0
		PRINTF("add node: table full\r\n");
#endif
	}
	// Initialize the new node
	node_t *node = &dict->nodes[dict->node_count];

	node->letter = letter;
	node->sibling = NIL;
	node->child = NIL;

	index_t node_index = dict->node_count++;

	index_t child = dict->nodes[parent].child;

	LOG("add node: i %u l %u, p: %u pc %u\r\n",
			node_index, letter, parent, child);

	if (child) {
		LOG("add node: is sibling\r\n");

		// Find the last sibling in list
		index_t sibling = child;
		node_t *sibling_node = &dict->nodes[sibling];
		while (sibling_node->sibling != NIL) { //temp bound for test
			LOG("add node: sibling %u, l %u s %u\r\n",
					sibling, letter, sibling_node->sibling);
			sibling = sibling_node->sibling;
			sibling_node = &dict->nodes[sibling];
		}

		// Link-in the new node
		LOG("add node: last sibling %u\r\n", sibling);
		dict->nodes[sibling].sibling = node_index;
	} else {
		LOG("add node: is only child\r\n");
		dict->nodes[parent].child = node_index;
	}
}

void append_compressed(index_t parent, log_t *log)
{
	LOG("append comp: p %u cnt %u\r\n", parent, log->count);
	log->data[log->count++] = parent;
}

void init()
{
#if TIMER == 1
	BITSET(TBCTL, (TBSSEL_1 | ID_3 | MC_2 | TBCLR));
	BITSET(TBCCTL1 , CCIE);
	TBCCR1 = 40;
#endif
	init_hw();

#if ENERGY == 1
	edb_init();
#endif

	INIT_CONSOLE();

	__enable_interrupt();
#ifdef LOGIC
	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);

	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
	GPIO(PORT_AUX3, OUT) &= ~BIT(PIN_AUX_3);
	// Output enabled
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_1);
	GPIO(PORT_AUX, DIR) |= BIT(PIN_AUX_2);
	GPIO(PORT_AUX3, DIR) |= BIT(PIN_AUX_3);

	// Out high
	GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_2);
	// Out low
	GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);
#else
#ifdef RATCHET
	PRINTF("reboot\r\n");
#else
	PRINTF("%x\r\n", curctx->cur_reg[0]);
#endif
#endif
}

int main()
{
#ifdef RATCHET
	init();
	restore_regs();
#endif

#ifndef RATCHET
	dict_t dict;
	log_t log;
#else
	// my ratchet cannot use .bss
	static __nv dict_t dict;
	static __nv log_t log;
#endif
	while (1) {
#ifdef LOGIC
		// Out high
		GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_1);
		// Out low
		GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_1);
#endif
		for (unsigned cnt = 0; cnt < LOOP_IDX; ++cnt) {
#if ENERGY == 0
			//PRINTF("start: \r\n");
#endif
			init_dict(&dict);
			// Initialize the pointer into the dictionary to one of the root nodes
			// Assume all streams start with a fixed prefix ('0'), to avoid having
			// to letterize this out-of-band sample.
			letter_t letter = 0;

			unsigned letter_idx = 0;
			index_t parent, child;
			sample_t sample, prev_sample = 0;

			log.sample_count = 1; // count the initial sample (see above)
			log.count = 0; // init compressed counter

			while (1) {

				child = (index_t)letter; // relyes on initialization of dict
				LOG("compress: parent %u\r\n", child); // naming is odd due to loop

				if (letter_idx == 0) {
					sample = acquire_sample(prev_sample);
					prev_sample = sample;
				}
				LOG("letter index: %u\r\n", letter_idx);
				letter_idx++;
				if (letter_idx == NUM_LETTERS_IN_SAMPLE)
					letter_idx = 0;
				do {
					unsigned letter_idx_tmp = (letter_idx == 0) ? NUM_LETTERS_IN_SAMPLE : letter_idx - 1; 

					unsigned letter_shift = LETTER_SIZE_BITS * letter_idx_tmp;
					letter = (sample & (LETTER_MASK << letter_shift)) >> letter_shift;
					LOG("letterize: sample %x letter %x (%u)\r\n",
							sample, letter, letter);

					log.sample_count++;
					parent = child;
					child = find_child(letter, parent, &dict);
					LOG("child: %u\r\n", child);
				} while (child != NIL);

				append_compressed(parent, &log);
				add_node(letter, parent, &dict);

				if (log.count == BLOCK_SIZE) {
					print_log(&log);
					log.count = 0;
					log.sample_count = 0;

#if ENERGY == 0
					//PRINTF("end\r\n");
#endif
					break;
				}
			}
		}
#ifdef LOGIC
		// Out high
		GPIO(PORT_AUX, OUT) |= BIT(PIN_AUX_2);
		// Out low
		GPIO(PORT_AUX, OUT) &= ~BIT(PIN_AUX_2);
#ifndef RATCHET
		unsigned tmp = curctx->cur_reg[15];
#endif
#endif
		end_run();
	}
	return 0;
}
