seqi r1, r0, 0x00
snei r2, r0, 0x00
nop
nop
nop
nop
nop 
bnez r1, label
nop
nop
nop
nop
nop
add r3, r1, r2

label:
and r3, r2, r1
jal label_2
nop
nop
nop
nop
nop
sub r3, r2, r1

label_2:
nop
nop
nop
nop
nop
and r3, r2, r1
