#include <stdio.h>

int byte = 64;
char data[64];
FILE *fp;

int main() 
{
	fp = fopen("/dev/urandom", "r");
	fread(&data, 1, byte, fp);
	fclose(fp);
}
