OP = {"IMM":b"\x01", "LDM":b"\x04", "SYS":b"\x28", "STM":b"\x02"}
REG = {"a":b"\x01", "b":b"\x40", "c":b"\x02", "d":b"\x04", "s":b"\x10"}

i_file = open(input(),"r")
o_file = open("a.out", "wb")

code = b""
lines = i_file.readlines()
i_file.close()
for line in lines:
	op = line.split(" ")[0]
	operands = line.split(" ")[1].split(",")
	print(operands)
	tmp_code = []
	for operand in operands:
		operand = operand.strip()
		if "0x" in operand:
			tmp_code.append(int(operand,16).to_bytes(1,'little'))
		else:
			tmp_code.append(REG[operand])
	code = code + tmp_code[0] + OP[op] + tmp_code[1]
	
o_file.write(code)
			


