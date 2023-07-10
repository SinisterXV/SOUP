addi r1, r0, 1000
addi r2, r0, 20
nop
nop
; We expect r3 to be 20000
smull r3, r1, r2
; We expect r4 to be 999
subi r4, r1, 1
nop
nop
nop