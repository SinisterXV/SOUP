; BUBBLE SORT 
; We put some numbers in some sequential locations of the memory, 
; then we sort them

; starting point: 
; MEM[0] = 7; MEM[1] = 1; MEM[2] = 9; MEM[3] = 3
; expected result:
; MEM[0] = 1; MEM[1] = 3; MEM[2] = 7; MEM[3] = 9

; int N = 4
; for(int i = 0; i < N; i++){
;     for(int j = i; j < N; j++){
;         int number1 = MEM[i];
;         int number2 = MEM[j];
;         if(number1 > number2){
;             MEM[j] = number1;
;             MEM[i] = number2;
;         }
;     }
; }

addi r1, r0, 7
addi r2, r0, 1
addi r3, r0, 9
addi r4, r0, 3
sw 0(r0), r1
sw 1(r0), r2
sw 2(r0), r3
sw 3(r0), r4

; r1 == N = 4
addi r1, r0, 4
; r2 == i = 0
add r2, r0, r0
nop
nop
nop

loop_1:
slt r10, r2, r1 
nop
nop
nop
beqz r10, end_loop_1
nop
nop
nop
nop

; r3 == j = i
add r3, r2, r0
nop
nop
nop

loop_2:
slt r10, r3, r1
nop
nop
nop
beqz r10, end_loop_2
nop
nop
nop
nop

lw r6, 0(r2)
lw r7, 0(r3)
nop
nop
nop

sgt r10, r6, r7
nop
nop
nop
beqz r10, next_swap
nop
nop
nop
nop
sw 0(r2), r7
sw 0(r3), r6

next_swap:

addi r3, r3, 1
j loop_2
nop
nop
nop
nop

end_loop_2:
addi r2, r2, 1
j loop_1
nop
nop
nop
nop

end_loop_1:
j end_loop_1
nop
nop
nop
