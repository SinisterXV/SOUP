# ISA

## Control word

The control word is made of 33 bits.
It is provided by the control unit during the fetch stage in order to target the behavior of the following 4 stages.

### Decode stage

`rf_rd1, cw(32)`: activates the read operation on port 1 of the register file.

`rf_rd2, cw(31)`: activates the read operation on port 2 of the register file.

`se_signed_unsigned_bar, cw(30)`: when it is zero, the immediate on 16 bits is extended as unsigned, otherwise as signed.

`se_size_16_26_bar, cw(29)`: when it is zero, the immediate is `IR(25 downto 0)`, otherwise `IR(15 downto 0)`.

### Execution Stage

`ex_sel_a, cw(28)`: when it is 0, the first operand of the execution stage is NPC, otherwise it is the output of the first port of the register file.

`ex_sel_b, cw(27)`: when it is 0, the first operand of the execution stage is the immediate, otherwise it is the output of the second port of the register file.

`alu_sub_add_bar, cw(26)`: when it is 0 the adder performs an addition, otherwise a subtraction.

`alu_logic_sel, cw(25 downto 22)`: define which logic operation to perform.

`alu_shift_sel, cw(21 downto 20)`: define which shift operation to perform.

`mul_start, cw(19)`: activates a mul operation when 1.

`div_start, cw(18)`: activates a div operation when 1.

`div_signed_unsigned_bar, cw(17)`: when it is zero, the division is unsigned, otherwise signed.

`div_sel, cw(16)`: specifies whether we are interested in the quotient or the reminder of the division operation.

`mul_sel, cw(15)`: specifies whether we are interested in the high or low part of the result of the multiplication.

`cmp_config, cw(14 downto 12)`: define which compare operation to perform.

`ex_sel_out, cw(11 downto 9)`: defines which is the output of the execution stage. 

`branch_eq_neq_bar, cw(8)`: a branch condition can be either *equal zero* or *not equal zero*; the *zero detector* computes one of the two conditions thanks to this bit.

### Memory Stage

`mem_rw_wr_bar, cw(7)`: enables the write operation on the DRAM.

`mem_branch_enable, cw(6)`: performs a branch operation: PC is overwritten in case a certain condition is verified.

`mem_perform_jump, cw(5)`: performs a jump operation: PC is always overwritten.

### Writeback Stage

`wb_sel, cw(4 downto 3)`: decide the output of the write-back stage.

`rf_sel_dest, cw(2)`: destination register for the register file.

`rf_write31, cw(1)`: when it is 1, the destination in the register file is automatically `r31`.

`rf_wr, cw(0)`: enables a write operation on the register file.

## Instructions

### add

Opcode: `0x00`

Control Word: `110110000000000000000001010001101`

Example: `add rx, ry, rz`

Action: `RF[x] = RF[y] + RF[z]`

### addi

Opcode: `0x01`

Control Word: `101111000000000000000001010001001`

Example: `addi rx, ry, imm_16`

Action: `RF[x] = RF[y] + imm_16`

The immediate value is sign-extended

### and

Opcode: `0x02` 

Control Word: `110110010000000000000010010001101`

Example: `and rx, ry, rz`

Action: `RF[x] = RF[y] & RF[z]`

### andi

Opcode: `0x03` 

Control Word: `100111010000000000000010010001001`

Example: `andi rx, ry, imm_16`

Action: `RF[x] = RF[y] & imm_16`

The immediate value is not sign-extended

### nor

Opcode: `0x04` 

Control Word: `110110000010000000000010010001101`

Example: `nor rx, ry, rz`

Action: `RF[x] = !(RF[y] | RF[z])`

### nori

Opcode: `0x05` 

Control Word: `100111000010000000000010010001001`

Example: `nori rx, ry, imm_16`

Action: `RF[x] = not(RF[y] | imm_16)`

The immediate value is not sign-extended

### nand 

Opcode: `0x06` 

Control Word: `110110001110000000000010010001101`

Example: `nand rx, ry, rz`

Action: `RF[x] = !(RF[y] & RF[z])`

### nandi

Opcode: `0x07` 

Control Word: `100111001110000000000010010001001`

Example: `nandi rx, ry, imm_16`

Action: `RF[x] = not(RF[y] & imm_16)`

The immediate value is not sign-extended

### xnor

Opcode: `0x08` 

Control Word: `110110010010000000000010010001101`

Example: `xnor rx, ry, rz`

Action: `RF[x] = !(RF[y] ^ RF[z])`

### xnori

Opcode: `0x09` 

Control Word: `100111010010000000000010010001001`

Example: `xnori rx, ry, imm_16`

Action: `RF[x] = not(RF[y] ^ imm_16)`

The immediate value is not sign-extended

### beqz

Opcode: `0x0a` 

Control Word: `100101000000000000000001111000000`

Example: `beqz rx, imm_16`

Action: `PC = (RF[x] == 0) ? (PC + 4 + imm_16) : PC + 4`

The immediate value is sign-extended

### bnez

Opcode: `0x0b` 

Control Word: `100101000000000000000001011000000`

Example: `bnez rx, imm_16`

Action: `PC = (RF[x] != 0) ? (PC + 4 + imm_16) : PC + 4`

The immediate value is sign-extended

### j

Opcode: `0x0c` 

Control Word: `000001000000000000000001010100000`

Example: `j imm_26`

Action: `PC = PC + 4 + imm_26`

The immediate value is signed extended

### jal

Opcode: `0x0d` 

Control Word: `000001000000000000000001010100011`

Example: `jal imm_26`

Action: `PC = PC + 4 + imm_26; RF[31] = PC + 4`

The immediate value is signed extended

### lw

Opcode: `0x0e` 

Control Word: `100111000000000000000001010010001`

Example: `lw ry, imm_16(rx)`

Action: `ry = MEM[rx + imm_16]`

The immediate value is not signed extended

### nop

Opcode: `0x0f` 

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

Example: `ori rx, ry, imm_16`

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

Example: `sgei rx, ry, imm_16`

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

### slti

Opcode: `0x1b`

Control Word: `101111100000000000001000010001001`

Example: `slti rx, ry, imm_16`

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