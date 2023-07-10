; We expect r3 to be 0x00001111
addi r1, r0, 0x1010
addi r2, r0, 0x0101
; 2 nops are necessary between these two instructions
; because of the data dependency
nop
nop
add r3, r2, r1
nop
nop
nop
nop
