x00			0x300	   0x400 0x408	                 0x508
|--------------------------|---------|----|-----------------------|
           code		     memory  register     file table

0) IMM reg, imm : 	"[s] IMM %s = %#hhx\n"
1) ADD reg,reg :     	"[s] ADD %s %s\n"
2) STK reg,reg :     	"[s] STK %s %s\n"
	push reg:     	"[s] ... pushing %s\n"
	pop reg:	"[s] ... popping %s\n"
3) STM reg,reg:		"[s] STM *%s = %s\n"
4) LDM reg,reg:     	"[s] LDM %s = *%s\n"
5) CMP reg,reg:		"[s] CMP %s %s\n"
6) JMP reg,reg::     	"[j] JMP %s %s\n"
	"[j] ... TAKEN\n"
	"[j] ... NOT TAKEN\n"
7) SYS arg, reg 	After operation, write return value to register.
	arg 0x08:	a(name address), b(flag), c(mode)
	arg 0x01	a(file idx), b(address), c(size) 	"[s] ... read_code\n"
	arg 0x10	a(file idx), b(address), c(size)	"[s] ... read_memory\n"
	arg 0x04	a(file idx), b(address), c(size)	"[s] ... write\n"

device_write
   0xffffffffc00009de:  push   rbp
   0xffffffffc00009df:  mov    rbp,rsi
   0xffffffffc00009e2:  push   rbx
   0xffffffffc00009e3:  mov    rbx,rdx
   0xffffffffc00009e6:  push   r8
   0xffffffffc00009e8:  mov    r8,rcx
   0xffffffffc00009eb:  mov    rcx,rdx
   0xffffffffc00009ee:  mov    rdx,rsi
   0xffffffffc00009f1:  mov    rsi,rdi
   0xffffffffc00009f4:  mov    rdi,0xffffffffc0001128
   0xffffffffc00009fb:  call   0xffffffff810b52e9 <printk>
   0xffffffffc0000a00:  cmp    rbx,0x300
   0xffffffffc0000a07:  mov    rsi,rbp
   0xffffffffc0000a0a:  mov    edx,0x300
   0xffffffffc0000a0f:  cmovbe rdx,rbx
   0xffffffffc0000a13:  mov    rdi,0xffffffffc0002440			#struct {uint16_t a, uint8_t b} k;
   0xffffffffc0000a1a:  call   0xffffffff813ab2c0 <_copy_from_user>	#k * buffer = 0x2440에 유저 버퍼를 복사. max count는 0x300.
   0xffffffffc0000a1f:  mov    rbp,raxq	
loop:
   0xffffffffc0000a22:  movzx  eax,BYTE PTR [0xffffffffc0002845] 	# char tmp의 값을 읽기.
   0xffffffffc0000a29:  mov    rdi,0xffffffffc0002440
   0xffffffffc0000a30:  lea    edx,[rax+0x1]				# edx = tmp + 1
   0xffffffffc0000a33:  lea    rax,[rax+rax*2]				# rax = tmp * 3
   0xffffffffc0000a37:  mov    si,WORD PTR [0xffffffffc0002440 + rax]	# si = buffer[tmp].a
   0xffffffffc0000a3e:  mov    BYTE PTR [0xffffffffc0002845],dl		# tmp++
   0xffffffffc0000a44:  mov    WORD PTR [rsp+0x5],si			# local = si
   0xffffffffc0000a49:  movzx  edx,sil					# edx = si & 0xff
   0xffffffffc0000a4d:  movzx  esi,BYTE PTR [rsp+0x6]			# esi = local & 0xff00
   0xffffffffc0000a52:  shl    rsi,0x8					# rsi <<= 8
   0xffffffffc0000a56:  or     rdx,rsi					# 읽어온 값을 endian을 변환.
   0xffffffffc0000a59:  movzx  esi,BYTE PTR [0xffffffffc0002442 + rax]	# esi = buffer[tmp].b 단, 증감한 값은 아직 반영 안된다.
   0xffffffffc0000a60:  shl    rsi,0x10					# rsi << 16
   0xffffffffc0000a64:  or     rsi,rdx					# rsi = b:a.hi:a.lo
   0xffffffffc0000a67:  call   0xffffffffc00008e8 <interpret_instruction>
   0xffffffffc0000a6c:  mov    esi,DWORD PTR [0xffffffffc0003048]
   0xffffffffc0000a72:  test   esi,esi
   0xffffffffc0000a74:  je     loop

   0xffffffffc0000a76:  mov    rdi,0xffffffffc0001168
   0xffffffffc0000a7d:  call   0xffffffff810b52e9 <printk>
   0xffffffffc0000a82:  mov    rax,rbx
   0xffffffffc0000a85:  pop    rdx
   0xffffffffc0000a86:  pop    rbx
   0xffffffffc0000a87:  sub    rax,rbp
   0xffffffffc0000a8a:  pop    rbp
   0xffffffffc0000a8b:  ret

