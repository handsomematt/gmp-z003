#include <nds.h>
#include <fat.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

#include "blowfish_retail_bin.h"

void waitButtonA() {
	while(1) {
		scanKeys();
		swiWaitForVBlank();
		if (keysDown() & KEY_A) break;
	}
}

void ioM3CardWaitReady(u32 flags, u8 *command)
{
  bool ready = false;

  do {
    cardWriteCommand(command);
    REG_ROMCTRL = flags;
    do {
      if (REG_ROMCTRL & CARD_DATA_READY)
        if (!CARD_DATA_RD) ready = true;
    } while (REG_ROMCTRL & CARD_BUSY);
  } while (!ready);
}

void read_card(u32 address, u32 *destination, u32 length, u8 type)
{
  u8 command[8];

  command[7] = 0xC9;
  command[6] = (address >> 24) & 0xff;
  command[5] = (address >> 16) & 0xff;
  command[4] = (address >> 8)  & 0xff;
  command[3] =  address        & 0xff;
  command[2] = type; // SW
  command[1] = 0;
  command[0] = 0;
  ioM3CardWaitReady(0xa7586000, command);

  command[7] = 0xCA;
  cardPolledTransfer(0xa1586000, destination, length, command);
}

void write_card(u32 address, u32 *source, u32 length, u8 type)
{
  u8 command[8];
  u32 data = 0;

  command[7] = 0xC5; // GMP-Z003
  command[6] = (address >> 24) & 0xff;
  command[5] = (address >> 16) & 0xff;
  command[4] = (address >> 8)  & 0xff;
  command[3] =  address        & 0xff;
  command[2] = type;
  command[1] = 0;
  command[0] = 0;
  cardWriteCommand(command);
  REG_ROMCTRL = 0xe1586000;
  u32 * target = source + length;
  do {
    // Write data if ready
    if (REG_ROMCTRL & CARD_DATA_READY) {
      if (source < target) {
        if ((u32)source & 0x03)
          data = ((uint8*)source)[0] | (((uint8*)source)[1] << 8) | (((uint8*)source)[2] << 16) | (((uint8*)source)[3] << 24);
        else
          data = *source;
      }
      source++;
      CARD_DATA_RD = data;
    }
  } while (REG_ROMCTRL & CARD_BUSY);
  command[7] = 0xC6; // GMP-Z003
  ioM3CardWaitReady(0xa7586000, command);
}

u16 setup_card()
{
	u8 cmdb8[8] = {0, 0, 0, 0, 0, 0, 0, 0xb8};
	u8 cmdb4[8] = {0, 0, 0, 0x0a, 0xa0, 0x55, 0xaa, 0xb4};
	u8 cmdb0[8] = {0, 0, 0, 0, 0, 0, 0, 0xb0};
	u32 ret;

	cardPolledTransfer(0xa7586000, &ret, 1, cmdb8);
	cardPolledTransfer(0xa7586000, &ret, 1, cmdb4);
	cardPolledTransfer(0xa7586000, &ret, 1, cmdb4);
	cardPolledTransfer(0xa7586000, &ret, 1, cmdb0);

	return (u16)ret;
}

void read_blocks(u8 type, u32 offset, u8 *buffer, u32 blocks)
{
	u32 *u32_buffer = (u32*)buffer; // i am bad at pointers

	for (int block = 0; block < blocks; block++)
	{
		read_card(offset, u32_buffer, 0x80, type);
		offset += 0x200;
		u32_buffer += 0x80;
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

void write_to_flash(u32 offset, u8 *source, u32 length)
{
	// i'm sure you can bitwise this but i'm too dumb
	u32 blocks;
	if (length % 0x200)
		blocks = ((length / 0x200) + 1);
	else
		blocks = length / 0x200;

	iprintf("length %04lX = %04lX blocks\nreading...\n", length, blocks);

	u8 *buffer = (u8*) malloc(0x200 * blocks);

	// read
	u32 read_offset = offset;
	u32 *read_buffer = (u32*)buffer;

	for (int block = 0; block < blocks; block++)
	{
		read_card(read_offset, read_buffer, 0x80, 0xF0);
		read_offset += 0x200;
		read_buffer += 0x80;
	}

	iprintf("erasing... ");

	// erase
	u32 erase_offset = offset;
	for (int block = 0; block < blocks; block++)
	{
		write_card(erase_offset, 0, 0x80, 0xE0);
		erase_offset += 0x200;
		iprintf(".");
	}

	iprintf("\ncopying...\n");
	memcpy(buffer, source, length);

	iprintf("writing... ");

	// write
	u32 write_offset = offset;
	u32 *write_buffer = (u32*)buffer;
	for (int block = 0; block < blocks; block++)
	{
		write_card(write_offset, write_buffer, 0x80, 0xF0);
		write_offset += 0x200;
		write_buffer += 0x80;
		iprintf(".");
	}

	iprintf("\n");
}


int main(void) {
	consoleDemoInit();
	sysSetBusOwners(true, true);

	if(!fatInitDefault())
	{
		iprintf("fatInitDefault failed\n");
		return 0;
	}

	iprintf("m3i gmp-z003 ntrboot flasher\n");
	iprintf("may brick, be careful :)\n");

	u16 cardInfo = setup_card();
	iprintf("card Type: %04X\n", cardInfo);

	// run it twice because fuCK u
	cardInfo = setup_card();
	iprintf("card Type: %04X\n", cardInfo);


	if (cardInfo != 0x5AA5)
	{
		iprintf("error, expected 0x5AA5\n");
		waitButtonA();
		return 0;
	}

	iprintf("press A to begin\n\n");
	waitButtonA();

	/*u8 *flash_buffer = (u8*) malloc(0x200 * 0x1000);

	iprintf("1. reading flash\n");
	read_blocks(0xF0, 0, flash_buffer, 0x1000);
	display_hex(flash_buffer, 1);

	iprintf("2. saving flash...");
	
	FILE* fp = fopen("gmpz003_flash.bin", "wb");
	fwrite(flash_buffer, 0x200, 0x1000, fp);
	fclose(fp);

	free(flash_buffer);

	iprintf(" done\n\n");*/

	iprintf("reading ntr firm file");
	FILE* fp = fopen("boot9strap_ntr.firm","rb");
	if (fp == NULL)
	{
		iprintf("\ncould not find boot9strap_ntr.firm\n");
		waitButtonA();
		return 0;
	}

	fseek(fp, 0, SEEK_END);
	u32 firm_size = ftell(fp);
    u8 *firm = (u8*)malloc(firm_size);

    fseek(fp, 0, SEEK_SET);
    fread(firm, 1, firm_size, fp);
	fclose(fp);

	iprintf(" done\n");

	iprintf("press A to inject ntrboot\n");
	waitButtonA();

	iprintf("blowfish:\n");
	write_to_flash(0x1000, (u8*)blowfish_retail_bin, 0x1048);
	iprintf("firm:\n");
	write_to_flash(0x9E00, firm, firm_size);

	iprintf("injection complete.\n");
	waitButtonA();

	return 0;
}
