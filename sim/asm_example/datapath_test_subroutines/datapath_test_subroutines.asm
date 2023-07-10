start:
jal subroutine
nop
nop
nop
; This line is executed after `subroutine` is called.
addi r20, r0, 20
j start
nop
nop
nop

subroutine:
    ; We expect r10 to be 10
    addi r10, r0, 10
    ret r31
    nop
    nop
    nop