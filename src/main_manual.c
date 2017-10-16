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

#include <libalpaca/alpaca.h>

#include "pins.h"
#define CBW(var) check_before_write(&var, sizeof(var))
void __loop_bound__(unsigned val){};
unsigned overflow=0;
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
#define TEST_SAMPLE_DATA

/* This is for progress reporting only */
#define SET_CURTASK(t) curtask = t

#define TASK_MAIN                   0
#define TASK_INIT_DICT              1
#define TASK_COMPRESS               2
#define TASK_SAMPLE                 3
#define TASK_FIND_CHILD             4
#define TASK_FIND_SIBLING           5
#define TASK_ADD_NODE               6
#define TASK_ADD_NODE_INIT          7
#define TASK_ADD_NODE_FIND_LAST     8
#define TASK_ADD_NODE_LINK_SIBLING  9
#define TASK_ADD_NODE_LINK_CHILD   10
#define TASK_APPEND_COMPRESSED     11
#define TASK_PRINT                 12

#ifdef DINO

#define TASK_BOUNDARY(t) \
	DINO_TASK_BOUNDARY(NULL); \
SET_CURTASK(t); \

#define DINO_MANUAL_RESTORE_NONE() \
	DINO_MANUAL_REVERT_BEGIN() \
DINO_MANUAL_REVERT_END() \

#define DINO_MANUAL_RESTORE_PTR(nm, type) \
	DINO_MANUAL_REVERT_BEGIN() \
DINO_MANUAL_REVERT_PTR(type, nm); \
DINO_MANUAL_REVERT_END() \

#define DINO_MANUAL_RESTORE_VAL(nm, label) \
	DINO_MANUAL_REVERT_BEGIN() \
DINO_MANUAL_REVERT_VAL(nm, label); \
DINO_MANUAL_REVERT_END() \

#else // !DINO

#define TASK_BOUNDARY(t) SET_CURTASK(t)

#define DINO_RESTORE_CHECK()
#define DINO_MANUAL_VERSION_PTR(...)
#define DINO_MANUAL_VERSION_VAL(...)
#define DINO_MANUAL_RESTORE_NONE()
#define DINO_MANUAL_RESTORE_PTR(...)
#define DINO_MANUAL_RESTORE_VAL(...)
#define DINO_MANUAL_REVERT_BEGIN(...)
#define DINO_MANUAL_REVERT_END(...)
#define DINO_MANUAL_REVERT_VAL(...)

#endif // !DINO

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

typedef struct _mylog_t {
	index_t data[BLOCK_SIZE];
	unsigned count;
	unsigned sample_count;
} mylog_t;

static __nv unsigned curtask;

__nv letter_t _global_l;
__nv dict_t *_global_dict_arg;
__nv mylog_t _global_mylog;
__nv unsigned _global_letter_shift;
__nv unsigned _global_letter_idx_tmp;
__nv dict_t _global_dict;
__nv letter_t _global_letter;
__nv unsigned _global_letter_idx;
__nv index_t _global_parent, _global_child;
__nv sample_t _global_sample, _global_prev_sample;
__nv mylog_t *_global_mylog2;
//__nv unsigned i;
__nv letter_t _global_prev_sample_arg;
__nv letter_t _global_letter_arg;
__nv index_t _global_parent_arg;
__nv node_t *_global_parent_node;
__nv index_t _global_sibling;
__nv node_t *_global_sibling_node;
__nv node_t *_global_node;
__nv index_t _global_node_index;

__nv uint8_t TRUE = 0;

	__attribute__((always_inline))
