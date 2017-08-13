#include <nds/card.h>

void ioM3CardWaitReady(u32 flags, u8 *command);
void ioM3ByteCardPolledTransfer(uint32 flags, uint32 * destination, uint32 length, uint8 * command);
void ioM3LogicCardRead(u32 address, u32 *destination, u32 length);
void ioM3LogicCardWrite(u32 address, u32 *source, u32 length);
u32 ioM3ReadCardInfo(void);

bool startup(void);
bool isInserted(void);
bool readSectors(u32 sector, u32 numSecs, void* buffer);
bool writeSectors(u32 sector, u32 numSecs, void* buffer);
bool clearStatus(void);
bool shutdown(void);