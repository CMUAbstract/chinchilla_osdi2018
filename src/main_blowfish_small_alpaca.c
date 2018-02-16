#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

//#include <libwispbase/wisp-base.h>
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
#include "param.h"

#define LENGTH 13
#define S_SIZE 16

unsigned volatile *timer = &TBCTL;
static __ro_nv const char cp[32] = {'1','2','3','4','5','6','7','8','9','0',
	'A','B','C','D','E','F','F','E','D','C','B','A',
	'0','9','8','7','6','5','4','3','2','1'}; //mimicing 16byte hex key (0x1234_5678_90ab_cdef_fedc_ba09_8765_4321)
static __ro_nv const char indata[LENGTH] = {'H','e','l','l','o',',',' ','w','o','r','l','d','!'};

static __ro_nv const uint16_t init_key[18] = {
	0x243f, 0x85a3, 0x1319, 0x0370,
	0xa409, 0x299f, 0x082e, 0xec4e,
	0x4528, 0x38d0, 0xbe54, 0x34e9,
	0xc0ac, 0xc97c, 0x3f84, 0xb547,
	0x9216, 0x8979
};

static __ro_nv const uint16_t init_s0[S_SIZE] = {
	0xd131, 0x98df, 0x2ffd, 0xd01a, 
	0xb8e1, 0x6a26, 0xba7c, 0xf12c, 
	0x24a1, 0xb391, 0x0801, 0x858e, 
	0x6369, 0x7157, 0xa458, 0xf493, 
};

static __ro_nv const uint16_t init_s1[S_SIZE] = {
	0x4b7a, 0xb5b3, 0xdb75, 0xc419, 
	0xad6e, 0x49a7, 0x9cee, 0x8fed, 
	0xecaa, 0x699a, 0x5664, 0xc2b1, 
	0x1936, 0x7509, 0xa059, 0xe418, 
};

static __ro_nv const uint16_t init_s2[S_SIZE] = {
	0xe93d, 0x9481, 0xf64c, 0x9469, 
	0x4115, 0x7602, 0xbcf4, 0xd4a2, 
	0xd408, 0x3320, 0x43b7, 0x5000, 
	0x1e39, 0x9724, 0x1421, 0xbf8b, 
};

static __ro_nv const uint16_t init_s3[S_SIZE] = {
	0x3a39, 0xd3fa, 0xabc2, 0x5ac5, 
	0x5cb0, 0x4fa3, 0xd382, 0x99bc, 
	0xd511, 0xbf0f, 0xd62d, 0xc700, 
	0xb78c, 0x21a1, 0xb26e, 0x6a36, 
};

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


// Have to define the vector table elements manually, because clang,
// unlike gcc, does not generate sections for the vectors, it only
// generates symbols (aliases). The linker script shipped in the
// TI GCC distribution operates on sections, so we define a symbol and put it
// in its own section here named as the linker script wants it.
// The 2 bytes per alias symbol defined by clang are wasted.
__attribute__((section("__interrupt_vector_timer0_b1"),aligned(2)))
void(*__vector_timer0_b1)(void) = TimerB1_ISR;

	TASK(1,  task_init)
	TASK(2,  task_set_ukey)
	TASK(3,  task_done)
	TASK(4,  task_init_key)
	TASK(5,  task_init_s)
	TASK(6,  task_set_key)
	TASK(7,  task_set_key2)
	TASK(8,  task_encrypt)
	TASK(9,  task_start_encrypt)
	TASK(10,  task_start_encrypt2)
TASK(11,  task_start_encrypt3)

	GLOBAL_SB(uint8_t*, return_to);	
	GLOBAL_SB(char, result, LENGTH);
	GLOBAL_SB(unsigned char, ukey, 16);
	GLOBAL_SB(uint16_t, s0, S_SIZE);
	GLOBAL_SB(uint16_t, s1, S_SIZE);
	GLOBAL_SB(uint16_t, s2, S_SIZE);
	GLOBAL_SB(uint16_t, s3, S_SIZE);
	GLOBAL_SB(unsigned, index);
	GLOBAL_SB(uint16_t, index2);
	GLOBAL_SB(unsigned, n);
	GLOBAL_SB(task_t*, next_task);
	GLOBAL_SB(uint16_t, input, 2);
	GLOBAL_SB(unsigned char, iv, 8);
	GLOBAL_SB(uint16_t, key, 18);