void print_mylog()
{
	//	PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
	BLOCK_PRINTF_BEGIN();
	BLOCK_PRINTF("rate: samples/block: %u/%u\r\n",
			_global_mylog2->sample_count, _global_mylog2->count);
	//	BLOCK_PRINTF("compressed block:\r\n");
	//	for (i = 0; __loop_bound__(64),i < mylog->count; ++i) {
	//
	//		BLOCK_PRINTF("%04x ", mylog->data[i]);
	//		if (i > 0 && ((i + 1) & (8 - 1)) == 0){
	//		}
	//		BLOCK_PRINTF("\r\n");
	//	}
	//	if ((mylog->count & (8 - 1)) != 0){
	//	}
	//	BLOCK_PRINTF("\r\n");
	BLOCK_PRINTF_END();
	if (_global_mylog2->sample_count != 353) {
		exit(0);
	}
}

static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}
	__attribute__((always_inline))
static sample_t acquire_sample()
{
	//letter_t sample = rand() & 0x0F;
	return (_global_prev_sample_arg + 1) & 0x03;
}

	__attribute__((always_inline))
void init_dict()
{
	LOG("init dict\r\n");
	CBW(_global_dict_arg->node_count);
	_global_dict_arg->node_count = 0;

	for (_global_l = 0; _global_l < NUM_LETTERS; CBW(_global_l), ++_global_l) {
		if (TRUE)
			checkpoint();
		curtask = _global_l; // HACK for progress display
		CBW(_global_node);
		_global_node = &_global_dict_arg->nodes[_global_l];
		CBW(_global_node->letter);
		_global_node->letter = _global_l;
		CBW(_global_node->sibling);
		_global_node->sibling = 0;
		CBW(_global_node->child);
		_global_node->child = 0;

		CBW(_global_dict_arg->node_count);
		_global_dict_arg->node_count++;
		LOG("init dict: node count %u\r\n", _global_dict_arg->node_count);
	}
}

	__attribute__((always_inline))
index_t find_child()
{
	LOG("find child\r\n");
	CBW(_global_parent_node);
	_global_parent_node = &_global_dict_arg->nodes[_global_parent_arg];

	LOG("find child: l %u p %u c %u\r\n", _global_letter_arg, _global_parent_arg, _global_parent_node->child);

	if (_global_parent_node->child == NIL) {
		LOG("find child: not found (no children)\r\n");
		return NIL;
	}

	CBW(_global_sibling);
	_global_sibling = _global_parent_node->child;
	while (__loop_bound__(256),_global_sibling != NIL) { //bound: temp

		if (TRUE)
			checkpoint();
		CBW(_global_sibling_node);
		_global_sibling_node = &_global_dict_arg->nodes[_global_sibling];

		LOG("find child: l %u, s %u l %u s %u\r\n", _global_letter_arg,
				_global_sibling, _global_sibling_node->letter, _global_sibling_node->sibling);

		if (_global_sibling_node->letter == _global_letter_arg) { // found
			LOG("find child: found %u\r\n", _global_sibling);
			return _global_sibling;
		} else {
			CBW(_global_sibling);
			_global_sibling = _global_sibling_node->sibling;
		}
	}

	if (TRUE)
		checkpoint();
	LOG("find child: not found (no match)\r\n");
	return NIL; 
}

	__attribute__((always_inline))
