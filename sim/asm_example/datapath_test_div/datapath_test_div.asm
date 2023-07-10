; r1 = 0xffffafd5
addi r1, r0, 0xafd5
nop
nop

; r1=0xfebf5400 = −21015552
slli r1, r1, 0x0A

; r2=0x00004d64 = 19812
addi r2, r0, 0x4d64
nop
nop

; We expect r3 to be -14832 == 0xffffc610
srem r3, r1, r2
nop
nop

; We expect r4 to be -1060 == 0xfffffbdc
squot r4, r1, r2
nop
nop