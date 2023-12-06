--
-- File              : dlx_controller.vhd
--
-- Description       : RTL description of the controller of the DLX. The controller 
--                     is an hybrid between an FSM and an hardwired. The FSM 
--                     handles the possibility of blocking the pipeline in case of
--                     a multi-cycle instruction; the hardwired part generates the
--                     control words of each possible opcode in a combinatorial way.
--
-- Author            : Giacomo Sansone <s307761@studenti.polito.it>
--
-- Date              : 30.10.2023
-- Last Modified Date: 02.11.2023
--
-- Copyright (c) 2023
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dlx_controller is
    generic (
        LUT_MEM_SIZE : integer := 46;
        CW_SIZE : integer := 33;
        OPCODE_SIZE : integer := 6);
    port (
        clk, rst : in std_logic;
        opcode : in std_logic_vector(OPCODE_SIZE - 1 downto 0);
        div_done : in std_logic;
        mul_done : in std_logic;
        invalid_div : in std_logic;
        pc_enable : out std_logic;
        single_cycle_enable : out std_logic;
        cw : out std_logic_vector(CW_SIZE - 1 downto 0)
    );
end dlx_controller;

architecture BEHAVIORAL of dlx_controller is

    -- State definition
    type state_type is (single_cycle, multi_cycle);

    -- Registers
    signal curr_state, next_state : state_type;
    signal curr_counter, next_counter : std_logic;

begin

    cw <=
        "110110000000000000000001010001101" when opcode = "000000" else --add  
        "101111000000000000000001010001001" when opcode = "000001" else --addi 
        "110110010000000000000010010001101" when opcode = "000010" else --and  
        "100111010000000000000010010001001" when opcode = "000011" else --andi 
        "110110000010000000000010010001101" when opcode = "000100" else --nor  
        "100111000010000000000010010001001" when opcode = "000101" else --nori 
        "110110001110000000000010010001101" when opcode = "000110" else --nand 
        "100111001110000000000010010001001" when opcode = "000111" else --nandi
        "110110010010000000000010010001101" when opcode = "001000" else --xnor 
        "100111010010000000000010010001001" when opcode = "001001" else --xnori
        "100101000000000000000001111000000" when opcode = "001010" else --beqz 
        "100101000000000000000001011000000" when opcode = "001011" else --bnez 
        "000001000000000000000001010100000" when opcode = "001100" else --j    
        "000001000000000000000001010100011" when opcode = "001101" else --jal    
        "100111000000000000000001010010001" when opcode = "001110" else --lw   
        "000100000000000000000000010001000" when opcode = "001111" else --nop  
        "110110011100000000000010010001101" when opcode = "010000" else --or   
        "100111011100000000000010010001001" when opcode = "010001" else --ori  
        "110110100000000000011000010001101" when opcode = "010010" else --sge  
        "101111100000000000011000010001001" when opcode = "010011" else --sgei 
        "110110100000000000000000010001101" when opcode = "010100" else --sle  
        "101111100000000000000000010001001" when opcode = "010101" else --slei 
        "110110100000000000101000010001101" when opcode = "010110" else --sne  
        "101111100000000000101000010001001" when opcode = "010111" else --snei 
        "110110100000000000100000010001101" when opcode = "011000" else --seq  
        "101111100000000000100000010001001" when opcode = "011001" else --seqi 
        "110110100000000000001000010001101" when opcode = "011010" else --slt  
        "101111100000000000001000010001001" when opcode = "011011" else --slti 
        "110110100000000000010000010001101" when opcode = "011100" else --sgt  
        "101111100000000000010000010001001" when opcode = "011101" else --sgti 
        "110110000000000000000011010001101" when opcode = "011110" else --sll  
        "100111000000000000000011010001001" when opcode = "011111" else --slli 
        "110110000000100000000011010001101" when opcode = "100000" else --srl  
        "100111000000100000000011010001001" when opcode = "100001" else --srli 
        "110110100000000000000001010001101" when opcode = "100010" else --sub  
        "101111100000000000000001010001001" when opcode = "100011" else --subi 
        "110111000000000000000001000000000" when opcode = "100100" else --sw   
        "110110001100000000000010010001101" when opcode = "100101" else --xor  
        "100111001100000000000010010001001" when opcode = "100110" else --xori 
        "110110000000010001000100010001101" when opcode = "100111" else --smulh
        "110110000000010000000100010001101" when opcode = "101000" else --smull
        "110110000000001010000101010001101" when opcode = "101001" else --uquot
        "110110000000001000000101010001101" when opcode = "101010" else --urem 
        "110110000000001110000101010001101" when opcode = "101011" else --squot
        "110110000000001100000101010001101" when opcode = "101100" else --srem 
        "100111000000000000000001010100000" when opcode = "101101" else -- ret
        "000100000000000000000000010001000"; -- UNKNOWN OPCODE: nop control word


    RegProc : process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                curr_state <= single_cycle;
                curr_counter <= '0';
            else
                curr_state <= next_state;
                curr_counter <= next_counter;
            end if;
        end if;
    end process RegProc;

    CombLogic : process (curr_state, opcode, div_done, mul_done, curr_counter, invalid_div)
    begin
        pc_enable <= '1';
        single_cycle_enable <= '1';
        next_state <= curr_state;
        next_counter <= curr_counter;

        case (curr_state) is
                -- During the single cycle, the control word is provided acccording to
                -- the opcode. In case a mul/div operation is recognized, counter is 
                -- set to 1. When counter is set to 1, next_state is multi_cycle and
                -- the program counter is disabled, so that no more instructions can be fetched

            when single_cycle =>

                --switch to multi_cycle if MUL or DIV
                if ((opcode = "100111") or --smulh
                    (opcode = "101000") or --smull
                    (opcode = "101001") or --uquot
                    (opcode = "101010") or --urem
                    (opcode = "101011") or --squot
                    (opcode = "101100")) then --srem

                    next_counter <= '1';

                end if;

                if (curr_counter = '1') then
                    pc_enable <= '0';
                    next_state <= multi_cycle;
                end if;

            when multi_cycle =>

                -- During multi-cycle, we wait for an and signal in order to 
                -- restore the normal behavior of the controller

                if ((div_done = '1') or (mul_done = '1') or (invalid_div = '1')) then
                    next_state <= single_cycle;
                    single_cycle_enable <= '1';
                    pc_enable <= '1';
                else
                    pc_enable <= '0';
                    single_cycle_enable <= '0';
                end if;

                next_counter <= '0';

                --it should never get to this point
            when others =>
                next_state <= single_cycle;
        end case;
    end process CombLogic;
end BEHAVIORAL;
