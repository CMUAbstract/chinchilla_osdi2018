#include <msp430.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

//#include <libwispbase/wisp-base.h>
//#include <wisp-base.h>
#include <libchain/chain.h>
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

struct msg_s {
    CHAN_FIELD_ARRAY(uint16_t, s0, S_SIZE);
    CHAN_FIELD_ARRAY(uint16_t, s1, S_SIZE);
    CHAN_FIELD_ARRAY(uint16_t, s2, S_SIZE);
    CHAN_FIELD_ARRAY(uint16_t, s3, S_SIZE);
};
struct msg_key {
    CHAN_FIELD_ARRAY(uint16_t, key, 18);
};
struct msg_ukey {
    CHAN_FIELD_ARRAY(unsigned char, ukey, 16);
};
struct msg_iv {
    CHAN_FIELD_ARRAY(unsigned char, iv, 8);
};
struct msg_index2 {
    CHAN_FIELD(uint16_t, index2);
};
struct msg_self_index2 {
    SELF_CHAN_FIELD(uint16_t, index2);
};
#define FIELD_INIT_msg_self_index2 { \
	SELF_FIELD_INITIALIZER \
}
struct msg_result {
    CHAN_FIELD_ARRAY(unsigned char, result, LENGTH);
};
struct msg_n {
    CHAN_FIELD(unsigned, n);
};
struct msg_self_n {
    SELF_CHAN_FIELD(unsigned, n);
    SELF_CHAN_FIELD(uint16_t, index2);
};
#define FIELD_INIT_msg_self_n { \
	SELF_FIELD_INITIALIZER, \
	SELF_FIELD_INITIALIZER \
}
struct msg_self_input {
	SELF_CHAN_FIELD_ARRAY(uint16_t, input, 2);
};
#define FIELD_INIT_msg_self_input { \
	SELF_FIELD_ARRAY_INITIALIZER(2) \
}
struct msg_input {
	CHAN_FIELD_ARRAY(uint16_t, input, 2);
	CHAN_FIELD(task_t*, next_task);
    	CHAN_FIELD_ARRAY(uint16_t, key, 18);
	CHAN_FIELD_ARRAY(uint16_t, s0, S_SIZE);
	CHAN_FIELD_ARRAY(uint16_t, s1, S_SIZE);
	CHAN_FIELD_ARRAY(uint16_t, s2, S_SIZE);
	CHAN_FIELD_ARRAY(uint16_t, s3, S_SIZE);
};
struct msg_input2 {
	CHAN_FIELD_ARRAY(uint16_t, input, 2);
	CHAN_FIELD(task_t*, next_task);
};
struct msg_return {
	CHAN_FIELD_ARRAY(uint16_t, input, 2);
};
struct msg_index {
	CHAN_FIELD(uint16_t, index);
};
struct msg_self_index {
	SELF_CHAN_FIELD(uint16_t, index);
};
#define FIELD_INIT_msg_self_index { \
	SELF_FIELD_INITIALIZER \
}
TASK(1,  task_init)
TASK(2,  task_set_ukey)
TASK(3,  task_done)
TASK(4,  task_init_key)
TASK(5,  task_init_s)
TASK(6,  task_set_key)
TASK(7,  task_set_key2)
TASK(8,  task_encrypt)
TASK(8,  task_start_encrypt)
TASK(9,  task_start_encrypt2)
TASK(10,  task_start_encrypt3)

