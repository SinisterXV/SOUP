# ISA

## Instructions

### add

Opcode: `0x0 `

Control Word: `110110000000000000000001010001101`

Example: `add rx, ry, rz`

Action: `RF[x] = RF[y] + RF[z]`

### addi

Opcode: `0x1`

Control Word: `101111000000000000000001010001001`

Example: `add rx, ry, imm_16`

Action: `RF[x] = RF[y] + imm_16`

The immediate value is sign-extended

### and

Opcode: `0x2` 

Control Word: `110110010000000000000010010001101`

Example: `and rx, ry, rz`

Action: `RF[x] = RF[y] & RF[z]`

### andi

Opcode: `0x3` 

Control Word: `100111010000000000000010010001001`

Example: `andi rx, ry, imm_16`

Action: `RF[x] = RF[y] & imm_16`

The immediate value is not sign-extended

### nor

Opcode: `0x4` 

Control Word: `110110000010000000000010010001101`

Example: `nor rx, ry, rz`

Action: `RF[x] = !(RF[y] | RF[z])`

### nori

Opcode: `0x5` 

Control Word: `100111000010000000000010010001001`

Example: `nori rx, ry, imm_16`

Action: `RF[x] = not(RF[y] | imm_16)`

The immediate value is not sign-extended

### nand 

Opcode: `0x6` 

Control Word: `110110001110000000000010010001101`

Example: `nand rx, ry, rz`

Action: `RF[x] = !(RF[y] & RF[z])`

### nandi

Opcode: `0x7` 

Control Word: `100111001110000000000010010001001`

Example: `nandi rx, ry, imm_16`

Action: `RF[x] = not(RF[y] & imm_16)`

The immediate value is not sign-extended

### xnor

Opcode: `0x8` 

Control Word: `110110010010000000000010010001101`

Example: `xnor rx, ry, rz`

Action: `RF[x] = !(RF[y] ^ RF[z])`

### xnori

Opcode: `0x9` 

Control Word: `100111010010000000000010010001001`

Example: `xnori rx, ry, imm_16`

Action: `RF[x] = not(RF[y] ^ imm_16)`

The immediate value is not sign-extended

### beqz

Opcode: `0xa` 

Control Word: `100101000000000000000001111000000`

Example: `beqz rx, imm_16`

Action: `PC = (RF[x] == 0) ? (PC + 4 + imm_16) : PC + 4`

The immediate value is not sign-extended

### bnez

Opcode: `0xb` 

Control Word: `100101000000000000000001011000000`

Example: `bnez rx, imm_16`

Action: `PC = (RF[x] != 0) ? (PC + 4 + imm_16) : PC + 4`

The immediate value is not sign-extended

### j

Opcode: `0xc` 

Control Word: `000001000000000000000001010100000`

Example: `j imm_26`

Action: `PC = PC + 4 + imm_26`

The immediate value is not signed extended

### jal

Opcode: `0xd` 

Control Word: `000001000000000000000001010100011`

Example: `jal imm_26`

Action: `PC = PC + 4 + imm_26; RF[31] = PC + 4`

The immediate value is not signed extended

### lw

Opcode: `0xe` 

Control Word: `100111000000000000000001010010001`

Example: `lw ry, imm_16(rx)`

Action: `ry = MEM[rx + imm_16]`

The immediate value is not signed extended

### nop

Opcode: `0xf` 

Control Word: `000100000000000000000000010001000`

Example: `nop`

Action: Nothing

### or

Opcode: `0x10`

Control Word: `110110011100000000000010010001101`

Example: `or rx, ry, rz`

Action: `RF[x] = RF[y] | RF[z]`

### ori

Opcode: `0x11`

Control Word: `100111011100000000000010010001001`

Example: `and rx, ry, imm_16`

Action: `RF[x] = RF[y] | imm_16`

The immediate value is not signed extended

### sge

Opcode: `0x12`

Control Word: `110110100000000000011000010001101`

Example: `sge rx, ry, rz`

Action: `rx = (ry >= rz) ? 1 : 0`

### sgei

Opcode: `0x13`

Control Word: `101111100000000000011000010001001`

Example: `sge rx, ry, imm_16`

Action: `rx = (ry >= imm_16) ? 1 : 0`

The immediate value is signed extended

### sle

Opcode: `0x14`

Control Word: `110110100000000000000000010001101`

Example: `sle rx, ry, rz`

Action: `rx = (ry <= rz) ? 1 : 0`

### slei

Opcode: `0x15`

Control Word: `101111100000000000000000010001001`

Example: `slei rx, ry, imm_16`

Action: `rx = (ry <= imm_16) ? 1 : 0`

The immediate value is signed extended

### sne

Opcode: `0x16`

Control Word: `110110100000000000101000010001101`

Example: `sne rx, ry, rz`

Action: `rx = (ry != rz) ? 1 : 0`

### snei

Opcode: `0x17`

Control Word: `101111100000000000101000010001001`

Example: `snei rx, ry, imm_16`

Action: `rx = (ry != imm_16) ? 1 : 0`

