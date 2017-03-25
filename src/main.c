#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

#include <libwispbase/wisp-base.h>
//#include <wisp-base.h>
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

#define TEST_SAMPLE_DATA

#define NIL 0 // like NULL, but for indexes, not real pointers

#define DICT_SIZE         512
#define BLOCK_SIZE         64

#if 0 // These are largest Mementos with volatile vars can handle
#define DICT_SIZE         280
#define BLOCK_SIZE         16
#endif

#define NUM_LETTERS_IN_SAMPLE        2
#define LETTER_MASK             0x00FF
#define LETTER_SIZE_BITS             8
#define NUM_LETTERS (LETTER_MASK + 1)

unsigned overflow=0;
//__attribute__((interrupt(TIMERB1_VECTOR))) 
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

typedef unsigned index_t;
typedef unsigned letter_t;
typedef unsigned sample_t;
unsigned volatile *timer = &TBCTL;

// NOTE: can't use pointers, since need to ChSync, etc
typedef struct _node_t {
	letter_t letter; // 'letter' of the alphabet
	index_t sibling; // this node is a member of the parent's children list
	index_t child;   // link-list of children
} node_t;

	TASK(1, task_init)
	TASK(2, task_init_dict)
	TASK(3, task_sample)
	TASK(4, task_measure_temp)
	TASK(5, task_letterize)
	TASK(6, task_compress)
	TASK(7, task_find_sibling)
	TASK(8, task_add_node)
	TASK(9, task_add_insert)
	TASK(10, task_append_compressed)
	TASK(11, task_print)
TASK(12, task_done)

	GLOBAL_SB(letter_t, letter);
	GLOBAL_SB(unsigned, letter_idx);
#ifdef TEST_SAMPLE_DATA
	GLOBAL_SB(sample_t, prev_sample);
#endif
	GLOBAL_SB(index_t, out_len);
	GLOBAL_SB(index_t, node_count);
	GLOBAL_SB(node_t, dict, DICT_SIZE);
	GLOBAL_SB(sample_t, sample);
	GLOBAL_SB(index_t, sample_count);
	GLOBAL_SB(index_t, sibling);
	GLOBAL_SB(index_t, child);
	GLOBAL_SB(index_t, parent);
	GLOBAL_SB(index_t, parent_next);
	GLOBAL_SB(node_t, parent_node);
	GLOBAL_SB(node_t, compressed_data, BLOCK_SIZE);
	GLOBAL_SB(node_t, sibling_node);
	GLOBAL_SB(index_t, symbol);
	//void write_to_gbuf(const void *value, void* data_addr, size_t var_size){

	//}
static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	//	GPIO(1, DIR) |= BIT(0);
	//	GPIO(1, DIR) |= BIT(1);
	//	GPIO(1, DIR) |= BIT(2);
	GPIO(3, DIR) |= BIT(0);
	GPIO(3, DIR) |= BIT(1);
	GPIO(3, OUT) |= BIT(0);
	GPIO(3, OUT) &= ~BIT(1);
	msp_clock_setup();
}

void init()
{
#if 0
	TBCTL &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	TBCTL |= 0x0200; //set 9 to one (SMCLK)
	TBCTL |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	TBCTL &= 0xFFEF; //set bit 4 to zero
	TBCTL |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	TBCTL |= 0x0002; //interrupt enable
	//	TBCTL &= ~(0x0020); //set bit 5 to zero(halt!)
#endif
	//	*timer &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	//	*timer |= 0x0200; //set 9 to one (SMCLK)
	//	*timer |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	//	*timer &= 0xFFEF; //set bit 4 to zero
	//	*timer |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	//	*timer |= 0x0002; //interrupt enable
	//	*timer &= ~(0x0020); //set bit 5 to zero(halt!)
	init_hw();
	//	WISP_init();
#ifdef CONFIG_EDB
	//debug_setup();
	edb_init();
#endif

	INIT_CONSOLE();
	__enable_interrupt();
	//set_dirty_buf(&data, &data_dest, &data_size);
	//	set_dirty_buf();
	PRINTF(".%u.\r\n", curctx->task->idx);
}

static sample_t acquire_sample(letter_t prev_sample)
{
	//letter_t sample = rand() & 0x0F;
	letter_t sample = (prev_sample + 1) & 0x03;
	return sample;
}
unsigned nvram=0;
void task_init()
{
	GPIO(3, OUT) &= ~BIT(0);
	GPIO(3, OUT) |= BIT(1);
	LOG("init\r\n");
	GV(parent_next) = 0;

	LOG("init: start parent %u\r\n", GV(parent));

	GV(out_len) = 0;

	GV(letter) = 0;
#ifdef TEST_SAMPLE_DATA
	GV(prev_sample) = 0;
#endif
	GV(letter_idx) = 0;;

	GV(sample_count) = 1;

	TRANSITION_TO(task_init_dict);
}

