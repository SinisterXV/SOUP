library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	generic (
		LUT_MEM_SIZE : integer := 46;
		CW_SIZE      : integer := 33;
		OPCODE_SIZE  : integer := 6);
	port
	(
		clk, rst            : in std_logic;
		opcode              : in std_logic_vector(OPCODE_SIZE - 1 downto 0);
		div_done            : in std_logic;
		mul_done            : in std_logic;
		invalid_div         : in std_logic;
		pc_enable           : out std_logic;
		single_cycle_enable : out std_logic;
		cw                  : out std_logic_vector(CW_SIZE - 1 downto 0)
	);
end controller;

architecture BEHAVIORAL of controller is
	type state_type is (single_cycle, multi_cycle);

	type LUT is array (integer range 0 to LUT_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
	signal cw_mem : LUT := (
		"110110000000000000000001010001101",  --add  
		"101111000000000000000001010001001",  --addi 
		"110110010000000000000010010001101",  --and  
		"100111010000000000000010010001001",  --andi 
		"110110000010000000000010010001101",  --nor  
		"100111000010000000000010010001001",  --nori 
		"110110001110000000000010010001101",  --nand 
		"100111001110000000000010010001001",  --nandi
		"110110010010000000000010010001101",  --xnor 
		"100111010010000000000010010001001",  --xnori
		"100101000000000000000001111000000",  --beqz 
		"100101000000000000000001011000000",  --bnez 
		"000001000000000000000001010100000",  --j    
		"000001000000000000000001010100011",  --jal    
		"100111000000000000000001010010001",  --lw   
		"000100000000000000000000010001000",  --nop  
		"110110011100000000000010010001101",  --or   
		"100111011100000000000010010001001",  --ori  
		"110110100000000000011000010001101",  --sge  
		"101111100000000000011000010001001",  --sgei 
		"110110100000000000000000010001101",  --sle  
		"101111100000000000000000010001001",  --slei 
		"110110100000000000101000010001101",  --sne  
		"101111100000000000101000010001001",  --snei 
		"110110100000000000100000010001101",  --seq  
		"101111100000000000100000010001001",  --seqi 
		"110110100000000000001000010001101",  --slt  
		"101111100000000000001000010001001",  --slti 
		"110110100000000000010000010001101",  --sgt  
		"101111100000000000010000010001001",  --sgti 
		"110110000000000000000011010001101",  --sll  
		"100111000000000000000011010001001",  --slli 
		"110110000000100000000011010001101",  --srl  
		"100111000000100000000011010001001",  --srli 
		"110110100000000000000001010001101",  --sub  
		"101111100000000000000001010001001",  --subi 
		"110111000000000000000001000000000",  --sw   
		"110110001100000000000010010001101",  --xor  
		"100111001100000000000010010001001",  --xori 
		"110110000000010001000100010001101",  --smulh
		"110110000000010000000100010001101",  --smull
		"110110000000001010000101010001101",  --uquot
		"110110000000001000000101010001101",  --urem 
		"110110000000001110000101010001101",  --squot
		"110110000000001100000101010001101",  --srem 
        "100111000000000000000001010100000"); -- ret

	signal curr_state, next_state     : state_type;
	signal curr_counter, next_counter : std_logic;

begin
	RegProc : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				curr_state   <= single_cycle;
				curr_counter <= '0';
			else
				curr_state   <= next_state;
				curr_counter <= next_counter;
			end if;
		end if;
	end process RegProc;

	CombLogic : process (curr_state, opcode, div_done, mul_done, curr_counter)
	begin
		pc_enable           <= '1';
		single_cycle_enable <= '1';
		next_state          <= curr_state;
		next_counter        <= curr_counter;
		case (curr_state) is
			when single_cycle =>

				cw <= cw_mem(to_integer(unsigned(opcode)));

				--switch to multi_cycle if MUL or DIV
				if ((opcode = "100111") or --smulh
					(opcode = "101000") or     --smull
					(opcode = "101001") or     --uquot
					(opcode = "101010") or     --urem
					(opcode = "101011") or     --squot
					(opcode = "101100")) then  --srem

					next_counter <= '1';

				end if;

				if (curr_counter = '1') then
					pc_enable  <= '0';
					next_state <= multi_cycle;
				end if;

			when multi_cycle =>

				cw <= cw_mem(to_integer(unsigned(opcode)));

				if ((div_done = '1') or (mul_done = '1') or (invalid_div = '1')) then
					next_state          <= single_cycle;
					single_cycle_enable <= '1';
					pc_enable           <= '1';
				else
                    pc_enable           <= '0';
					single_cycle_enable <= '0';
				end if;

				next_counter <= '0';

				--it should never get to this point
			when others =>
				next_state <= single_cycle;
		end case;
	end process CombLogic;
end BEHAVIORAL;
