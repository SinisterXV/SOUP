start:
jal subroutine
nop
nop
nop
nop
addi r20, r0, 20
add r30, r0, r0
j start
nop
nop
nop
nop

subroutine:
    addi r10, r0, 10
    ret r31
    nop
    nop
    nop
    nop