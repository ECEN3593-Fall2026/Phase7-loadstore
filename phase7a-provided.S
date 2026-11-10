    .section .text
    .globl _start

_start:  

## This will test the functionality of loads and stores
## it is not comprehensive, but does test enough variants


# (55) Register File: Writing value abcde000 to register  1
# (65) Register File: Writing value abcde123 to register  1
# (75) Register File: Writing value 00000200 to register  2
# (175) Register File: Writing value abcde123 to register  3
# (225) Register File: Writing value 00000023 to register  4
# (235) Register File: Writing value ffffffe1 to register  5
# (245) Register File: Writing value ffffffcd to register  6
# (255) Register File: Writing value ffffffab to register  7
# (305) Register File: Writing value ffffe123 to register  8
# (315) Register File: Writing value ffffabcd to register  9
# (365) Register File: Writing value 00000300 to register 22
# (495) Register File: Writing value 00000023 to register 10
# (505) Register File: Writing value 00002300 to register 11
# (515) Register File: Writing value 00230000 to register 12
# (525) Register File: Writing value 23000000 to register 13
# (575) Register File: Writing value ffffffab to register 14
# (585) Register File: Writing value 000000cd to register 15
# (635) Register File: Writing value ffffabcd to register 16
# (645) Register File: Writing value 0000e123 to register 17

lui x1, 0xABCDE
ori x1, x1, 0x123
addi x2, x0, 0x200

nop
nop
nop
nop

sw x1, 0(x2)

nop
nop
nop
nop

lw x3, 0(x2)

nop
nop
nop
nop

lb x4, 0(x2)
lb x5, 1(x2)
lb x6, 2(x2)
lb x7, 3(x2)
nop
nop
nop
nop

lh x8, 0(x2)
lh x9, 2(x2)

nop
nop
nop
nop
addi x22, x0, 0x300
nop
nop
nop
nop

sb x1, 0(x22)
sb x1, 5(x22) # 4+1
sb x1, 10(x22) # 8+2
sb x1, 15(x22) # 12+3

nop
nop
nop
nop

lw x10, 0(x22)
lw x11, 4(x22)
lw x12, 8(x22)
lw x13, 12(x22)

nop
nop
nop
nop

lb x14, 3(x2)  # should be neg
lbu x15, 2(x2)  

nop
nop
nop
nop

lh x16, 2(x2)  # should be neg
lhu x17, 0(x2)  
nop
nop
nop
nop


