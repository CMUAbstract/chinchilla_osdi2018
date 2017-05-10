#include <stdio.h>
int g1=1;
__attribute__((always_inline))
int func(int a, int b){
	return a + b;
}

int main() {
	int x = 5;
	int z = x+g1;
	int c = func(x, z);
	if (c < 1){
		c = x + z;
	}
	else{
		c = x - z;
	}
	for (int i=0; i<7; i++) {
		int a = i+9;
		for (int j=0; j<1; j++) {
//			for (int k=0; k<1; k++) {
//			}
//			int a = j*2;
		}
		g1 = a;
	}
	g1 = 3;
	int t = z-4;
	g1 = 3;
	t = z-4;
	g1 = 3;
	t = z-4;
	g1 = 3;
	t = z-4;
	printf("%u, %u, %u, %u, %u\n", x, z, c, t, g1);
}

