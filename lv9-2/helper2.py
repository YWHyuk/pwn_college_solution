def load_string(s, address):
	for i,j in enumerate(s):
		print("IMM c,%s" % hex(address + i))
		print("IMM d,%s" % hex(j))
		print("STM c,d")

def read_string(address, l):
	for i in range(address, address+l):
		print("IMM d,%s" % hex(i))
		print("LDM c,d")

def open_file(address, flag, arg):
	print("IMM a,%s" % hex(address))
	print("IMM b,%s" % hex(flag))
	print("SYS 0x02,%s" % arg)

def read_file(f_idx, address, count):
	print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x10,d")

def load_file(f_idx, address, count):
	print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x08,d")

def write_file(f_idx, address, count):
	print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x04,d")

def crash():
	print("IMM 0xff,0xff")

load_string(b"/flag", 0x20)
open_file(0x20, 2, "d")
load_string(b"/home/ctf/flag", 0x20)
open_file(0x20, 2, "d")

read_file(1, 0, 0x40)
write_file(2, 0, 0x40)
crash()