void task_init_dict()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_letter);
	num_dirty_gv++;
	//
	LOG("init dict: letter %u\r\n", GV(letter));

	node_t node = {
		.letter = GV(letter),
		.sibling = NIL, // no siblings for 'root' nodes
		.child = NIL, // init an empty list for children
	};
	int i = GV(letter);	
	GV(dict, i) = node; // ------------------------------------->>>>BUG

	GV(letter)++;
	if (GV(letter) < NUM_LETTERS) {
		TRANSITION_TO(task_init_dict);
	} else {
		GV(node_count) = NUM_LETTERS;
		TRANSITION_TO(task_sample);
	} 

}

void task_sample()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_letter_idx);
	num_dirty_gv++;
	//
	LOG("sample: letter idx %u\r\n", GV(letter_idx));

	unsigned next_letter_idx = GV(letter_idx) + 1;
	if (next_letter_idx == NUM_LETTERS_IN_SAMPLE)
		next_letter_idx = 0;


	if (GV(letter_idx) == 0) {
		GV(letter_idx) = next_letter_idx;
		TRANSITION_TO(task_measure_temp);
	} else {
		GV(letter_idx) = next_letter_idx;
		TRANSITION_TO(task_letterize);
	}
}

void task_measure_temp()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_prev_sample);
	num_dirty_gv++;
	//
	//  TASK_PROLOGUE();

	sample_t prev_sample;

#ifdef TEST_SAMPLE_DATA
	prev_sample = GV(prev_sample);
#else
	prev_sample = 0;
#endif

	sample_t sample = acquire_sample(prev_sample);
	LOG("measure: %u\r\n", sample);

#ifdef TEST_SAMPLE_DATA
	prev_sample = sample;
	GV(prev_sample) = prev_sample;
#endif
	GV(sample) = sample;
	TRANSITION_TO(task_letterize);
}

void task_letterize()
{
	unsigned letter_idx = GV(letter_idx);
	if (letter_idx == 0)
		letter_idx = NUM_LETTERS_IN_SAMPLE;
	else
		letter_idx--;
	unsigned letter_shift = LETTER_SIZE_BITS * letter_idx;
	letter_t letter = (GV(sample) & (LETTER_MASK << letter_shift)) >> letter_shift;

	LOG("letterize: sample %x letter %x (%u)\r\n", GV(sample), letter, letter);

	GV(letter) = letter;
	TRANSITION_TO(task_compress);
}

void task_compress()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_sample_count);
	num_dirty_gv++;
	//
	// TASK_PROLOGUE();

	node_t parent_node;

	// pointer into the dictionary tree; starts at a root's child
	index_t parent = GV(parent_next);

	LOG("compress: parent %u\r\n", parent);

	parent_node = GV(dict, parent);

	LOG("compress: parent node: l %u s %u c %u\r\n", parent_node.letter, parent_node.sibling, parent_node.child);

	GV(sibling) = parent_node.child;

	// Send a full node instead of only the index to avoid the need for
	// task_add to channel the dictionary to self and thus avoid
	// duplicating the memory for the dictionary (premature opt?).
	// In summary: instead of self-channeling the whole array, we
	// proxy only one element of the array.
	//
	// NOTE: source of inefficiency: we execute this on every step of traversal
	// over the nodes in the tree, but really need this only for the last one.
	GV(parent_node) = parent_node; //------->> BUG HERE??????
	GV(parent) = parent;
	GV(child) = parent_node.child;

	GV(sample_count)++;

	TRANSITION_TO(task_find_sibling);
}

void task_find_sibling()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_sibling);
	num_dirty_gv++;
	//
	// TASK_PROLOGUE();

	node_t *sibling_node;

	LOG("find sibling: l %u s %u\r\n", GV(letter), GV(sibling));

	if (GV(sibling) != NIL) {
		// See comments in task_add_node about this split. It's a memory optimization.
		int i = GV(sibling);
		sibling_node = &GV(dict,i); 

		LOG("find sibling: l %u, sn: l %u s %u c %u\r\n", GV(letter),
				sibling_node->letter, sibling_node->sibling, sibling_node->child);

		if (sibling_node->letter == GV(letter)) { // found
			LOG("find sibling: found %u\r\n", GV(sibling));
			GV(parent_next) = GV(sibling);

			TRANSITION_TO(task_letterize);
		} else { // continue traversing the siblings
			if(sibling_node->sibling != 0){
				GV(sibling) = sibling_node->sibling;
				TRANSITION_TO(task_find_sibling);
			}
		}

	} 
	LOG("find sibling: not found\r\n");

	// Reset the node pointer into the dictionary tree to point to the
	// root's child corresponding to the letter we are about to insert
	// NOTE: The cast here relies on the fact that root's children are
	// initialized in by inserting them in order of the letter value.
	index_t starting_node_idx = (index_t)GV(letter);
	GV(parent_next) = starting_node_idx;

	// Add new node to dictionary tree, and, after that, append the
	// compressed symbol to the result
	//
	LOG("find sibling: child %u\r\n", GV(child));
	if (GV(child) == NIL) {
		TRANSITION_TO(task_add_insert);
	} else {
		TRANSITION_TO(task_add_node); 
	}
	//  }
}