The immediate value is signed extended

### seq

Opcode: `0x18`

Control Word: `110110100000000000100000010001101`

Example: `seq rx, ry, rz`

Action: `rx = (ry == rz) ? 1 : 0`

### seqi

Opcode: `0x19`

Control Word: `101111100000000000100000010001001`

Example: `seqi rx, ry, imm_16`

Action: `rx = (ry == imm_16) ? 1 : 0`

The immediate value is signed extended

### slt

Opcode: `0x1a`

Control Word: `110110100000000000001000010001101`

Example: `slt rx, ry, rz`

Action: `rx = (ry < rz) ? 1 : 0`

### slt

Opcode: `0x1b`

Control Word: `101111100000000000001000010001001`

Example: `slt rx, ry, imm_16`

Action: `rx = (ry < imm_16) ? 1 : 0`

The immediate value is signed extended

### sgt

Opcode: `0x1c`

Control Word: `110110100000000000010000010001101`

Example: `sgt rx, ry, rz`

Action: `rx = (ry > rz) ? 1 : 0`

### sgti

Opcode: `0x1d`

Control Word: `101111100000000000010000010001001`

Example: `sgti rx, ry, imm_16`

Action: `rx = (ry > imm_16) ? 1 : 0`

The immediate value is signed extended

### sll

Opcode: `0x1e`

Control Word: `110110000000000000000011010001101`

Example: `sll rx, ry, rz`

Action: `rx = (ry << rz[4:0])`

### slli

Opcode: `0x1f`

Control Word: `100111000000000000000011010001001`

Example: `slli rx, ry, imm_16`

Action: `rx = (ry << imm_16[4:0])`

The immediate value is not sign extended


### srl

Opcode: `0x20`

Control Word: `110110000000100000000011010001101`

Example: `srl rx, ry, rz`

Action: `rx = (ry >> rz[4:0])`

### srli

Opcode: `0x21`

Control Word: `100111000000100000000011010001001`

Example: `srli rx, ry, imm_16`

Action: `rx = (ry >> imm_16[4:0])`

The immediate value is not sign extended

### sub 

Opcode: `0x22`

Control Word: `110110100000000000000001010001101`

Example: `sub rx, ry, rz`

Action: `RF[x] = RF[y] - RF[z]`

### subi

Opcode: `0x23`

Control Word: `101111100000000000000001010001001`

Example: `subi rx, ry, imm_16`

Action: `RF[x] = RF[y] - imm_16`

The immediate value is sign-extended

### sw 

Opcode: `0x24`

Control Word: `110111000000000000000001000000000`

Example: `sw imm_16(rx), ry`

Action: `MEM[rx + imm_16] = ry`

The immediate value is not signed extended

### xor

Opcode: `0x25`

Control Word: `110110001100000000000010010001101`

Example: `xor rx, ry, rz`

Action: `RF[x] = RF[y] ^ RF[z]`

### xori

Opcode: `0x26`

Control Word: `100111001100000000000010010001001`

Example: `xori rx, ry, imm_16`

Action: `RF[x] = RF[y] ^ imm_16`

The immediate value is not sign-extended

### smulh

Opcode: `0x27`

Control Word: `110110000000010001000100010001101`

Example: `smulh rx, ry, rz`

Action: `R_64 = RF[y] * RF[z]; RF[x] = R_64[63:32]`

The multiplication is signed

### smull

Opcode: `0x28`

Control Word: `110110000000010000000100010001101`

Example: `smull rx, ry, rz`

Action: `R_64 = RF[y] * RF[z]; RF[x] = R_64[31:0]`

The multiplication is signed

### uquot

Opcode: `0x29`

Control Word: `110110000000001010000101010001101`

Example: `uquot rx, ry, rz`

Action: `RF[z] = RF[y] // RF[z]`

The division is unsigned

### urem

Opcode: `0x2a`

Control Word: `110110000000001000000101010001101`

Example: `urem rx, ry, rz`

Action: `RF[z] = RF[y] % RF[z]`

The division is unsigned

### squot

Opcode: `0x2b`

Control Word: `110110000000001110000101010001101`

Example: `squot rx, ry, rz`

Action: `RF[z] = RF[y] // RF[z]`

The division is signed

### srem

Opcode: `0x2c`

Control Word: `110110000000001100000101010001101`

Example: `srem rx, ry, rz`

Action: `RF[z] = RF[y] % RF[z]`

The division is signed

### ret

Opcode: `0x2d`

Control Word: `100111000000000000000001010100000`

Example: `ret rx`

Action: `PC = RF[x]`

## Stalls

### Data Dependencies

As a RAW hazard happens, there must be two instructions between the one which writes and the one which reads. In case this does not already happen in the code, some `nop` instructions are necessary.

### Branches/Jumps

For instructions which modify the program counter, the number of required `nop` is three, since the evaluation of the new program counter happens during the *memory* stage.

### Structural Dependencies

Two multi-cycle instructions must be separated by other two instructions. `nop` are required if this is not the case in the program.