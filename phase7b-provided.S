    .section .text
    .globl _start

_start:  

# Test case for Part 7b -- load hazard detection.
# only testing this condition (load followed by instruction that uses it)

# if hazard detection is working correctly:
#   x5 should be 0xABCDE125, and should occur 2 cycles after x4 is written (185 for lw - 205 for add)
#   x7 should be 0xABCDE125, and should occur 2 cycles after x6 is written (255 for lw, 275 for add)

# and to detect that a stall is not being inserted when don't need to, there's a 3rd test 
#   There, the write to register x9 should happen the next cycle after x8 is written (10 time units later, if using system_tb.sv)
#   (325 for lw, 335 for add)


#
# (55) Register File: Writing value abcde000 to register  1
# (65) Register File: Writing value abcde123 to register  1
# (75) Register File: Writing value 00000200 to register  2
# (85) Register File: Writing value 00000002 to register  3
# (185) Register File: Writing value abcde123 to register  4
# (205) Register File: Writing value abcde125 to register  5
# (255) Register File: Writing value abcde123 to register  6
# (275) Register File: Writing value abcde125 to register  7
# (325) Register File: Writing value abcde123 to register  8
# (335) Register File: Writing value 00000004 to register  9
# (385) Register File: Writing value abcde123 to register 10
# (435) Register File: Writing value abcde123 to register 11

lui x1, 0xABCDE
ori x1, x1, 0x123
addi x2, x0, 0x200
addi x3, x0, 0x2

nop
nop
nop
nop

sw x1, 0(x2)

nop
nop
nop
nop

## test case rs1
lw x4, 0(x2)
add x5, x4, x3   # x5 should be 0xABCDE125
nop
nop
nop
nop

## test case rs2
lw x6, 0(x2)
add x7, x3, x6  # x7 should be 0xABCDE125
nop
nop
nop
nop

## test case not a hazard
lw x8, 0(x2)
add x9, x3, x3  # x9 should be 4, but main thing is timing
nop
nop
nop
nop


## test case load followed by store
##   we are not handling with forwarding, but should get stalled
lw x10, 0(x2)
sw x10, 8(x2)
nop
nop
lw x11, 8(x2)  # x11 should be 0xABCDE123
nop
nop
nop
nop
