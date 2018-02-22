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

#ifdef DINO
#include <libdino/dino.h>
#endif

#include "param.h"
#include "pins.h"
#define LENGTH 13
#define S_SIZE 16

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
static __nv unsigned curtask;

/* This is for progress reporting only */
#define SET_CURTASK(t) curtask = t

#define TASK_INIT                   1
#define TASK_SET_UKEY               2
#define TASK_INIT_KEY               3
#define TASK_INIT_S                 4
#define TASK_SET_KEY                5
#define TASK_ENCRYPT                6
#define TASK_ENCRYPT_END            7
#define TASK_START_ENCRYPT          8
#define TASK_START_ENCRYPT2     9

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

static void init_hw()
{
	msp_watchdog_disable();
	msp_gpio_unlock();
	msp_clock_setup();
}
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
uint16_t __nv s0[S_SIZE], s1[S_SIZE], s2[S_SIZE], s3[S_SIZE];
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
    //WISP_init();
	init_hw();
#ifdef CONFIG_EDB
   // debug_setup();
    edb_init();
#endif

    INIT_CONSOLE();

    __enable_interrupt();
#if 0
    GPIO(PORT_LED_1, DIR) |= BIT(PIN_LED_1);
    GPIO(PORT_LED_2, DIR) |= BIT(PIN_LED_2);
#if defined(PORT_LED_3)
    GPIO(PORT_LED_3, DIR) |= BIT(PIN_LED_3);
#endif

#if defined(PORT_LED_3) // when available, this LED indicates power-on
    GPIO(PORT_LED_3, OUT) |= BIT(PIN_LED_3);
#endif

#ifdef SHOW_PROGRESS_ON_LED
    blink(1, SEC_TO_CYCLES * 5, LED1 | LED2);
#endif
#endif
    EIF_PRINTF(".%u.\r\n", curtask);
	for (uint32_t i = 0; i < LOOP_IDX; ++i) {
	}
}
void BF_encrypt(uint16_t *data, uint16_t *key){
        TASK_BOUNDARY(TASK_ENCRYPT);
        DINO_MANUAL_RESTORE_NONE();
	uint16_t l, r, p, s0_t, s1_t, s2_t, s3_t, tmp;
	r = data[0];
	l = data[1];
	for (unsigned index = 0; index < 17; ++index){
		p = key[index];

		if (index == 0) {
			r ^= p;
			++index;
		}
		p = key[index];
		l^=p; 
		s0_t = s0[(r>>12)];
		s1_t = s1[((r>>8)&0xf)];
		s2_t = s2[((r>> 4)&0xf)];
		s3_t = s3[((r     )&0xf)];
		l^=(((	s0_t + 
			s1_t)^ 
			s2_t)+ 
			s3_t)&0xffff;

		tmp = r;
		r = l;
		l = tmp;
	}
	p = key[17];
	l ^= p;
	data[1] = r;
	data[0] = l;
	//CHECKPOINT
        TASK_BOUNDARY(TASK_ENCRYPT_END);
        DINO_MANUAL_RESTORE_NONE();
}
void BF_set_key(unsigned char *data, uint16_t *key){
	unsigned i;
	uint16_t ri, ri2;
	unsigned d = 0;
        TASK_BOUNDARY(TASK_INIT_S);
        DINO_MANUAL_RESTORE_NONE();
	for (i=0; i<18; ++i){
		ri= data[d++];

		d = (d >=8)? 0 : d;

		ri<<=8;
		ri2 = data[d++];
		ri |= ri2;
		d = (d >=8)? 0 : d;

		ri<<=8;
		ri2 = data[d++];
		ri |= ri2;
		d = (d >=8)? 0 : d;

		ri<<=8;
		ri2 = data[d++];
		ri |= ri2;
		d = (d >=8)? 0 : d;

		key[i]^=ri;
	}
        TASK_BOUNDARY(TASK_SET_KEY);
        DINO_MANUAL_RESTORE_NONE();
	uint16_t in[2]={0L,0L};
	BF_encrypt(in, key);
	uint16_t li;
	for (li=2; li< S_SIZE*4+20; li+=2){
		if(li < 20){
			key[li-2] = in[0];
			key[li-1] = in[1];
#if VERBOSE > 0
			LOG("key[%u]=%x\r\n", li-2, in[0]);
			LOG("key[%u]=%x\r\n", li-1, in[1]);
#endif
			BF_encrypt(in, key);
		}
		else if(li < S_SIZE+20){
			s0[li-20] = in[0];
			s0[li-19] = in[1];
#if VERBOSE > 0
			if (li == 20 || li == S_SIZE - 2 + 20) {
				LOG("s0[%u]=%x\r\n", li-20, in[0]);
				LOG("s0[%u]=%x\r\n", li-19, in[1]);
			}
#endif
			BF_encrypt(in, key);
		}
		else if(li < S_SIZE*2+20){
			s1[li-(S_SIZE+20)] = in[0];
			s1[li-(S_SIZE+19)] = in[1];
#if VERBOSE > 0
			if (li == S_SIZE + 20 || li == (S_SIZE*2 - 2) + 20) {
				LOG("s1[%u]=%x\r\n", li-(S_SIZE + 20), in[0]);
				LOG("s1[%u]=%x\r\n", li-(S_SIZE + 19), in[1]);
			}
#endif
			BF_encrypt(in, key);
		}
		else if(li < S_SIZE*3+20){
			s2[li-(S_SIZE*2+20)] = in[0];
			s2[li-(S_SIZE*2+19)] = in[1];
#if VERBOSE > 0
			if (li == S_SIZE*2 + 20 || li == (S_SIZE*3 - 2) + 20) {
				LOG("s2[%u]=%x\r\n", li-(S_SIZE*2 + 20), in[0]);
				LOG("s2[%u]=%x\r\n", li-(S_SIZE*2 + 19), in[1]);
			}
#endif
			BF_encrypt(in, key);
		}
		else if(li < S_SIZE*4+20){
			s3[li-(S_SIZE*3+20)] = in[0];
			s3[li-(S_SIZE*3+19)] = in[1];
#if VERBOSE > 0
			if (li == S_SIZE*3 + 20 || li == (S_SIZE*4 - 2) + 20) {
				LOG("s3[%u]=%x\r\n", li-(S_SIZE*3 + 20), in[0]);
				LOG("s3[%u]=%x\r\n", li-(S_SIZE*3 + 19), in[1]);
			}
#endif
			BF_encrypt(in, key);
		}
	}
}
void BF_cfb64_encrypt(unsigned char* out, unsigned char* iv, uint16_t *key){
	uint16_t ti[2];
	unsigned char c;
	unsigned n = 0;
	for (unsigned i=0; i< LENGTH; ++i){
		TASK_BOUNDARY(TASK_START_ENCRYPT);
		DINO_MANUAL_RESTORE_NONE();
		if (n == 0){
			for (unsigned j=0; j<8; ++j){
				LOG("before: iv[%u]=%u\r\n",j,iv[j]);
			}	
			ti[0] =((unsigned)((iv[0])))<<12;
			ti[0]|=((unsigned)(iv[1]))<<8;
			ti[0]|=((unsigned)(iv[2]))<< 4;
			ti[0]|=((unsigned)(iv[3]));
			ti[1] =((unsigned)(iv[4]))<<12;
			ti[1]|=((unsigned)(iv[5]))<<8;
			ti[1]|=((unsigned)(iv[6]))<< 4;
			ti[1]|=((unsigned)(iv[7]));
			BF_encrypt(ti, key);

			iv[0] = (unsigned char)(((ti[0])>>12)&0xf);
			iv[1] = (unsigned char)(((ti[0])>>8)&0xf);
			iv[2] = (unsigned char)(((ti[0])>> 4)&0xf);
			iv[3] = (unsigned char)(((ti[0])     )&0xf);
			iv[4] = (unsigned char)(((ti[1])>>12)&0xf);
			iv[5] = (unsigned char)(((ti[1])>>8)&0xf);
			iv[6] = (unsigned char)(((ti[1])>> 4)&0xf);
			iv[7] = (unsigned char)(((ti[1])     )&0xf);
#if VERBOSE > 0
			for (unsigned j=0; j<8; ++j){
				LOG("iv[%u]=%u\r\n",j,iv[j]);
			}	
#endif
		}
		TASK_BOUNDARY(TASK_START_ENCRYPT2);
		DINO_MANUAL_RESTORE_NONE();
		c= indata[i]^iv[n];
		out[i]=c;
		PRINTF("result: %x\r\n", c);
		iv[n]=c;
		n=(n+1)&0x07;
	}
}


