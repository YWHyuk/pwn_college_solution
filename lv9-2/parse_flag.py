a = open("raw_flag", "r")
lines = a.readlines()
l = int(lines[2].split(": ")[-1],16)
code = ""
for i in range(l):
	target = lines[6*i + 3]
	print(target)
	val = target[target.find("c:")+2: target.find("c:")+2+4]
	code += chr(int(val,16))

print(code)
