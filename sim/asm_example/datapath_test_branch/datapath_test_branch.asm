start:
; we expect r1 to be 1
seqi r1, r0, 0x00
; we expect r2 to be 0
snei r2, r0, 0x00
nop
nop 
; We expect to jump to label
bnez r1, label
nop
nop
nop
; We expect r3 to be 0, since this point is never reached
add r3, r1, r2
j start
nop
nop
nop

label:
; We expect r4 to be 0xffffffff
sub r4, r2, r1
j start
nop
nop
nop
