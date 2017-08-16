#include <nds.h>
#include <fat.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

#include "cart_commands.h"

void waitButtonA() {
	while(1) {
		scanKeys();
		swiWaitForVBlank();
		if (keysDown() & KEY_A) break;
	}
}

int main(void) {
	consoleDemoInit();
	sysSetBusOwners(true, true);

	if(!fatInitDefault())
	{
		iprintf("Failed to initalize fat device.\n");
		return 0;
	}

	iprintf("M3i GMP-Z003 flasher\n");

	u16 cardInfo = setup_card();
	iprintf("cardcmdb0: %04X\n", cardInfo);

	if (cardInfo != 0x5AA5)
	{
		iprintf("error, expected 0x5AA5\n");
		iprintf("your card is incompatible - press A to exit\n");
		waitButtonA();
		return 0;
	}

	iprintf("warning: probably gonna brick your cart\n\n");

	iprintf("press A to continue, press B to exit\n\n");
	while(1) {
		scanKeys();
		swiWaitForVBlank();
		if (keysDown() & KEY_A) break;
		if (keysDown() & KEY_B) return 0;
	}
	
	FILE *fp = fopen("flash.bin", "rb");
	if (fp == NULL)
	{
		iprintf("could not find flash.bin\n");
		waitButtonA();
		return 0;
	}
	u8 *flash = (u8*)malloc(0x200 * 0x1000);
    fread(flash, 1, 0x200 * 0x1000, fp);
	fclose(fp);

	iprintf("erasing flash ");

	// erase it all
	for (int i = 0; i < 0x200; i++)
	{
		iprintf("\rerasing flash %d / %d", i+1, 0x200);
		write_card(i * 0x10000, 0, 0x200, 0xE0);
	}

	iprintf("\nwriting flash ");

	u32 *write_buffer = (u32*)flash;
	u32 blocks = 0x1000;
	for (int block = 0; block < blocks; block++)
	{
		iprintf("\rwriting flash %d / %ld", block+1, blocks);

		write_card(block * 0x200, write_buffer, 0x80, 0xF0);
		write_buffer += 0x80;
	}

	free(flash);

	iprintf("\n\nflash complete\n");
	waitButtonA();

	return 0;
}
