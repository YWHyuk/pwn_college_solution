import os
os.system("gcc -c slim.s")
os.system("gcc -c sc.s")
os.system("ld -o slim slim.o")
os.system("ld -o sc -Ttext 0x1337000 sc.o")
os.system("strip -s slim")
os.system("objcopy -O binary --only-section=.text sc bin")
a =  open("slim", "rb")
l = a.readline()
k = ".byte "

for i,j in enumerate(l):
    k = k + hex(j) + ","
    if i % 16 == 15:
        print(k[:-1])
        k = ".byte "