void add_node()
{
	if (_global_dict_arg->node_count == DICT_SIZE) {
		PRINTF("add node: table full\r\n");
		//while(1); // bail for now
	}
	// Initialize the new node
	CBW(_global_node);
	_global_node = &_global_dict_arg->nodes[_global_dict_arg->node_count];

	CBW(_global_node->letter);
	_global_node->letter = _global_letter_arg;
	CBW(_global_node->sibling);
	_global_node->sibling = NIL;
	CBW(_global_node->child);
	_global_node->child = NIL;

	CBW(_global_node_index);
	_global_node_index = _global_dict_arg->node_count++;

	CBW(_global_child);
	_global_child = _global_dict_arg->nodes[_global_parent_arg].child;

	LOG("add node: i %u l %u, p: %u pc %u\r\n",
			_global_node_index, _global_letter_arg, _global_parent_arg, _global_child);

	if (TRUE)
		checkpoint();
	if (_global_child) {
		LOG("add node: is sibling\r\n");

		// Find the last sibling in list
		CBW(_global_sibling);
		_global_sibling = _global_child;
		CBW(_global_sibling_node);
		_global_sibling_node = &_global_dict_arg->nodes[_global_sibling];
		while (__loop_bound__(256),_global_sibling_node->sibling != NIL) { //temp bound for test
			if (TRUE)
				checkpoint();
			LOG("add node: sibling %u, l %u s %u\r\n",
					_global_sibling, _global_letter_arg, _global_sibling_node->sibling);
			CBW(_global_sibling);
			_global_sibling = _global_sibling_node->sibling;
			CBW(_global_sibling_node);
			_global_sibling_node = &_global_dict_arg->nodes[_global_sibling];
		}
		// Link-in the new node
		LOG("add node: last sibling %u\r\n", _global_sibling);
		CBW(_global_dict_arg->nodes[_global_sibling].sibling);
		_global_dict_arg->nodes[_global_sibling].sibling = _global_node_index;
	} else {
		LOG("add node: is only child\r\n");
		CBW(_global_dict_arg->nodes[_global_parent_arg].child);
		_global_dict_arg->nodes[_global_parent_arg].child = _global_node_index;
	}
}

	__attribute__((always_inline))
void append_compressed()
{
	LOG("append comp: p %u cnt %u\r\n", _global_parent_arg, _global_mylog2->count);
	CBW(_global_mylog2->data[_global_mylog2->count]);
	CBW(_global_mylog2->count);
	_global_mylog2->data[_global_mylog2->count++] = _global_parent_arg;
}

void init()
{
#ifdef BOARD_MSP_TS430
	TBCTL &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	TBCTL |= 0x0200; //set 9 to one (SMCLK)
	TBCTL |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	TBCTL &= 0xFFEF; //set bit 4 to zero
	TBCTL |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	TBCTL |= 0x0002; //interrupt enable
#endif
#if OVERHEAD == 1
	//	TBCTL &= ~(0x0020);
#endif
	init_hw();
	//	WISP_init();
#ifdef CONFIG_EDB
	//debug_setup();
	edb_init();
#endif

	INIT_CONSOLE();

	__enable_interrupt();

//	PRINTF(".%u.\r\n", curctx->cur_reg[15]);
}

