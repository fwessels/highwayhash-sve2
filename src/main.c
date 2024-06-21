
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <math.h>
#include <time.h>
#include "highwayhash.h"

int main()
{
    uint64_t state[16];
	state[0] = 0x0102030405060708;
	state[1] = 0x090a0b0c0d0e0f10;
	state[2] = 0x1112131415161718;
	state[3] = 0x191a1b1c1d1e1f20;
	state[4] = 0x2122232425262728;
	state[5] = 0x292a2b2c2d2e2f30;
	state[6] = 0x3132333435363738;
	state[7] = 0x393a3b3c3d3e3f40;
	state[8] = 0x4142434445464748;
	state[9] = 0x494a4b4c4d4e4f50;
	state[10] = 0x5152535455565758;
	state[11] = 0x595a5b5c5d5e5f60;
	state[12] = 0x6162636465666768;
	state[13] = 0x696a6b6c6d6e6f70;
	state[14] = 0x7172737475767778;
	state[15] = 0x797a7b7c7d7e7f80;

    char msg[64];
    for(int i = 0; i < 64; i++)
    {
        msg[i] = 0x33 + i;
    }

    update_arm64_sve2(state, msg, 64);

    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[0], state[1]);
    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[2], state[3]);
    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[4], state[5]);
    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[6], state[7]);
    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[8], state[9]);
    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[10], state[11]);
    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[12], state[13]);
    printf("%#018" PRIx64 " - %#018" PRIx64 "\n", state[14], state[15]);

    return 0;
}
