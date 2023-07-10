addi r2, r0, 0xaaa3
addi r1, r0, 0x1ab5
nop
nop

; We expect r3 to be 0x00000aa1 
and r3, r2, r1

; We expect r4 to be 0x00004548
nor r4, r2, r1

; We expect r5 to be 0xfffff55e
nand r5, r2, r1

; We expect r6 to be 0x00004fe9
xnor r6, r2, r1

; We expect r7 to be 0xffffb016
xor r7, r2, r1

; We expect r8 to be 0xffffbab7
or r8, r2, r1

nop
nop

