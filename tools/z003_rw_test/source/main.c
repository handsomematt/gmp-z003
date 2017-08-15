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

void read_test(u8 type, u32 offset, u8 *buffer, u32 blocks)
{
	u32 *u32_buffer = (u32*)buffer; // i am bad at pointers

	for (int block = 0; block < blocks; block++)
	{
		read_card(offset, u32_buffer, 0x80, type);
		offset += 0x200;
		u32_buffer += 0x80;
	}

	for(int y=0; y<4; y++)
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

void write_test(u8 type, u32 offset, u8 *buffer, u32 blocks)
{
	u32 *u32_buffer = (u32*)buffer; // i am bad at pointers

	for (int block = 0; block < blocks; block++)
	{
		write_card(offset, u32_buffer, 0x80, type);
		offset += 0x200;
		u32_buffer += 0x80;
	}

	iprintf("WRITTEN\n");
}

void erase_test(u32 offset, u32 blocks)
{
	for (int block = 0; block < blocks; block++)
	{
		write_card(offset, 0, 0x80, 0xE0);
		offset += 0x200;
	}

	iprintf("ERASED\n");
}

int main(void) {
	consoleDemoInit();
	sysSetBusOwners(true, true);

	if(!fatInitDefault())
	{
		iprintf("fatInitDefault failed\n");
		return 0;
	}

	iprintf("m3i gmp-z003 read write test\n");

	u16 cardInfo = setup_card();
	iprintf("card Type: %04X\n", cardInfo);

	if (cardInfo != 0x5AA5)
	{
		iprintf("unsupported, expected 0x5AA5\n");
		waitButtonA();
		return 0;
	}

	iprintf("press A to begin test\n\n");
	waitButtonA();

	u8 *buffer = (u8*) malloc(0x200 * 1);
	read_test(0xF0, 0x0, buffer, 1);
	buffer[0] = 0x50;
	buffer[1] = 0x50;
	buffer[2] = 0x50;
	buffer[3] = 0x50;
	waitButtonA();
	erase_test(0x0, 1);
	write_test(0xF0, 0x0, buffer, 1);
	waitButtonA();
	read_test(0xF0, 0x0, buffer, 1);
	waitButtonA();

	buffer[0] = 0x44;
	buffer[1] = 0x45;
	buffer[2] = 0x45;
	buffer[3] = 0x50;
	erase_test(0x0, 1);
	write_test(0xF0, 0x0, buffer, 1);
	waitButtonA();
	read_test(0xF0, 0x0, buffer, 1);

	waitButtonA();

	free(buffer);

	return 0;
}