#define	A	0x20
#define	B	0x40
#define	C	0x02
#define D	0x01
#define S	0x10
#define I	0x08
#define F	0x04
#define NON	0x00

#define REG_A	0x00
#define REG_B	0x01
#define REG_C	0x02
#define REG_D	0x03
#define REG_S	0x04
#define REG_I	0x05
#define REG_F	0x06

char *describe_register(char arg1){
	swtich(dil){
		case 0x20:
			return "a";
		case 0x40:
			return "b";
		case 0x02:
			return "c";
		case 0x01:
			return "d";
		case 0x10:
			return "s";
		case 0x08:
			return "i";
		case 0x04:
			return "f";
		case 0x00:
			return "NONE";
		return "?";
	}
}

byte read_register(byte* register_file, byte register){
	switch(register){
		case A:
			return	register_file[REG_A];
		case B:
			return register_file[REG_B] 
		case C:
			return register_file[REG_C] 
		case D:
			return register_file[REG_D] 
		case S:
			return register_file[REG_S] 
		case I:
			return register_file[REG_I] 
		case F:
			return register_file[reg_F] 
		crash();
	}
}

void write_register(byte* register_file, byte register, byte value){
	switch(register){
		case A:
			register_file[REG_A] = value;
			return;
		case B:
			register_file[REG_B] = value;
			return
		case C:
			register_file[REG_C] = value;
			return
		case D:
			register_file[REG_D] = value;
			return
		case S:
			register_file[REG_S] = value;
			return
		case I:
			register_file[REG_I] = value;
			return
		case F:
			register_file[reg_F] = value;
			return
		crash();
	}
}

<interpret_stm>
rsi = opcode and args, rdi = 0xffffffffc0002440
0xffffffffc00004f5:  push   r12
   0xffffffffc00004f7:  push   rbp
   0xffffffffc00004f8:  push   rbx
   0xffffffffc00004f9:  mov    rbx,rdi
=> 0xffffffffc00004fc:  push   rax
   0xffffffffc00004fd:  mov    QWORD PTR [rsp],rsi
   0xffffffffc0000501:  movzx  ebp,BYTE PTR [rsp+0x1]
   0xffffffffc0000506:  mov    edi,ebp
   0xffffffffc0000508:  call   0xffffffffc0000000
   0xffffffffc000050d:  movzx  r12d,BYTE PTR [rsp+0x2]
   0xffffffffc0000513:  mov    r8,rax
   0xffffffffc0000516:  mov    edi,r12d
   0xffffffffc0000519:  call   0xffffffffc0000000
   0xffffffffc000051e:  mov    rdi,0xffffffffc0001256	#"[s] STM *%s = %s\n"
   0xffffffffc0000525:  mov    rdx,r8
   0xffffffffc0000528:  mov    rsi,rax
   0xffffffffc000052b:  call   0xffffffff810b52e9 <printk>
   0xffffffffc0000530:  mov    esi,ebp
   0xffffffffc0000532:  mov    rdi,rbx
   0xffffffffc0000535:  call   0xffffffffc0000190
   0xffffffffc000053a:  mov    esi,r12d
   0xffffffffc000053d:  mov    rdi,rbx
   0xffffffffc0000540:  mov    ebp,eax
   0xffffffffc0000542:  call   0xffffffffc0000190
   0xffffffffc0000547:  movzx  eax,al
   0xffffffffc000054a:  mov    BYTE PTR [rbx+rax*1+0x300],bpl
   0xffffffffc0000552:  pop    rdx
   0xffffffffc0000553:  pop    rbx
   0xffffffffc0000554:  pop    rbp
   0xffffffffc0000555:  pop    r12
   0xffffffffc0000557:  ret