MULTICAST_CHANNEL(msg_iv, ch_iv, task_init, task_start_encrypt, task_start_encrypt2);
MULTICAST_CHANNEL(msg_index2, ch_index2, task_init, task_set_key2, task_start_encrypt3);
MULTICAST_CHANNEL(msg_n, ch_n, task_init, task_start_encrypt, task_start_encrypt3);
CHANNEL(task_set_ukey, task_set_key, msg_ukey);
CHANNEL(task_init_key, task_set_key, msg_key);
CHANNEL(task_init_s, task_encrypt, msg_s);
CHANNEL(task_set_key, task_encrypt, msg_key);
CHANNEL(task_set_key2, task_encrypt, msg_input);
CHANNEL(task_start_encrypt, task_encrypt, msg_input2);
SELF_CHANNEL(task_set_key2, msg_self_index2);
SELF_CHANNEL(task_encrypt, msg_self_input);
MULTICAST_CHANNEL(msg_return, ch_return, task_encrypt, task_set_key2, task_start_encrypt2);
MULTICAST_CHANNEL(msg_iv, ch_iv3, task_start_encrypt2, task_start_encrypt3, task_start_encrypt);
MULTICAST_CHANNEL(msg_iv, ch_iv2, task_start_encrypt3, task_start_encrypt, task_start_encrypt2);
CHANNEL(task_start_encrypt3, task_start_encrypt, msg_n);
SELF_CHANNEL(task_start_encrypt3, msg_self_n);
CHANNEL(task_start_encrypt3, task_done, msg_result);

CHANNEL(task_init, task_init_s, msg_index);
SELF_CHANNEL(task_init_s, msg_self_index);

