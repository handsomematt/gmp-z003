#include "cart_commands.h"

void m3_card_wait_ready(u32 flags, u8 *command)
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
  m3_card_wait_ready(0xa7586000, command);

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
  m3_card_wait_ready(0xa7586000, command);
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
	// repeat the same commands again - puts it in a known state :s
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