<interpret_sys>
rsi = opcode and args, rdi = 0xffffffffc0002440
   0xffffffffc0000695:  push   r15
   0xffffffffc0000697:  push   r14
   0xffffffffc0000699:  push   r13
   0xffffffffc000069b:  push   r12
   0xffffffffc000069d:  push   rbp
   0xffffffffc000069e:  mov    rbp,rdi
   0xffffffffc00006a1:  push   rbx
   0xffffffffc00006a2:  push   r8
   0xffffffffc00006a4:  mov    QWORD PTR [rsp],rsi
   0xffffffffc00006a8:  movzx  r12d,BYTE PTR [rsp+0x1] #arg2
   0xffffffffc00006ae:  mov    bl,BYTE PTR [rsp+0x2]
   0xffffffffc00006b2:  mov    edi,r12d # edi = arg2
   0xffffffffc00006b5:  mov    r14d,r12d
   0xffffffffc00006b8:  call   0xffffffffc0000000
   0xffffffffc00006bd:  movzx  esi,bl	# arg1
   0xffffffffc00006c0:  mov    rdi,0xffffffffc00012c6 		# "[s] SYS %#hhx %s\n" 
   0xffffffffc00006c7:  mov    rdx,rax
   0xffffffffc00006ca:  mov    r13,rax
   0xffffffffc00006cd:  call   0xffffffff810b52e9 <printk>	# instrucrtion and register name
   0xffffffffc00006d2:  test   bl,0x8
   0xffffffffc00006d5:  je     0xffffffffc0000745

	   0xffffffffc00006d7:  mov    rdi,0xffffffffc00012da 	# "[s] ... open\n"
	   0xffffffffc00006de:  call   0xffffffff810b52e9 <printk>
	   0xffffffffc00006e3:  xor    eax,eax