void task_init() {
	PRINTF("TIME start is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
	uint16_t lzero = 0;
	unsigned zero = 0;
	CHAN_OUT1(unsigned, n, zero, MC_OUT_CH(ch_n, task_init, task_start_encrypt, task_start_encrypt3));
	CHAN_OUT1(uint16_t, index2, lzero, MC_OUT_CH(ch_index2, task_init, task_set_key2, task_start_encrypt3));
	CHAN_OUT1(uint16_t, index, zero, CH(task_init, task_init_s));
	unsigned i;
	char czero = 0;
	for (i=0; i<8; ++i) {
		CHAN_OUT1(char, iv[i], czero, MC_OUT_CH(ch_iv, task_init, task_start_encrypt, task_start_encrypt2));
	}
	TRANSITION_TO(task_set_ukey);
}
void task_set_ukey() {
	unsigned i;
	unsigned by, temp;
	while (i < 32) {
		if(cp[i] >= '0' && cp[i] <= '9')
			by = (by << 4) + cp[i] - '0';
		else if(cp[i] >= 'A' && cp[i] <= 'F') //currently, key should be 0-9 or A-F
			by = (by << 4) + cp[i] - 'A' + 10;
		else
			PRINTF("Key must be hexadecimal!!\r\n");
		if ((i++) & 1) {
			temp = by & 0xff;
			CHAN_OUT1(char, ukey[i/2-1], temp, CH(task_set_ukey, task_set_key));
			LOG("ukey[%u]: %u\r\n",i/2-1,temp);
		}
			
	}
	TRANSITION_TO(task_init_key);
}
void task_init_key() {
	unsigned i;
	for (i = 0; i < 18; ++i) {
		CHAN_OUT1(uint16_t, key[i], init_key[i], CH(task_init_key, task_set_key));
	}
	TRANSITION_TO(task_init_s);
}
void task_init_s() {
	unsigned i;
	unsigned index = *CHAN_IN2(uint16_t, index, CH(task_init, task_init_s), SELF_CH(task_init_s));
	for (i = 0; i < S_SIZE; ++i){
		if(index == 0)
			CHAN_OUT1(uint16_t, s0[i], init_s0[i], CH(task_init_s, task_encrypt));
		else if(index == 1)
			CHAN_OUT1(uint16_t, s1[i], init_s1[i], CH(task_init_s, task_encrypt));
		else if(index == 2)
			CHAN_OUT1(uint16_t, s2[i], init_s2[i], CH(task_init_s, task_encrypt));
		else if(index == 3)
			CHAN_OUT1(uint16_t, s3[i], init_s3[i], CH(task_init_s, task_encrypt));
	}
	if(index == 3){
		TRANSITION_TO(task_set_key);
	}
	else {
		++index;
		CHAN_OUT1(uint16_t, index, index, SELF_CH(task_init_s));
		TRANSITION_TO(task_init_s);
	}
/*	for (i = 0; i < 1024; ++i) {
		if (i < S_SIZE) 
			CHAN_OUT1(uint16_t, s0[i], init_s0[i],CH(task_init_s, task_encrypt));
		else if (i < S_SIZE*2)
			CHAN_OUT1(uint16_t, s1[i-S_SIZE], init_s1[i-S_SIZE], CH(task_init_s, task_encrypt));
		else if (i < S_SIZE*3)
			CHAN_OUT1(uint16_t, s2[i-S_SIZE*2], init_s2[i-S_SIZE*2],CH(task_init_s, task_encrypt));
		else 
			CHAN_OUT1(uint16_t, s3[i-S_SIZE*3], init_s3[i-S_SIZE*3],CH(task_init_s, task_encrypt));
	}
	TRANSITION_TO(task_set_key);*/
}
void task_set_key() {
	unsigned i;
	uint16_t ri, ri2, key;
	unsigned d = 0;
	for (i = 0; i < 18; ++i) {
		ri = *CHAN_IN1(unsigned char, ukey[d++], CH(task_set_ukey, task_set_key));
		d = (d >= 8)? 0 : d;
#if VERBOSE > 0
		PRINTF("ri:0:\r\n");
		print_long(ri);
#endif

		ri <<= 8;
		ri2 = *CHAN_IN1(unsigned char, ukey[d++], CH(task_set_ukey, task_set_key));

		ri |= ri2;
#if VERBOSE > 0
		PRINTF("ri:1:\r\n");
		print_long(ri);
#endif
		d = (d >= 8)? 0 : d;
		
		ri <<= 8;
		ri2 = *CHAN_IN1(unsigned char, ukey[d++], CH(task_set_ukey, task_set_key));
		ri |= ri2;
#if VERBOSE > 0
		PRINTF("ri:2:\r\n");
		print_long(ri);
#endif
		d = (d >= 8)? 0 : d;

		ri <<= 8;
		ri2 = *CHAN_IN1(unsigned char, ukey[d++], CH(task_set_ukey, task_set_key));
		ri |= ri2;
#if VERBOSE > 0
		PRINTF("ri:3:\r\n");
		print_long(ri);
#endif
		d = (d >= 8)? 0 : d;

		key = *CHAN_IN1(uint16_t, key[i], CH(task_init_key, task_set_key));
#if VERBOSE > 0
		print_long(key);
		print_long(ri);
#endif
		key ^= ri;
		CHAN_OUT1(uint16_t, key[i], key, CH(task_set_key, task_encrypt));
#if VERBOSE > 0
		print_long(key);
#endif
	}
	TRANSITION_TO(task_set_key2);	
}
void task_set_key2() {
	uint16_t zero = 0;
	uint16_t index2 = *CHAN_IN2(uint16_t, index2, MC_IN_CH(ch_index2, task_init, task_set_key2), SELF_IN_CH(task_set_key2));
	uint16_t k0, k1;
	if (index2 == 0) {
		CHAN_OUT1(uint16_t, input[0], zero, CH(task_set_key2, task_encrypt));
		CHAN_OUT1(uint16_t, input[1], zero, CH(task_set_key2, task_encrypt));
		index2 += 2;
		CHAN_OUT1(uint16_t, index2, index2, SELF_OUT_CH(task_set_key2));
		task_t* next_task = TASK_REF(task_set_key2);
		CHAN_OUT1(task_t*, next_task, next_task, CH(task_set_key2, task_encrypt));
//		uint8_t* return_to = GV(key);
//		LOG("return_to: %u\r\n", return_to);
//		WRITE(return_to, GV(return_to));
		TRANSITION_TO(task_encrypt);
	}
	else {
		if (index2 < 20) { //set key
			k0 = *CHAN_IN1(uint16_t, input[0], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
			k1 = *CHAN_IN1(uint16_t, input[1], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
			CHAN_OUT1(uint16_t, key[index2-2], k0, CH(task_set_key2, task_encrypt));
			CHAN_OUT1(uint16_t, key[index2-1], k1, CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
			LOG("key[%u]=",index2-2);
			print_long(k0);
			LOG("key[%u]=",index2-1);
			print_long(k1);	
#endif
			index2 += 2;
			CHAN_OUT1(uint16_t, index2, index2, SELF_OUT_CH(task_set_key2));
			TRANSITION_TO(task_encrypt);
		}
		else { //set s
			if (index2 < (S_SIZE + 20)) { //set s0 
				k0 = *CHAN_IN1(uint16_t, input[0], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				k1 = *CHAN_IN1(uint16_t, input[1], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				CHAN_OUT1(uint16_t, s0[index2-20], k0, CH(task_set_key2, task_encrypt));
				CHAN_OUT1(uint16_t, s0[index2-19], k1, CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
				if (index2 == 20 || index2 == S_SIZE - 2 + 20) {
					LOG("s0[%u]=",index2-20);
					print_long(k0);
					LOG("s0[%u]=",index2-19);
					print_long(k1);	
				}
#endif
				index2 += 2;
				CHAN_OUT1(uint16_t, index2, index2, SELF_OUT_CH(task_set_key2));
				TRANSITION_TO(task_encrypt);
			}
			else if (index2 < (S_SIZE*2 + 20)) { //set s1
				k0 = *CHAN_IN1(uint16_t, input[0], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				k1 = *CHAN_IN1(uint16_t, input[1], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				CHAN_OUT1(uint16_t, s1[index2-(S_SIZE+20)], k0, CH(task_set_key2, task_encrypt));
				CHAN_OUT1(uint16_t, s1[index2-(S_SIZE+19)], k1, CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
				if (index2 == S_SIZE + 20 || index2 == (S_SIZE*2-2) + 20) {
					LOG("s1[%u]=",index2-(S_SIZE+20));
					print_long(k0);
					LOG("s1[%u]=",index2-(S_SIZE+19));
					print_long(k1);	
				}
#endif
				index2 += 2;
				CHAN_OUT1(uint16_t, index2, index2, SELF_OUT_CH(task_set_key2));
				TRANSITION_TO(task_encrypt);
			}
			else if (index2 < (S_SIZE*3 + 20)) { //set s2
				k0 = *CHAN_IN1(uint16_t, input[0], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				k1 = *CHAN_IN1(uint16_t, input[1], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				CHAN_OUT1(uint16_t, s2[index2-(S_SIZE*2+20)], k0, CH(task_set_key2, task_encrypt));
				CHAN_OUT1(uint16_t, s2[index2-(S_SIZE*2+19)], k1, CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
				if (index2 == S_SIZE*2 + 20 || index2 == (S_SIZE*3-2) + 20) {
					LOG("s2[%u]=",index2-(S_SIZE*2+20));
					print_long(k0);
					LOG("s2[%u]=",index2-(S_SIZE*2+19));
					print_long(k1);	
				}
#endif
				index2 += 2;
				CHAN_OUT1(uint16_t, index2, index2, SELF_OUT_CH(task_set_key2));
				TRANSITION_TO(task_encrypt);
			}
			else if (index2 < (S_SIZE*4 + 20)) {
				k0 = *CHAN_IN1(uint16_t, input[0], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				k1 = *CHAN_IN1(uint16_t, input[1], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
				CHAN_OUT1(uint16_t, s3[index2-(S_SIZE*3+20)], k0, CH(task_set_key2, task_encrypt));
				CHAN_OUT1(uint16_t, s3[index2-(S_SIZE*3+19)], k1, CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
				if (index2 == S_SIZE*3 + 20 || index2 == (S_SIZE*4-2) + 20) {
					LOG("s3[%u]=",index2-(S_SIZE*3+20));
					print_long(k0);
					LOG("s3[%u]=",index2-(S_SIZE*3+19));
					print_long(k1);	
				}
#endif
				index2 += 2;
				if (index2 < (S_SIZE*4 + 20)) {
					CHAN_OUT1(uint16_t, index2, index2, SELF_OUT_CH(task_set_key2));
					TRANSITION_TO(task_encrypt);
				}
				else { //done
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
	//test
//	return_to = *READ(GV(return_to));
//	LOG("return_to: %u\r\n", return_to);
//	uint16_t test = *READ(return_to, 0);
//	LOG("test: ");
//	print_long(test);
//	test = *READ(return_to, 1);
//	LOG("test: ");
//	print_long(test);
	//test
	
	r = *CHAN_IN3(uint16_t, input[0], SELF_CH(task_encrypt),CH(task_set_key2, task_encrypt), CH(task_start_encrypt, task_encrypt));
	l = *CHAN_IN3(uint16_t, input[1], SELF_CH(task_encrypt),CH(task_set_key2, task_encrypt), CH(task_start_encrypt, task_encrypt));
	for (index = 0; index < 17; ++index) {
		p = *CHAN_IN2(uint16_t, key[index], CH(task_set_key, task_encrypt), CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
		if (test){
			print_long(p);
			print_long(r);
		}
#endif
		if (index == 0) {
			r ^= p;
			++index;
		}
		p = *CHAN_IN2(uint16_t, key[index], CH(task_set_key, task_encrypt), CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
		if (test){
			print_long(p);
			print_long(r);
			print_long(l);
		}
#endif
		l^=p; 
#if VERBOSE > 0
		if (test){
			print_long(p);
			print_long(l);
		}
#endif
		s0 = *CHAN_IN2(uint16_t, s0[(r>>12)], CH(task_init_s, task_encrypt), CH(task_set_key2, task_encrypt));
		s1 = *CHAN_IN2(uint16_t, s1[((r>>8)&0xf)], CH(task_init_s, task_encrypt), CH(task_set_key2, task_encrypt));
		s2 = *CHAN_IN2(uint16_t, s2[((r>> 4)&0xf)], CH(task_init_s, task_encrypt), CH(task_set_key2, task_encrypt));
		s3 = *CHAN_IN2(uint16_t, s3[((r     )&0xf)], CH(task_init_s, task_encrypt), CH(task_set_key2, task_encrypt));
#if VERBOSE > 0
		if (test){
			print_long((r));
			print_long((r>>4L));
			print_long((r>>24L));
			print_long(s0);
			s0 = *CHAN_IN2(uint16_t, s0[54], CH(task_init_s, task_encrypt), CH(task_set_key2, task_encrypt));
			print_long(s0);
		}
#endif
		l^=(((	s0 + 
			s1)^ 
			s2)+ 
			s3)&0xffffffff;
		tmp = r;
		r = l;
		l = tmp;
#if VERBOSE > 0
		if (test){
			print_long((r));
			print_long((r>>4L));
			print_long((r>>24L));
			print_long(s0);
			print_long(s1);
			print_long(s2);
			print_long(s3);
			print_long(r);
			print_long(l);
		}
#endif
		//while(1);
	}

	p = *CHAN_IN2(uint16_t, key[17], CH(task_set_key, task_encrypt), CH(task_set_key2, task_encrypt));
	l ^= p;
	CHAN_OUT2(uint16_t, input[1], r, SELF_CH(task_encrypt),MC_OUT_CH(ch_return, task_encrypt, task_set_key2, task_start_encrypt2));
	CHAN_OUT2(uint16_t, input[0], l, SELF_CH(task_encrypt),MC_OUT_CH(ch_return, task_encrypt, task_set_key2, task_start_encrypt2));
	const task_t* next_task = *CHAN_IN2(task_t*, next_task, CH(task_set_key2, task_encrypt), CH(task_start_encrypt, task_encrypt));
	transition_to(next_task);
}

void task_start_encrypt() {
	unsigned i, n; 
	unsigned char iv[8];
	uint16_t v0, v1;
	for (i=0; i<8; ++i) {
		iv[i] = *CHAN_IN3(char, iv[i], MC_IN_CH(ch_iv3, task_start_encrypt2, task_start_encrypt), MC_IN_CH(ch_iv, task_init, task_start_encrypt), MC_IN_CH(ch_iv2, task_start_encrypt3, task_start_encrypt));
	}
	n = *CHAN_IN2(unsigned, n, MC_IN_CH(ch_n, task_init, task_start_encrypt), CH(task_start_encrypt3, task_start_encrypt));
	if (n == 0) {
		v0 =((unsigned long)(iv[0]))<<12;
                v0|=((unsigned long)(iv[1]))<<8;
                v0|=((unsigned long)(iv[2]))<< 4;
                v0|=((unsigned long)(iv[3]));
		v1 =((unsigned long)(iv[4]))<<12;
                v1|=((unsigned long)(iv[5]))<<8;
                v1|=((unsigned long)(iv[6]))<< 4;
                v1|=((unsigned long)(iv[7]));
		CHAN_OUT1(uint16_t, input[0], v0, CH(task_start_encrypt, task_encrypt));
		CHAN_OUT1(uint16_t, input[1], v1, CH(task_start_encrypt, task_encrypt));
		task_t* next_task = TASK_REF(task_start_encrypt2);
		CHAN_OUT1(task_t*, next_task, next_task, CH(task_start_encrypt, task_encrypt));
		TRANSITION_TO(task_encrypt);
	}
	else {
		TRANSITION_TO(task_start_encrypt3);
	}
}
void task_start_encrypt2() {
	uint16_t t;
	unsigned char iv[8];
	unsigned i;
	t = *CHAN_IN1(uint16_t, input[0], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
	iv[0] = (unsigned char)(((t)>>12)&0xf);
        iv[1] = (unsigned char)(((t)>>8)&0xf);
        iv[2] = (unsigned char)(((t)>> 4)&0xf);
        iv[3] = (unsigned char)(((t)     )&0xf);
	t = *CHAN_IN1(uint16_t, input[1], MC_IN_CH(ch_return, task_encrypt, task_set_key2));
	iv[4] = (unsigned char)(((t)>>12)&0xf);
        iv[5] = (unsigned char)(((t)>>8)&0xf);
        iv[6] = (unsigned char)(((t)>> 4)&0xf);
        iv[7] = (unsigned char)(((t)     )&0xf);
	for (i=0; i<8; ++i){
		CHAN_OUT1(char, iv[i], iv[i], MC_OUT_CH(ch_iv3, task_start_encrypt2, task_start_encrypt3));
		LOG("iv[%u]= %u\r\n", i, iv[i]);
	}
	TRANSITION_TO(task_start_encrypt3);
}

void task_start_encrypt3() {
	unsigned char c, iv[8];
	unsigned n, i;
	uint16_t index2 = *CHAN_IN2(uint16_t, index2, MC_IN_CH(ch_index2, task_init, task_start_encrypt3), SELF_IN_CH(task_start_encrypt3));
	n = *CHAN_IN2(unsigned, n, MC_IN_CH(ch_n, task_init, task_start_encrypt3), SELF_IN_CH(task_start_encrypt3));
	for (i=0; i<8; ++i) {
		iv[i] = *CHAN_IN1(char, iv[i], MC_IN_CH(ch_iv3, task_start_encrypt2, task_start_encrypt3));
	}
	c = indata[index2]^iv[n];
	CHAN_OUT1(char, result[index2], c, CH(task_start_encrypt3, task_done));
	PRINTF("result: %x\r\n", c);
	CHAN_OUT1(char, iv[n], c, MC_OUT_CH(ch_iv2, task_start_encrypt3, task_start_encrypt));
	n = (n+1)&0x07;
	CHAN_OUT2(unsigned, n, n, CH(task_start_encrypt3, task_start_encrypt), SELF_CH(task_start_encrypt3));
	++index2;
	if (index2 == LENGTH) {
		TRANSITION_TO(task_done);	
	}
	else {
		CHAN_OUT1(uint16_t, index2, index2, SELF_CH(task_start_encrypt3));
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
	TBCTL &= 0xE6FF; //set 12,11 bit to zero (16bit) also 8 to zero (SMCLK)
	TBCTL |= 0x0200; //set 9 to one (SMCLK)
	TBCTL |= 0x00C0; //set 7-6 bit to 11 (divider = 8);
	TBCTL &= 0xFFEF; //set bit 4 to zero
	TBCTL |= 0x0020; //set bit 5 to one (5-4=10: continuous mode)
	TBCTL |= 0x0002; //interrupt enable
#endif

#ifdef CONFIG_EDB
	edb_init();
#endif
    	init_hw();

    INIT_CONSOLE();

    __enable_interrupt();

    PRINTF(".%u.\r\n", curctx->task->idx);
	for (uint32_t i = 0; i < LOOP_IDX; ++i) {
	}
}

ENTRY_TASK(task_init)
INIT_FUNC(init)
