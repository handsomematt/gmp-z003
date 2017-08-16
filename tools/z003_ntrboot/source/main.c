#include <nds.h>
#include <fat.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

#include "cart_commands.h"
#include "blowfish_retail_bin.h"

#define FILENAME_FIRM "inject_ntr.firm"
#define FILENAME_FLASH_BACKUP "flash_backup.nds"

void waitButtonA() {
	while(1) {
		scanKeys();
		swiWaitForVBlank();
		if (keysDown() & KEY_A) break;
	}
}


void display_hex(u8 *buffer, int lines)
{
	for (int y=0; y<lines; y++)
	{
		for (int x=0; x<8; x++)
			iprintf("%02x ", buffer[y*8 + x]);
		for (int x=0; x<8; x++)
			if (buffer[y*8 + x] >= 32 && buffer[y*8 + x] <= 127)
				iprintf("%c", buffer[y*8 + x]);
			else
				iprintf(".");
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

	iprintf("M3i GMP-Z003 ntrboot injector\n");

	u16 cardInfo = setup_card();
	iprintf("cardcmdb0: %04X\n", cardInfo);

	if (cardInfo != 0x5AA5)
	{
		iprintf("error, expected 0x5AA5\n");
		iprintf("your card is incompatible - press A to exit\n");
		waitButtonA();
		return 0;
	}

	iprintf("warning: your device will become unusable as a flashcart until you reflash it back\n\n");

	iprintf("press A to continue, press B to exit\n\n");
	while(1) {
		scanKeys();
		swiWaitForVBlank();
		if (keysDown() & KEY_A) break;
		if (keysDown() & KEY_B) return 0;
	}
	
	iprintf("reading flash...\n\n");

	u8 *flash_buffer = (u8*) malloc(0x200 * 0x1000);
	read_blocks(0xF0, 0, flash_buffer, 0x1000);
	display_hex(flash_buffer, 4);

	iprintf("backing up to file %s... ", FILENAME_FLASH_BACKUP);
	
	FILE* fp = fopen(FILENAME_FLASH_BACKUP, "wb");
	fwrite(flash_buffer, 0x200, 0x1000, fp);
	fclose(fp);

	iprintf("done\n");

	iprintf("reading ntr firm file... ");
	fp = fopen(FILENAME_FIRM,"rb");
	if (fp == NULL)
	{
		iprintf("\ncould not find %s\n", FILENAME_FIRM);
		waitButtonA();
		return 0;
	}

	fseek(fp, 0, SEEK_END);
	u32 firm_size = ftell(fp);
    u8 *firm = (u8*)malloc(firm_size);

    fseek(fp, 0, SEEK_SET);
    fread(firm, 1, firm_size, fp);
	fclose(fp);

	iprintf("done\n\n");

	iprintf("injecting ntrboot\n\n");

	memcpy(flash_buffer + 0x1000, (u8*)blowfish_retail_bin+0x48, 0x1000);
	memcpy(flash_buffer + 0x2000, (u8*)blowfish_retail_bin, 0x48);

	memcpy(flash_buffer + 0x7E00, firm, firm_size);

	iprintf("erasing flash ");

	// erase it all
	for (int i = 0; i < 0x200; i++)
	{
		iprintf("\rerasing flash %d / %d", i+1, 0x200);
		write_card(i * 0x10000, 0, 0x200, 0xE0);
	}

	iprintf("\nwriting flash ");

	u32 *write_buffer = (u32*)flash_buffer;
	u32 blocks = 0x1000;
	for (int block = 0; block < blocks; block++)
	{
		iprintf("\rwriting flash %d / %ld", block+1, blocks);

		write_card(block * 0x200, write_buffer, 0x80, 0xF0);
		write_buffer += 0x80;
	}

	free(flash_buffer);

	iprintf("\n\ninjection complete\n");
	waitButtonA();

	return 0;
}
