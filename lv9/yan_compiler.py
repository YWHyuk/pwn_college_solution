OP = {"IMM":b"0x40", "LDM":b"0x08", "SYS":b"0x20"}
REG = {"a":b"0x20", "b":b"0x40", "c":b"0x02"}
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
	for operand in operands:
		operand = operand.strip()
		if "0x" in operand:
			code += int(operand,16).to_bytes(1,'little')
		else:
			code += REG[operand]
	
o_file.write(code)
			


