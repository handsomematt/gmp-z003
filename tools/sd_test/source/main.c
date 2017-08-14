/*---------------------------------------------------------------------------------

	test reading and writing to the gmp-z003's sd card

---------------------------------------------------------------------------------*/

#include <nds.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

#include "iointerface.h"

#include "display.h"

#include <fat.h>

void waitButtonA() {
	while(1) {
		scanKeys();
		swiWaitForVBlank();
		if (keysDown() & KEY_A) break;
	}
}

u32 M3B8(void)
{
  u8 cmd[8] = {0, 0, 0, 0, 0, 0, 0, 0xb8};
  u32 ret;

  cardPolledTransfer(0xa7586000, &ret, 1, cmd);
  return ret;
}

u32 M3B4(void)
{
  u8 cmd[8] = {0, 0, 0, 0x0a, 0xa0, 0x55, 0xaa, 0xb4};
  u32 ret;

  cardPolledTransfer(0xa7586000, &ret, 1, cmd);
  return ret;
}

void readSW(u32 address, u32 *destination, u32 length, u8 type)
{
  u8 command[8];

  command[7] = 0xC9; // GMP-Z003
  command[6] = (address >> 24) & 0xff;
  command[5] = (address >> 16) & 0xff;
  command[4] = (address >> 8)  & 0xff;
  command[3] =  address        & 0xff;
  command[2] = type; // SW
  command[1] = 0;
  command[0] = 0;
  ioM3CardWaitReady(0xa7586000, command); // request

  command[7] = 0xCA; // GMP-Z003
  cardPolledTransfer(0xa1586000, destination, length, command);
}

bool readSWSectors(u32 sector, u32 numSecs, void* buffer, u8 type)
{
  u32 *u32_buffer = (u32*)buffer, i;

  for (i = 0; i < numSecs; i++) {
    readSW(sector << 9, u32_buffer, 128, type);
    sector++;
    u32_buffer += 128;
  }
  return true;
}

int main(void) {
	initDisplay();

	if(!fatInitDefault())
		kprintf("Init FAT: Error!\n");

	kprintf("gmpz003 sw dumper - A to begin\n");
	waitButtonA();

	sysSetBusOwners(true, true);

	kprintf("B8: %08X\n", M3B8()); // 4034 FC2
	kprintf("B4: %08X\n", M3B4()); // 4294967295 FFFFFFFF
	kprintf("B4: %08X\n", M3B4()); // 4294967295 FFFFFFFF

	u32 cardInfo = ioM3ReadCardInfo();
	kprintf("Card info: %08X\n", (unsigned short)cardInfo); // 508 1FC

	if ((unsigned short)cardInfo != 0x5AA5)
	{
		kprintf("Unsupported card.");
		waitButtonA();
		return;
	}

	kprintf("Press A to read SW sectors.");
	waitButtonA();

	static u8 data[2097152];
	//readSWSectors(0, 4096, &data, 0xE0); // SW header
	//readSWSectors(0, 4096, &data, 0xF0); // SW regular
	readSWSectors(0, 4096, &data, 0xA0); // HW

	kprintf(" A to display\n");

	waitButtonA();

	// Print 20 rows of 8 bytes each
	for(int y=0; y<80; y++) {

		if (y % 20 == 0)
			waitButtonA();

		// print 8 bytes as hex
		for(int x=0; x<8; x++) {
			kprintf("%02x", data[y*8 + x]);
		}

		kprintf(" ");

		for(int x=0; x<8; x++) {
			kprintf("%c", data[y*8 + x]);
		}

		kprintf("\n");
	}

	kprintf("Press a to write to file\n");
	waitButtonA();

    FILE* fp = fopen("hw_a0.bin", "wb");
    if(!fp) kprintf("Writing Error!\n");
    else
    {
      fwrite(data, 1, 2097152, fp);
      fclose(fp);
    }

  	kprintf("Done.");
	waitButtonA();

	return 0;
}
