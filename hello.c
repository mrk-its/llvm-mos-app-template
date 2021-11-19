#include <stdio.h>

void wait() {
    volatile unsigned char *clk_ptr = (unsigned char *)(20);
    volatile unsigned char *COLBK = (unsigned char *)0xd01a;
    volatile unsigned char *RANDOM = (unsigned char *)0xd20a;

    unsigned char v = *clk_ptr;
    while(*clk_ptr == v) *COLBK = *RANDOM;
}

int main() {
    printf("Hello!\n");
    for(int i=0; i<250; i++) wait();
}