loop:
	   0xffffffffc00006e5:  cmp    QWORD PTR [rbp+rax*8+0x408],0x0
	   0xffffffffc00006ee:  mov    r15d,eax
	   0xffffffffc00006f1:  jne    0xffffffffc0000725

		   0xffffffffc00006f3:  movzx  eax,BYTE PTR [rbp+0x400]
		   0xffffffffc00006fa:  movzx  edx,BYTE PTR [rbp+0x402]	# 무시
		   0xffffffffc0000701:  movzx  esi,BYTE PTR [rbp+0x401] # Target O_RD로 세팅
		   0xffffffffc0000708:  lea    rdi,[rbp+rax*1+0x300]	# rax + 0xffffffffc0002740
		   0xffffffffc0000710:  call   0xffffffff811c5100 <filp_open>
		   0xffffffffc0000715:  mov    r8,rax
		   0xffffffffc0000718:  movsxd rax,r15d
		   0xffffffffc000071b:  mov    QWORD PTR [rbp+rax*8+0x408],r8
		   0xffffffffc0000723:  jmp    0xffffffffc0000736 #break

	   0xffffffffc0000725:  inc    rax
	   0xffffffffc0000728:  cmp    rax,0x100
	   0xffffffffc000072e:  jne    0xffffffffc00006e5	#loop

	   0xffffffffc0000730:  mov    r15d,0x100
	   0xffffffffc0000736:  movzx  edx,r15b
	   0xffffffffc000073a:  mov    esi,r12d
	   0xffffffffc000073d:  mov    rdi,rbp
	   0xffffffffc0000740:  call   write_register(register_file, arg2, idx) 

   0xffffffffc0000745:  test   bl,0x1
   0xffffffffc0000748:  je     0xffffffffc00007a9

	   0xffffffffc000074a:  mov    rdi,0xffffffffc00012ea #"[s] ... read_code\n"
	   0xffffffffc0000751:  call   0xffffffff810b52e9 <printk>
	   0xffffffffc0000756:  movzx  eax,BYTE PTR [rbp+0x400]
	   0xffffffffc000075d:  mov    edx,0x100
	   0xffffffffc0000762:  mov    rdi,QWORD PTR [rbp+rax*8+0x408]
	   0xffffffffc000076a:  movzx  eax,BYTE PTR [rbp+0x401]
	   0xffffffffc0000771:  sub    edx,eax	#0x100 - b
	   0xffffffffc0000773:  mov    rsi,rax	
	   0xffffffffc0000776:  movzx  eax,BYTE PTR [rbp+0x402] c
	   0xffffffffc000077d:  lea    rcx,[rdi+0x68]
	   0xffffffffc0000781:  movsxd rdx,edx
	   0xffffffffc0000784:  lea    rsi,[rsi+rsi*2] 3b
	   0xffffffffc0000788:  lea    rdx,[rdx+rdx*2] 3(0x100-b)
	   0xffffffffc000078c:  cmp    rdx,rax
	   0xffffffffc000078f:  cmova  rdx,rax
	   0xffffffffc0000793:  add    rsi,rbp
	   0xffffffffc0000796:  call   0xffffffff811c8ab0 <kernel_read>
	   0xffffffffc000079b:  mov    esi,r12d
	   0xffffffffc000079e:  mov    rdi,rbp
	   0xffffffffc00007a1:  movzx  edx,al
	   0xffffffffc00007a4:  call   0xffffffffc0000200

   0xffffffffc00007a9:  test   bl,0x10
   0xffffffffc00007ac:  je     0xffffffffc000080d

	   0xffffffffc00007ae:  mov    rdi,0xffffffffc00012ff
	   0xffffffffc00007b5:  call   0xffffffff810b52e9 <printk>
	   0xffffffffc00007ba:  movzx  ecx,BYTE PTR [rbp+0x401]
	   0xffffffffc00007c1:  mov    edx,0x100
	   0xffffffffc00007c6:  movzx  eax,BYTE PTR [rbp+0x400]
	   0xffffffffc00007cd:  sub    edx,ecx # a-b
	   0xffffffffc00007cf:  mov    rdi,QWORD PTR [rbp+rax*8+0x408] #rdi = filp
	   0xffffffffc00007d7:  mov    rax,rcx	rax= b
	   0xffffffffc00007da:  movzx  ecx,BYTE PTR [rbp+0x402] ecx= c
	   0xffffffffc00007e1:  movsxd rdx,edx	
	   0xffffffffc00007e4:  lea    rsi,[rbp+rax*1+0x300] #rsi=memory+b
	   0xffffffffc00007ec:  cmp    rdx,rcx
	   0xffffffffc00007ef:  lea    r8,[rdi+0x68]
	   0xffffffffc00007f3:  cmova  rdx,rcx
	   0xffffffffc00007f7:  mov    rcx,r8
	   0xffffffffc00007fa:  call   0xffffffff811c8ab0 <kernel_read>
	   0xffffffffc00007ff:  mov    esi,r12d
	   0xffffffffc0000802:  mov    rdi,rbp
	   0xffffffffc0000805:  movzx  edx,al
	   0xffffffffc0000808:  call   0xffffffffc0000200

   0xffffffffc000080d:  test   bl,0x4
   0xffffffffc0000810:  je     0xffffffffc0000871

   0xffffffffc0000812:  mov    rdi,0xffffffffc0001316
   0xffffffffc0000819:  call   0xffffffff810b52e9 <printk>
   0xffffffffc000081e:  movzx  ecx,BYTE PTR [rbp+0x401]
   0xffffffffc0000825:  mov    edx,0x100
   0xffffffffc000082a:  movzx  eax,BYTE PTR [rbp+0x400]
   0xffffffffc0000831:  sub    edx,ecx
   0xffffffffc0000833:  mov    rdi,QWORD PTR [rbp+rax*8+0x408]
   0xffffffffc000083b:  mov    rax,rcx
   0xffffffffc000083e:  movzx  ecx,BYTE PTR [rbp+0x402]
   0xffffffffc0000845:  movsxd rdx,edx
   0xffffffffc0000848:  lea    rsi,[rbp+rax*1+0x300]
   0xffffffffc0000850:  cmp    rdx,rcx
   0xffffffffc0000853:  lea    r8,[rdi+0x68]
   0xffffffffc0000857:  cmova  rdx,rcx
   0xffffffffc000085b:  mov    rcx,r8
   0xffffffffc000085e:  call   0xffffffff811c8c80 <kernel_write>
   0xffffffffc0000863:  mov    esi,r12d
   0xffffffffc0000866:  mov    rdi,rbp
   0xffffffffc0000869:  movzx  edx,al
   0xffffffffc000086c:  call   0xffffffffc0000200
   0xffffffffc0000871:  test   bl,0x20
   0xffffffffc0000874:  je     0xffffffffc0000891

	   0xffffffffc0000876:  mov    rdi,0xffffffffc0001327 	#"[s] ... sleep\n"
	   0xffffffffc000087d:  call   0xffffffff810b52e9 <printk>
	   0xffffffffc0000882:  mov    rsi,0xffffffffc0001338
	   0xffffffffc0000889:  mov    rdi,rbp
	   0xffffffffc000088c:  call   crash

   0xffffffffc0000891:  and    bl,0x2
   0xffffffffc0000894:  je     0xffffffffc00008af

	   0xffffffffc0000896:  mov    rdi,0xffffffffc0001341	#"[s] ... exit\n"
	   0xffffffffc000089d:  call   0xffffffff810b52e9 <printk>
	   0xffffffffc00008a2:  movzx  eax,BYTE PTR [rbp+0x400]
	   0xffffffffc00008a9:  mov    DWORD PTR [rbp+0xc08],eax

   0xffffffffc00008af:  test   r14b,r14b
   0xffffffffc00008b2:  je     0xffffffffc00008dc

	   0xffffffffc00008b4:  mov    esi,r12d
	   0xffffffffc00008b7:  mov    rdi,rbp
	   0xffffffffc00008ba:  call   0xffffffffc0000190	#write_register
	   0xffffffffc00008bf:  mov    rsi,r13
	   0xffffffffc00008c2:  pop    rcx
	   0xffffffffc00008c3:  mov    rdi,0xffffffffc0001090 	#"[s] ... return value (in register %s): %#hhx\n"
	   0xffffffffc00008ca:  pop    rbx
	   0xffffffffc00008cb:  movzx  edx,al
	   0xffffffffc00008ce:  pop    rbp
	   0xffffffffc00008cf:  pop    r12
	   0xffffffffc00008d1:  pop    r13
	   0xffffffffc00008d3:  pop    r14
	   0xffffffffc00008d5:  pop    r15
	   0xffffffffc00008d7:  jmp    0xffffffff810b52e9 <printk>

   0xffffffffc00008dc:  pop    rax
   0xffffffffc00008dd:  pop    rbx
   0xffffffffc00008de:  pop    rbp
   0xffffffffc00008df:  pop    r12
   0xffffffffc00008e1:  pop    r13
   0xffffffffc00008e3:  pop    r14
   0xffffffffc00008e5:  pop    r15
   0xffffffffc00008e7:  ret

