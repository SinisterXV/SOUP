
; int factorial(int n){
;     if(n == 1) return 1;
;     else return n * factorial(n - 1)
; }

; Input : 9
; Expected output: 462880

; STACK INITIALIZATION
addi r30, r0, 20

addi r1, r0, 9
jal factorial
nop
nop
nop
sw 0(r0), r10
nop
nop
nop

terminate:
j terminate
nop
nop
nop


factorial:
    ; r2 = (r1 == 1) ? 1 : 0
    seqi r2, r1, 1
    nop
    nop

    ; else_factorial if r1 != 1
    beqz r2, else_factorial
    nop
    nop
    nop
    
    ; return value = 1
    addi r10, r0, 1
    ret r31
    nop
    nop
    nop

    else_factorial:
    ; Save N in r7
    add r7, r1, r0
    
    ; push r31
    add r1, r31, r0
    jal push
    nop
    nop
    nop

    ; push N
    add r1, r7, r0
    jal push
    nop
    nop
    nop

    ; computes N-1
    subi r1, r7, 1

    ; computes factorial(N-1)
    jal factorial
    nop
    nop
    nop

    ; Save factorial(N-1)
    add r7, r10, r0

    ; pop N
    jal pop
    nop
    nop
    no
    add r8, r10, r0

    ; pop r31
    jal pop
    nop
    nop
    nop
    add r31, r10, r0

    smull r10, r8, r7
    ret r31
    nop
    nop
    nop

push:
    sw 0(r30), r1
    addi r30, r30, 1
    ret r31
    nop
    nop
    nop

pop:
    subi r30, r30, 1
    nop
    nop
    lw r10, 0(r30)
    ret r31
    nop
    nop
    nop