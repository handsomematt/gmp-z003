#pragma once

#include <nds.h>
#include <ctype.h>

void m3_card_wait_ready(u32 flags, u8 *command);
void read_card(u32 address, u32 *destination, u32 length, u8 type);
void write_card(u32 address, u32 *source, u32 length, u8 type);
u16 setup_card();
void read_blocks(u8 type, u32 offset, u8 *buffer, u32 blocks);