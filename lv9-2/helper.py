def load_string(s):
	for i,j in enumerate(s):
		print("IMM c,%s" % hex(i+1))
		print("IMM d,%s" % hex(j))
		print("STM c,d")

def read_string(address, l):
	for i in range(address, address+l):
		print("IMM d,%s" % hex(i))
		print("LDM c,d")

def open_file(address, flag, arg):
	#print("IMM a,%s" % hex(address))
	print("IMM b,%s" % hex(flag))
	print("SYS 0x02,%s" % arg)

def read_file(f_idx, address, count):
	#print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x10,d")

def load_file(f_idx, address, count):
	#print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x08,d")

def write_file(f_idx, address, count):
	#print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x04,d")

def crash():
	print("IMM 0xff,0xff")

print("IMM d,%s" % hex(101))
print("STM c,d")

load_string(b"xploit")
open_file(1, 2, "d")
load_file(20, 0x80, 0xff)
