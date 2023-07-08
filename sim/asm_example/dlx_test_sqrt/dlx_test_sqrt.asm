; The algorithm comes from the wikipedia page of sqrt
; int32_t isqrt(int32_t n) {
;     int32_t x = n;
; 
;     int32_t c = 0;
; 
;     int32_t d = 1 << 30; 
;     while (d > n)
;         d = d >> 2;
; 
;     while (d != 0) {
;         if (x >= c + d) {
;             x = x - c - d;   
;             c = (c >> 1);
;             c = c + d
;         }
;         else {
;             c = c >> 1;
;         }
;         d = d >> 2;
;     }
;     return c;
; }

; input = 14837
; expected output = 121

addi r1, r0, 14837 
add  r2, r0, r0
addi r3, r0, 1
nop
nop
nop
slli r3, r3, 30
nop
nop
nop

loop_1:
sgt r10, r3, r1 
nop
nop
nop
beqz r10, loop_2
nop
nop
nop

srli r3, r3, 2
j loop_1
nop
nop
nop

loop_2:
beqz r3, end_loop_2
nop
nop
nop

add r6, r2, r3
nop
nop
nop
sge r10, r1, r6
nop
nop
nop
beqz r10, else_branch
nop
nop
nop
sub r1, r1, r2
nop
nop
nop
sub r1, r1, r3
nop
nop
nop
srli r2, r2, 1
nop
nop
nop
add r2, r2, r3
j next
nop
nop
nop

else_branch:
srli r2, r2, 1

next:
srli r3, r3, 2
j loop_2
nop
nop
nop

end_loop_2:
sw 255(r0), r2
nop
nop
nop