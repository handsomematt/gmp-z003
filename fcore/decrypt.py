import array
import struct
import sys

# 0x000000 -> 0x200000 Encrypted NDS ROM
# 0x184000 -> 0x200000 Encrypted Passcard4 ROM

# 0x200000 -> 0x400000 NDS ROM
# 0x380000 -> 0x400000 Passcard4 ROM

# 0x400000 -> 0x600000 FF filled with 512 byte end

# collect params
infilename = sys.argv[1] if len(sys.argv) > 1 else 'F_CORE.DAT'
outfolder = sys.argv[2] if len(sys.argv) > 2 else 'out'
keyfilename = sys.argv[3] if len(sys.argv) > 3 else 'key.bin'

# load our key (might be different for different models?)
keybytes = array.array('B')
keybytes.fromfile(open(keyfilename, 'rb'), 256)

f = open(infilename, 'rb')

data = f.read(0x200000)
dataout = array.array('B')

for b in data:
	b = struct.unpack('B', b)[0]
	dataout.append(keybytes[b])

output = open('out/1.nds', 'wb')
output.write(dataout)
output.close();

output = open('out/2.nds', 'wb')
output.write(f.read(0x200000))
output.close();

output = open('out/3.bin', 'wb')
output.write(f.read(0x200000))
output.close();

f.close();