<interpret_instruction>
   0xffffffffc00008e8:  push   rbp
   0xffffffffc00008e9:  mov    rbp,rdi
   0xffffffffc00008ec:  push   rbx
   0xffffffffc00008ed:  mov    ebx,esi
   0xffffffffc00008ef:  push   rcx
   0xffffffffc00008f0:  mov    QWORD PTR [rsp],rsi
   0xffffffffc00008f4:  movzx  eax,BYTE PTR [rdi+0x406]			# 0xffffffffc0002440가 각 레지스터들을 virtualize하는 주소.
   0xffffffffc00008fb:  movzx  ecx,BYTE PTR [rdi+0x402]
   0xffffffffc0000902:  movzx  edx,BYTE PTR [rdi+0x401]
   0xffffffffc0000909:  movzx  esi,BYTE PTR [rdi+0x400]
   0xffffffffc0000910:  push   rax
   0xffffffffc0000911:  movzx  eax,BYTE PTR [rdi+0x405]
   0xffffffffc0000918:  push   rax
   0xffffffffc0000919:  movzx  r9d,BYTE PTR [rdi+0x404]
   0xffffffffc0000921:  movzx  r8d,BYTE PTR [rdi+0x403]
   0xffffffffc0000929:  mov    rdi,0xffffffffc00010c0			#"[V] a:%#hhx b:%#hhx c:%#hhx d:%#hhx s:%#hhx i:%#hhx f:%#hhx\n"
   0xffffffffc0000930:  call   0xffffffff810b52e9 <printk>
   0xffffffffc0000935:  movzx  ecx,BYTE PTR [rsp+0x11]
   0xffffffffc000093a:  movzx  esi,bl
   0xffffffffc000093d:  movzx  edx,BYTE PTR [rsp+0x12]
   0xffffffffc0000942:  mov    rdi,0xffffffffc0001100			#     op=count arg1=rsi[2] arg2=rsi[1]
   0xffffffffc0000949:  call   0xffffffff810b52e9 <printk>		#"[I] op:%#hhx arg1:%#hhx arg2:%#hhx\n"
   0xffffffffc000094e:  pop    rsi
   0xffffffffc000094f:  pop    rdi
   0xffffffffc0000950:  test   bl,0x40
   0xffffffffc0000953:  je     0xffffffffc0000961 

	   0xffffffffc0000955:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc0000959:  mov    rdi,rbp
	   0xffffffffc000095c:  call   0xffffffffc0000370 <interpret_imm>

   0xffffffffc0000961:  test   bl,0x2
   0xffffffffc0000964:  je     0xffffffffc0000972

	   0xffffffffc0000966:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc000096a:  mov    rdi,rbp
	   0xffffffffc000096d:  call   0xffffffffc00003b7 <interpret_add>

   0xffffffffc0000972:  test   bl,bl
   0xffffffffc0000974:  jns    0xffffffffc0000982

	   0xffffffffc0000976:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc000097a:  mov    rdi,rbp
	   0xffffffffc000097d:  call   0xffffffffc0000426 <interpret_stk>

   0xffffffffc0000982:  test   bl,0x10
   0xffffffffc0000985:  je     0xffffffffc0000993
   
	   0xffffffffc0000987:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc000098b:  mov    rdi,rbp
	   0xffffffffc000098e:  call   0xffffffffc00004f5 <interpret_stm>

   0xffffffffc0000993:  test   bl,0x8
   0xffffffffc0000996:  je     0xffffffffc00009a4

	   0xffffffffc0000998:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc000099c:  mov    rdi,rbp
	   0xffffffffc000099f:  call   0xffffffffc0000558 <interpret_ldm>

   0xffffffffc00009a4:  test   bl,0x1
   0xffffffffc00009a7:  je     0xffffffffc00009b5

	   0xffffffffc00009a9:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc00009ad:  mov    rdi,rbp
	   0xffffffffc00009b0:  call   0xffffffffc00005bd <interpret_cmp>

   0xffffffffc00009b5:  test   bl,0x4
   0xffffffffc00009b8:  je     0xffffffffc00009c6

	   0xffffffffc00009ba:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc00009be:  mov    rdi,rbp
	   0xffffffffc00009c1:  call   0xffffffffc0000280 <interpret_jmp>

   0xffffffffc00009c6:  and    bl,0x20
   0xffffffffc00009c9:  je     0xffffffffc00009da

	   0xffffffffc00009cb:  mov    rsi,QWORD PTR [rsp]
	   0xffffffffc00009cf:  mov    rdi,rbp
	   0xffffffffc00009d2:  pop    rdx
	   0xffffffffc00009d3:  pop    rbx
	   0xffffffffc00009d4:  pop    rbp
	   0xffffffffc00009d5:  jmp    0xffffffffc0000695 <interpret_system>

   0xffffffffc00009da:  pop    rax
   0xffffffffc00009db:  pop    rbx
   0xffffffffc00009dc:  pop    rbp
   0xffffffffc00009dd:  ret