int main()
{
	uint16_t key[18];
	init();

	DINO_RESTORE_CHECK();

	unsigned char ukey[16];
	unsigned char indata[40], outdata[40], ivec[8];

	while (1) {
		PRINTF("TIME start is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
	unsigned i = 0, by = 0;	

	for (i = 0; i < 8; ++i){
		ivec[i] = 0;
	}
	i = 0;
	//CHECKPOINT
        TASK_BOUNDARY(TASK_INIT);
        DINO_MANUAL_RESTORE_NONE();
	while (i < 32) {
		if(cp[i] >= '0' && cp[i] <= '9')
			by = (by << 4) + cp[i] - '0';
		else if(cp[i] >= 'A' && cp[i] <= 'F') //currently, key should be 0-9 or A-F
			by = (by << 4) + cp[i] - 'A' + 10;
		else
			PRINTF("Key must be hexadecimal!!\r\n");
		if ((i++) & 1) {
			ukey[i/2-1] = by & 0xff;
			LOG("ukey[%u]: %u\r\n",i/2-1,by & 0xff);
		}

	}
        TASK_BOUNDARY(TASK_SET_UKEY);
        DINO_MANUAL_RESTORE_NONE();
	for (i = 0; i < 18; ++i)
		key[i] = init_key[i];
	
	for (i = 0; i < S_SIZE*4; ++i) {
		if (i == 0 || i == S_SIZE || i == S_SIZE*2 || i == S_SIZE*3){
			TASK_BOUNDARY(TASK_INIT_KEY);
			DINO_MANUAL_RESTORE_NONE();
		}
		if (i < S_SIZE) 
			s0[i] = init_s0[i];
		else if (i < S_SIZE*2)
			s1[i-S_SIZE] = init_s1[i-S_SIZE];
		else if (i < S_SIZE*3)
			s2[i-S_SIZE*2] = init_s2[i-S_SIZE*2];
		else 
			s3[i-S_SIZE*3] = init_s3[i-S_SIZE*3];
	}
	BF_set_key(ukey, key);
	BF_cfb64_encrypt(outdata, ivec, key);
	PRINTF("TIME end is 65536*%u+%u\r\n",overflow,(unsigned)TBR);
	}
}



