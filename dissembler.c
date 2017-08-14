#include <stdio.h>

int main() {
	FILE* file;
	FILE* file2;
	int c;
	file = fopen("templog.out", "r");
	file2 = fopen("templog2.out", "w");
	unsigned counter = 0;
	unsigned char word[4];
	char isCall = 0;
	char shouldReplace = 0;

	unsigned call_counter = 0;
	if (file) {
		while ((c = getc(file)) != EOF) {
			word[counter] = c;
			if (counter == 1 || counter == 3) { // check if it is call
				if (word[counter - 1] == 0xb0 && word[counter] == 0x12) {
					printf("call\n");
					if (counter == 3) {
						word[0] = word[2];
						word[1] = word[3];
						counter = 1;
					}
					counter++;
				}
				else if (counter == 3) {
					if (word[2] == 0x70 && word[3] == 0x50) {
						fprintf(file2, "%c%c%c%c", 0x03, 0x43, 0x03, 0x43); //TODO: change to fastest nop
						call_counter++;
					}
					else {
						fprintf(file2, "%c%c%c%c", word[0], word[1], word[2], word[3]);
					}
					counter = 0;
				}
				else {
					fprintf(file2, "%c%c", word[0], word[1]);
					counter = 0;
				}
			}
			else {
				counter++;
			}
		}
		fclose(file);
		fclose(file2);
	}
	printf("CALL count: %u\n", call_counter);
}