unsigned test = 0;
int main()
{
	init();
	restore();
	TRUE = 1;
	while (1) {
		if (TRUE)
			checkpoint();
		PRINTF("start\r\n");
		CBW(_global_dict_arg);
		_global_dict_arg = &_global_dict;
		if (TRUE)
			checkpoint();
		init_dict();
		if (TRUE)
			checkpoint();
		// Initialize the pointer into the dictionary to one of the root nodes
		// Assume all streams start with a fixed prefix ('0'), to avoid having
		// to letterize this out-of-band sample.

		CBW(_global_letter);
		_global_letter = 0;

		CBW(_global_letter_idx);
		_global_letter_idx = 0;
		CBW(_global_prev_sample);
		_global_prev_sample = 0;

		CBW(_global_mylog.sample_count);
		_global_mylog.sample_count = 1; // count the initial sample (see above)
		CBW(_global_mylog.count);
		_global_mylog.count = 0; // init compressed counter

		while (1) {
			__loop_bound__(999);
			if (TRUE)
				checkpoint();
			CBW(_global_child);
			_global_child = (index_t)_global_letter; // relyes on initialization of dict
			LOG("compress: parent %u\r\n", _global_child); // naming is odd due to loop
			//PRINTF("compress: parent %u\r\n", child); // naming is odd due to loop


			if (TRUE)
				checkpoint();
			LOG("ac sample?\r\n");
			if (_global_letter_idx == 0) {
				LOG("ac sample\r\n");
				CBW(_global_prev_sample_arg);
				_global_prev_sample_arg = _global_prev_sample;
				if (TRUE)
					checkpoint();
				CBW(_global_sample);
				_global_sample = acquire_sample();
				if (TRUE)
					checkpoint();
				CBW(_global_prev_sample);
				_global_prev_sample = _global_sample;
			}
			if (TRUE)
				checkpoint();

			LOG("letter index: %u\r\n", _global_letter_idx);
			//PRINTF("letter index: %u\r\n", letter_idx);
			CBW(_global_letter_idx);
			_global_letter_idx++;
			if (TRUE)
				checkpoint();
			if (_global_letter_idx == NUM_LETTERS_IN_SAMPLE) {
				CBW(_global_letter_idx);
				_global_letter_idx = 0;
			}
			if (TRUE)
				checkpoint();
			LOG("start do-while\r\n");
			do {
				if (TRUE)
					checkpoint();
				LOG("do-while\r\n");
				CBW(_global_letter_idx_tmp);
				_global_letter_idx_tmp = (_global_letter_idx == 0) ? NUM_LETTERS_IN_SAMPLE : _global_letter_idx - 1; 

				CBW(_global_letter_shift);
				_global_letter_shift = LETTER_SIZE_BITS * _global_letter_idx_tmp;
				CBW(_global_letter);
				_global_letter = (_global_sample & (LETTER_MASK << _global_letter_shift)) >> _global_letter_shift;
				LOG("letterize: sample %x letter %x (%u)\r\n",
						_global_sample, _global_letter, _global_letter);

				CBW(_global_mylog.sample_count);
				_global_mylog.sample_count++;
				CBW(_global_parent);
				_global_parent = _global_child;
				LOG("before: l: %u, p: %u, c: %u\r\n", _global_letter, _global_parent, _global_dict.nodes[_global_parent].child);
				CBW(_global_letter_arg);
				_global_letter_arg = _global_letter;
				CBW(_global_parent_arg);
				_global_parent_arg = _global_parent;
				CBW(_global_dict_arg);
				_global_dict_arg = &_global_dict;
				LOG("checkpoint start\r\n");
				if (TRUE)
					checkpoint();
				LOG("checkpoint end\r\n");
				CBW(_global_child);
				_global_child = find_child();
				//PRINTF("child: %u\r\n", child);
				LOG("child: %u\r\n", _global_child);
			} while (_global_child != NIL);
			if (TRUE)
				checkpoint();
			LOG("done do-while\r\n");

			if (TRUE)
				checkpoint();
			CBW(_global_parent_arg);
			_global_parent_arg = _global_parent;
			CBW(_global_mylog2);
			_global_mylog2 = &_global_mylog;
			append_compressed();
			//WDTCTL=0;
			CBW(_global_letter_arg);
			_global_letter_arg = _global_letter;
			CBW(_global_parent_arg);
			_global_parent_arg = _global_parent;
			CBW(_global_dict_arg);
			_global_dict_arg = &_global_dict;
			if (TRUE)
				checkpoint();
			add_node();

			if (_global_mylog.count == BLOCK_SIZE) {
				CBW(_global_mylog2);
				_global_mylog2 = &_global_mylog;
				if (TRUE)
					checkpoint();
				print_mylog();
				CBW(_global_mylog.count);
				_global_mylog.count = 0;
				CBW(_global_mylog.sample_count);
				_global_mylog.sample_count = 0;

				PRINTF(".%u.\r\n", curctx->cur_reg[15]);
				//PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
				//PRINTF("MAX BACKUP: %u\r\n", max_backup);
				//				BLOCK_PRINTF_BEGIN();
				//				for (unsigned i = 0; i < CHKPT_NUM; ++i) {
				//					BLOCK_PRINTF("chkpt[%u] = %u\r\n", i, chkpt_book[i]);
				//				}
				//				for (unsigned i = 0; i < CHKPT_NUM; ++i) {
				PRINTF("chkpt_status[%u] = %u\r\n", 0, chkpt_status[0]);
				//				}
				//				BLOCK_PRINTF_END();
				//				update_checkpoints_pair();
				//			history[history_counter++] = 3;
				//				exit(0);
				break;
				//while(1);
			}
		}
	}
	return 0;
}
