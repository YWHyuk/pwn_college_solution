def load_string(s):
	for i,j in enumerate(s):
		print("IMM a,%s" % hex(i))
		print("IMM b,%s" % hex(j))
		print("LDM a,b")

def open_file(address, flag):
	print("IMM a,%s" % hex(address))
	print("IMM b,%s" % hex(flag))
	print("SYS 0x08,a")

def read_file(f_idx, address, count):
	print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x10,a")

def write_file(f_idx, address, count):
	print("IMM a,%s" % hex(f_idx))
	print("IMM b,%s" % hex(address))
	print("IMM c,%s" % hex(count))
	print("SYS 0x04,a")

load_string(b"/flag\x00")
open_file(0, 0)
load_string(b"/tmp/f\x00")
open_file(0, 2)
read_file(0, 0, 0x40)
write_file(1,0,0x40)