void task_init()
{
	PRINTF("TIME start is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
	//PRINTF("start\r\n");
	GV(n) = 0;
	GV(index) = 0;
	GV(index2) = 0;
	unsigned i;
	for (i=0; i<8; ++i) {
		GV(iv, i) = 0;
	}
	TRANSITION_TO(task_set_ukey);
}
void task_set_ukey() {
	unsigned i = 0;
	unsigned by = 0;
	while (i < 32) {
		if(cp[i] >= '0' && cp[i] <= '9')
			by = (by << 4) + cp[i] - '0';
		else if(cp[i] >= 'A' && cp[i] <= 'F') //currently, key should be 0-9 or A-F
			by = (by << 4) + cp[i] - 'A' + 10;
		else
			PRINTF("Key must be hexadecimal!!\r\n");
		if ((i++) & 1) {
			GV(ukey, i/2-1) = by & 0xff;
			LOG("ukey[%u]: %u\r\n",i/2-1,by & 0xff);
		}

	}
	TRANSITION_TO(task_init_key);
}
void task_init_key() {
	unsigned i;
	for (i = 0; i < 18; ++i) {
		GV(key, i) = init_key[i];
	}
	TRANSITION_TO(task_init_s);
}
void task_init_s() {
	unsigned i;

	for (i = 0; i < S_SIZE; ++i) {
		if (GV(index) == 0) 
			GV(s0, i) = init_s0[i];
		else if (GV(index) == 1)
			GV(s1, i) = init_s1[i];
		else if (GV(index) == 2)
			GV(s2, i) = init_s2[i];
		else if (GV(index) == 3)
			GV(s3, i) = init_s3[i];
	}
	if(GV(index) == 3){
		TRANSITION_TO(task_set_key);
	}
	else {
		++GV(index);
		TRANSITION_TO(task_init_s);
	}
	/*
	   for (i = 0; i < 1024; ++i) {
	   if (i < S_SIZE) 
	   GV(s0, i) = init_s0[i];
	   else if (i < S_SIZE*2)
	   GV(s1, i-S_SIZE) = init_s1[i-S_SIZE];
	   else if (i < S_SIZE*3)
	   GV(s2, i-S_SIZE*2) = init_s2[i-S_SIZE*2];
	   else 
	   GV(s3, i-S_SIZE*3) = init_s3[i-S_SIZE*3];
	   }
	   TRANSITION_TO(task_set_key);*/
}
void task_set_key() {
	unsigned i;
	uint16_t ri, ri2;
	unsigned d = 0;
	for (i = 0; i < 18; ++i) {
		ri = GV(ukey, d++);

		d = (d >= 8)? 0 : d;

		ri <<= 8;
		ri2 = GV(ukey, d++);
		ri |= ri2;
		d = (d >= 8)? 0 : d;

		ri <<= 8;
		ri2 = GV(ukey, d++);
		ri |= ri2;
		d = (d >= 8)? 0 : d;

		ri <<= 8;
		ri2 = GV(ukey, d++);
		ri |= ri2;
		d = (d >= 8)? 0 : d;

		GV(key, i) ^= ri;
	}
	TRANSITION_TO(task_set_key2);	
}
void task_set_key2() {
	if (GV(index2) == 0) {
		GV(input, 0) = 0;
		GV(input, 1) = 0;
		GV(index2) += 2;
		GV(next_task) = TASK_REF(task_set_key2);

		TRANSITION_TO(task_encrypt);
	}
	else {
		if (GV(index2) < 20) { //set key
			GV(key, _global_index2-2) = GV(input, 0);
			GV(key, _global_index2-1) = GV(input, 1);
#if VERBOSE > 0
			LOG("key[%u]=%x\r\n",_global_index2-2, _global_input[0]);
			LOG("key[%u]=%x\r\n",_global_index2-1, _global_input[1]);
#endif
			GV(index2) += 2;
			TRANSITION_TO(task_encrypt);
		}
		else { //set s
			if (GV(index2) < (S_SIZE + 20)) { //set s0 
				GV(s0, _global_index2-20) = GV(input, 0);
				GV(s0, _global_index2-19) = GV(input, 1);
#if VERBOSE > 0
				if (GV(index2) == 20 || GV(index2) == S_SIZE - 2 + 20) {
					LOG("s0[%u]=%x\r\n",_global_index2-20, _global_input[0]);
					LOG("s0[%u]=%x\r\n",_global_index2-19, _global_input[1]);
					//print_long(k1);	
				}
#endif
				GV(index2) += 2;
				TRANSITION_TO(task_encrypt);
			}
			else if (GV(index2) < (S_SIZE*2 + 20)) { //set s1
				GV(s1, _global_index2-(S_SIZE+20)) = GV(input, 0);
				GV(s1, _global_index2-(S_SIZE+19)) = GV(input, 1);
#if VERBOSE > 0
				if (GV(index2) == S_SIZE + 20 || GV(index2) == (S_SIZE*2-2) + 20) {
					LOG("s1[%u]=%x\r\n",_global_index2-(S_SIZE + 20), _global_input[0]);
					LOG("s1[%u]=%x\r\n",_global_index2-(S_SIZE + 19), _global_input[1]);
				}
#endif
				GV(index2) += 2;
				TRANSITION_TO(task_encrypt);
			}
			else if (GV(index2) < (S_SIZE*3 + 20)) { //set s2
				GV(s2, _global_index2-(S_SIZE*2+20)) = GV(input, 0);
				GV(s2, _global_index2-(S_SIZE*2+19)) = GV(input, 1);
#if VERBOSE > 0
				if (GV(index2) == S_SIZE*2 + 20 || GV(index2) == (S_SIZE*3-2) + 20) {
					LOG("s2[%u]=%x\r\n",_global_index2-(S_SIZE*2 + 20), _global_input[0]);
					LOG("s2[%u]=%x\r\n",_global_index2-(S_SIZE*2 + 19), _global_input[1]);
				}
#endif
				GV(index2) += 2;
				TRANSITION_TO(task_encrypt);
			}
			else if (GV(index2) < (S_SIZE*4 + 20)) {
				GV(s3, _global_index2-(S_SIZE*3+20)) = GV(input, 0);
				GV(s3, _global_index2-(S_SIZE*3+19)) = GV(input, 1);
#if VERBOSE > 0
				if (GV(index2) == S_SIZE*3 + 20 || GV(index2) == (S_SIZE*4-2) + 20) {
					LOG("s3[%u]=%x\r\n",_global_index2-(S_SIZE*3 + 20), _global_input[0]);
					LOG("s3[%u]=%x\r\n",_global_index2-(S_SIZE*3 + 19), _global_input[1]);
				}
#endif
				GV(index2) += 2;
				if (GV(index2) < (S_SIZE*4 + 20)) {
					TRANSITION_TO(task_encrypt);
				}
				else { //done
					GV(index2) = 0;
					TRANSITION_TO(task_start_encrypt);	
				}
			}
		}
	}
}

void task_encrypt() {
	uint16_t p, l, r, s0, s1, s2, s3, tmp;
	//	unsigned index = *READ(GV(index));
	//	uint8_t* return_to;
	//	struct GV_POINTER(key)* return_to;
	unsigned index;
	r = GV(input, 0);
	l = GV(input, 1);
	for (index = 0; index < 17; ++index) {
		p = GV(key, index);
//#if VERBOSE > 0
//		if (test){
//			print_long(p);
//			print_long(r);
//		}
//#endif
		if (index == 0) {
			r ^= p;
			++index;
		}
		p = GV(key, index);
//#if VERBOSE > 0
//		if (test){
//			print_long(p);
//			print_long(r);
//			print_long(l);
//		}
//#endif
		l^=p; 
//#if VERBOSE > 0
//		if (test){
//			print_long(p);
//			print_long(l);
//		}
//#endif
		s0 = GV(s0, (r>>12));
		s1 = GV(s1, ((r>>8)&0xf));
		s2 = GV(s2, ((r>>4)&0xf));
		s3 = GV(s3, ((r     )&0xf));
		LOG("r: %x\r\n", r);
		LOG("s0: %x\r\n", s0);
		LOG("s1: %x\r\n", s1);
		LOG("s2: %x\r\n", s2);
		LOG("s3: %x\r\n", s3);
		l^=(((	s0 + 
						s1)^ 
					s2)+ 
				s3)&0xffff;
		tmp = r;
		r = l;
		l = tmp;
//#if VERBOSE > 0
//		if (test){
//			print_long(s0);
//			print_long(s1);
//			print_long(s2);
//			print_long(s3);
//			print_long(r);
//			print_long(l);
//		}
//#endif
		//while(1);
	}
	p = GV(key, 17);
	l ^= p;
	GV(input, 1) = r;
	GV(input, 0) = l;
	transition_to(GV(next_task));
}

void task_start_encrypt() {
	unsigned i; 
	//	n = *READ(GV(n));
	if (GV(n) == 0) {
		GV(input, 0) =((unsigned)(GV(iv, 0)))<<12;
		GV(input, 0)|=((unsigned)(GV(iv, 1)))<<8;
		GV(input, 0)|=((unsigned)(GV(iv, 2)))<<4;
		GV(input, 0)|=((unsigned)(GV(iv, 3)));
		GV(input, 1) =((unsigned)(GV(iv, 4)))<<12;
		GV(input, 1)|=((unsigned)(GV(iv, 5)))<<8;
		GV(input, 1)|=((unsigned)(GV(iv, 6)))<<4;
		GV(input, 1)|=((unsigned)(GV(iv, 7)));
		GV(next_task) = TASK_REF(task_start_encrypt2);
		TRANSITION_TO(task_encrypt);
	}
	else {
		TRANSITION_TO(task_start_encrypt3);
	}
}
void task_start_encrypt2() {
	GV(iv, 0) = (unsigned char)(((GV(input, 0))>>12)&0xf);
	GV(iv, 1) = (unsigned char)(((GV(input, 0))>>8)&0xf);
	GV(iv, 2) = (unsigned char)(((GV(input, 0))>> 4)&0xf);
	GV(iv, 3) = (unsigned char)(((GV(input, 0))     )&0xf);
	GV(iv, 4) = (unsigned char)(((GV(input, 1))>>12)&0xf);
	GV(iv, 5) = (unsigned char)(((GV(input, 1))>>8)&0xf);
	GV(iv, 6) = (unsigned char)(((GV(input, 1))>> 4)&0xf);
	GV(iv, 7) = (unsigned char)(((GV(input, 1))     )&0xf);
#if VERBOSE > 0
	for (int i=0; i<8; ++i){
		LOG("iv[%u]=%u\r\n",i,GV(iv,i));
	}	
#endif
	TRANSITION_TO(task_start_encrypt3);
}

void task_start_encrypt3() {
	unsigned char c;
	c = indata[GV(index2)]^(GV(iv, _global_n));
	GV(result, _global_index2) = c;
	PRINTF("result: %x\r\n", c);
	GV(iv, _global_n) = c;
	GV(n) = (GV(n)+1)&0x07;
	++GV(index2);
	if (GV(index2) == LENGTH) {
		TRANSITION_TO(task_done);	
	}
	else {
		TRANSITION_TO(task_start_encrypt);	
	}
}

void task_done()
{
	PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);

	TRANSITION_TO(task_init);
}
static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}

void init()
{
#ifdef BOARD_MSP_TS430
	*timer &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	*timer |= 0x0200; //set 9 to one (SMCLK)
	*timer |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	*timer &= 0xFFEF; //set bit 4 to zero
	*timer |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	*timer |= 0x0002; //interrupt enable
#endif
	init_hw();

#ifdef CONFIG_EDB
	edb_init();
#endif

	INIT_CONSOLE();

	__enable_interrupt();

	PRINTF(".%u.\r\n", curctx->task->idx);
	for (uint32_t i = 0; i < LOOP_IDX; ++i) {
	}
}

	ENTRY_TASK(task_init)
INIT_FUNC(init)
