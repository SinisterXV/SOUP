library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	generic (
		LUT_MEM_SIZE : integer := 45;
		CW_SIZE      : integer := 36;
		OPCODE_SIZE  : integer := 6);
	port
	(
		clk, rst            : in std_logic;
		opcode              : in std_logic_vector(OPCODE_SIZE - 1 downto 0);
		div_done            : in std_logic;
		mul_done            : in std_logic;
		invalid_div         : in std_logic;
		single_cycle_enable : out std_logic;
		cw                  : out std_logic_vector(CW_SIZE - 1 downto 0)
	);
end controller;

architecture BEHAVIORAL of controller is
	type state_type is (single_cycle, multi_cycle);

	type LUT is array (integer range 0 to LUT_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
	signal cw_mem : LUT := (
		"110111000000000000000000101100101101",  --add  
		"101111100000000000000000101100101001",  --addi 
		"110111001000000000000001001100101101",  --and  
		"100111101000000000000001001100101001",  --andi 
		"110111000001000000000001001100101101",  --nor  
		"100111100001000000000001001100101001",  --nori 
		"110111000111000000000001001100101101",  --nand 
		"100111100111000000000001001100101001",  --nandi
		"110111001001000000000001001100101101",  --xnor 
		"100111101001000000000001001100101001",  --xnori
		"100110100000000000000000111110000000",  --beqz 
		"100110100000000000000000101110000000",  --bnez 
		"000010100000000000000000101101000000",  --j    
		"000010100000000000000000101101100011",  --jal    
		"100111100000000000000000101100110001",  --lw   
		"000100000000000000000000000100001000",  --nop  
		"110111001110000000000001001100101101",  --or   
		"100111101110000000000001001100101001",  --ori  
		"110111010000000000001100001100101101",  --sge  
		"101111110000000000001100001100101001",  --sgei 
		"110111010000000000000000001100101101",  --sle  
		"101111110000000000000000001100101001",  --slei 
		"110111010000000000010100001100101101",  --sne  
		"101111110000000000010100001100101001",  --snei 
		"110111010000000000010000001100101101",  --seq  
		"101111110000000000010000001100101001",  --seqi 
		"110111010000000000000100001100101101",  --slt  
		"101111110000000000000100001100101001",  --slti 
		"110111010000000000001000001100101101",  --sgt  
		"101111110000000000001000001100101001",  --sgti 
		"110111000000000000000001101100101101",  --sll  
		"100111100000000000000001101100101001",  --slli 
		"110111000000010000000001101100101101",  --srl  
		"100111100000010000000001101100101001",  --srli 
		"110111010000000000000000101100101101",  --sub  
		"101111110000000000000000101100101001",  --subi 
		"110111100000000000000000101000000000",  --sw   
		"110111000110000000000001001100101101",  --xor  
		"100111100110000000000001001100101001",  --xori 
		"110111000000001000100010001100101101",  --smulh
		"110111000000001000000010001100101101",  --smull
		"110111000000000101000010101100101101",  --uquot
		"110111000000000100000010101100101101",  --urem 
		"110111000000000111000010101100101101",  --squot
		"110111000000000110000010101100101101"); --srem 

	signal curr_state, next_state : state_type;
    signal curr_cw, next_cw : std_logic_vector(CW_SIZE - 1 downto 0);
    signal curr_counter, next_counter: std_logic;

begin
	RegProc : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				curr_state <= single_cycle;
                curr_cw <= "000000000000000000000000000100001000";
                curr_counter <= '0';
			else
				curr_state <= next_state;
                curr_cw <= next_cw;
                curr_counter <= next_counter;
			end if;
		end if;
	end process RegProc;

	CombLogic : process (curr_state, opcode, div_done, mul_done, curr_counter)
	begin
		single_cycle_enable <= '1';
		next_state          <= curr_state;
        next_counter        <= curr_counter;
		case (curr_state) is
			when single_cycle =>

				next_cw <= cw_mem(to_integer(unsigned(opcode)));

				--switch to multi_cycle if MUL or DIV
				if ((opcode = "100111") or 	   --smulh
					(opcode = "101000") or     --smull
					(opcode = "101001") or     --uquot
					(opcode = "101010") or     --urem
					(opcode = "101011") or     --squot
					(opcode = "101100")) then  --srem

                    next_counter <= '1';

				end if;

                if (curr_counter = '1') then
                    next_state <= multi_cycle;
                end if;

			when multi_cycle =>
             
				next_cw <= cw_mem(to_integer(unsigned(opcode)));

				if ((div_done = '1') or (mul_done = '1') or (invalid_div = '1')) then
					next_state <= single_cycle;
				    single_cycle_enable <= '1';
                else
				    single_cycle_enable <= '0';
				end if;

                next_counter <= '0';

			--it should never get to this point
			when others =>
				next_state <= single_cycle;
		end case;
	end process CombLogic;

	cw <= curr_cw;

end BEHAVIORAL;
