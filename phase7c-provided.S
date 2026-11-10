    .section .text
    .globl _start

_start:  

## Test forwarding for the value being stored (reg2 isn't used in ALU, but is the value stored)
## x19 should be 9

# (55) Register File: Writing value 00000200 to register  2
# (155) Register File: Writing value 00000009 to register 18
# (205) Register File: Writing value 00000009 to register 19

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


add x18, x0, 9
sw x18, 8(x2)  # should write the value 9 to address 0x208 (if forwarding correctly)
nop
nop
nop
lw x19, 8(x2)  # should be 9
nop
nop
nop

