; Compute binomial of two numbers
; Input : 17, 8
; expected result: 24310
; binomial(n, k) = 
; A = N * N-1 * N-2 * ... * N-K+1
; B = K * K-1 * K-2 * ... * 1
; R = A / B

; int A = 1, B = 1
; for(int i = N; i != N-K; i--) A = A * i;
; for(int i = K; i !=   1; i--) B = B * i;
; R = A / B

addi r1, r0, 17
addi r2, r0, 8
nop
nop

; Compute A

; r10 == A = 1
addi r10, r0, 1
; r3 == i = N
add r3, r0, r1
; r4 = N-K
sub r4, r1, r2
nop
nop
nop

loop_A:
seq r5, r3, r4 
nop
nop
nop
bnez r5, end_loop_A
nop
nop
nop
smull r10, r10, r3
nop
nop
subi r3, r3, 1
j loop_A
nop
nop
nop

end_loop_A:

; r11 == B = 1
addi r11, r0, 1
; r3 == i = K
add r3, r0, r2
; r4 = 1
addi r4, r0, 1
nop
nop
nop

loop_B:
seq r5, r3, r4
nop
nop
nop
bnez r5, end_loop_B
nop
nop
nop
smull r11, r11, r3
nop
nop
subi r3, r3, 1
j loop_B
nop
nop
nop

end_loop_B:
uquot r20, r10, r11
nop
nop
nop
nop
