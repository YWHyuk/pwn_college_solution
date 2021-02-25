import sys
import binascii
def myreadline():
    s = b""
    while True:
        c = sys.stdin.buffer.read(1)
        if c == b"\n" or c == b"":
            return s
        s = s + c

while True:
    a = myreadline()
    if a == b"":
        break
    print(a)
    addr_idx = a.find(b"MESSAGE: ")
    if addr_idx == -1:
        continue

    k = a[addr_idx + len(b"MESSAGE: "):]  
    print(binascii.hexlify(k[::-1]))
	
