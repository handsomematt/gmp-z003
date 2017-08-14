#include <nds.h>
#include <fat.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

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

void dump(u8 type, u32 offset, u32 blocks, char* filename)
{
	u8 *buffer = (u8*) malloc(blocks * 0x200);
	u32 *u32_buffer = (u32*)buffer; // i am bad at pointers

	iprintf("dumping type: %02X\n@%08lX length: %08lX\n", type, offset, blocks * 0x200);

	for (int block = 0; block < blocks; block++)
	{
		read_card(offset, u32_buffer, 0x80, type);
		offset += 0x200;
		u32_buffer += 0x80;
	}

	iprintf("done, writing to file..");

	FILE* fp = fopen(filename, "wb");
	fwrite(buffer, 0x200, blocks, fp);
	fclose(fp);

	free(buffer);

	iprintf("done.\n\n");
}

int main(void) {
	consoleDemoInit();
	sysSetBusOwners(true, true);

	if(!fatInitDefault())
	{
		iprintf("fatInitDefault failed\n");
		return 0;
	}

	iprintf("m3i gmp-z003 dumper\n");

	u16 cardInfo = setup_card();
	iprintf("card Type: %04X\n", cardInfo);

	if (cardInfo != 0x5AA5)
	{
		iprintf("unsupported, expected 0x5AA5\n");
		waitButtonA();
		return 0;
	}

	iprintf("press A to begin dumping\n");
	waitButtonA();

	dump(0xF0, 0x0, 0x1000, "dump_f0.bin");
	dump(0xA0, 0x0, 0x80, "dump_a0.bin");

	waitButtonA();

	return 0;
}