void task_add_node()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_sibling);
	num_dirty_gv++;
	//
	// TASK_PROLOGUE();

	node_t *sibling_node;

	// This split is a memory optimization. It is to avoid having the
	// channel from init task allocate memory for the whole dict, and
	// instead to hold only the ones it actually modifies.
	//
	// NOTE: the init nodes do not come exclusively from the init task,
	// because they might be later modified.
	//if (sibling < NUM_LETTERS) {
	int i = GV(sibling);
	sibling_node = &GV(dict, i);

	LOG("add node: s %u, sn: l %u s %u c %u\r\n", GV(sibling),
			sibling_node->letter, sibling_node->sibling, sibling_node->child);

	if (sibling_node->sibling != NIL) {
		index_t next_sibling = sibling_node->sibling;
		GV(sibling) = next_sibling;
		TRANSITION_TO(task_add_node);

	} else { // found last sibling in the list

		LOG("add node: found last\r\n");

		node_t sibling_node_obj = *sibling_node;

		//		GV(sibling) = GV(sibling);
		GV(sibling_node) = sibling_node_obj;

		TRANSITION_TO(task_add_insert);
	}
}

void task_add_insert()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_node_count);
	num_dirty_gv++;
	//
	LOG("add insert: nodes %u\r\n", GV(node_count));

	if (GV(node_count) == DICT_SIZE) { // wipe the table if full
		while (1);
	}
	LOG("add insert: l %u p %u, pn l %u s %u c%u\r\n", GV(letter), GV(parent),
			GV(parent_node).letter, GV(parent_node).sibling, GV(parent_node).child);

	index_t child = GV(node_count);
	node_t child_node = {
		.letter = GV(letter),
		.sibling = NIL,
		.child = NIL,
	};

	if (GV(parent_node).child == NIL) { // the only child

		LOG("add insert: only child\r\n");

		node_t parent_node_obj = GV(parent_node);
		parent_node_obj.child = child;

		int i = GV(parent);
		GV(dict, i) = parent_node_obj;

	} else { // a sibling

		index_t last_sibling = GV(sibling);

		node_t last_sibling_node = GV(sibling_node);                   

		LOG("add insert: sibling %u\r\n", last_sibling);

		last_sibling_node.sibling = child;

		GV(dict, last_sibling) = last_sibling_node;
	}
	GV(dict, child) = child_node;

	GV(symbol) = GV(parent);

	GV(node_count)++;

	TRANSITION_TO(task_append_compressed);
}

void task_append_compressed()
{
	//
	*(data_size_base + num_dirty_gv) = sizeof(_global_out_len);
	num_dirty_gv++;
	//
	LOG("append comp: sym %u len %u \r\n", GV(symbol), GV(out_len));
	int i = GV(out_len);
	GV(compressed_data, i).letter = GV(symbol);

	if (++GV(out_len) == BLOCK_SIZE) {
		TRANSITION_TO(task_print);
	} else {
		TRANSITION_TO(task_sample);
	}
}

void task_print()
{
	unsigned i;

	PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
	BLOCK_PRINTF_BEGIN();
	BLOCK_PRINTF("compressed block:\r\n");
	for (i = 0; i < BLOCK_SIZE; ++i) {
		index_t index = GV(compressed_data, i).letter;
		BLOCK_PRINTF("%04x ", index);
		if (i > 0 && (i + 1) % 8 == 0)
			BLOCK_PRINTF("\r\n");
	}
	BLOCK_PRINTF("\r\n");
	BLOCK_PRINTF("rate: samples/block: %u/%u\r\n", GV(sample_count), BLOCK_SIZE);
	BLOCK_PRINTF_END();
	//TRANSITION_TO(task_sample); // restart app
	TRANSITION_TO(task_done); // for now just do one block
}

void task_done()
{
	GPIO(3, OUT) |= BIT(0);
	GPIO(3, OUT) &= ~BIT(1);
	for(unsigned i=0;i<10000;++i){
	}
	//WATCHPOINT(1);
#if TIME > 0
	//	PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);

#endif
	TRANSITION_TO(task_init);
}

	ENTRY_TASK(task_init)
INIT_FUNC(init)
