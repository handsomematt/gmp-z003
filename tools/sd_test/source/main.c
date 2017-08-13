/*---------------------------------------------------------------------------------

	test reading and writing to the gmp-z003's sd card

---------------------------------------------------------------------------------*/

#include <nds.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

#include "iointerface.h"

#include "display.h"

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
  u8 cmd[8] = {0, 0, 0, 0xa0, 0xa0, 0x55, 0xaa, 0xb4};
  u32 ret;

  cardPolledTransfer(0xa7586000, &ret, 1, cmd);
  return ret;
}

int main(void) {
	initDisplay();

	kprintf("gmpz003 sd_test - A to begin\n");
	waitButtonA();

	sysSetBusOwners(true, true);

	kprintf("B8: %08X\n", M3B8()); // 4034 FC2
	kprintf("B4: %08X\n", M3B4()); // 4294967295 FFFFFFFF
	kprintf("B4: %08X\n", M3B4()); // 4294967295 FFFFFFFF

	u32 cardInfo = ioM3ReadCardInfo();
	kprintf("Card info: %08X\n", cardInfo); // 1015808508 0x3C8C01FC
	kprintf("Card info: %08X\n", (unsigned short)cardInfo); // 508 1FC

	waitButtonA();

	kprintf("Reading M3i SD card..");

	static u8 data[2048];
	readSectors(0, 4, &data);
	// read(0, data, 512);

	kprintf(" A to display\n");

	waitButtonA();

	// Print 20 rows of 8 bytes each
	for(int y=0; y<80; y++) {

		if (y % 20 == 0)
			waitButtonA();

		kprintf("%04x: ", y*8);

		// print 8 bytes as hex
		for(int x=0; x<8; x++) {
			kprintf("%02x ", data[y*8 + x]);
		}

		kprintf("\n");
	}

	waitButtonA();

	return 0;
}
