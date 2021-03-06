OP = {"IMM":b"\x40", "LDM":b"\x08", "SYS":b"\x21", "STM":b"\x10"}
REG = {"a":b"\x20", "b":b"\x40", "c":b"\x02", "d":b"\x01", "s":b"\x10"}

i_file = open(input(),"r")
o_file = open("a.out", "wb")

code = b""
lines = i_file.readlines()
i_file.close()
for line in lines:
	op = line.split(" ")[0]
	code += OP[op]
	operands = line.split(" ")[1].split(",")
	print(operands)
	operands.reverse()
	for operand in operands:
		operand = operand.strip()
		if "0x" in operand:
			code += int(operand,16).to_bytes(1,'little')
		else:
			code += REG[operand]
	
o_file.write(code)
			


