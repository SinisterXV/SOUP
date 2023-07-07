library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

USE ieee.numeric_std.ALL;

entity soup_controller is
	generic(
        LUT_MEM_SIZE  :     integer :=  45;
        CW_SIZE       :     integer := 	35;
		OPCODE_SIZE   :		integer :=  6);
	port
	(
		clk, rst : in std_logic;
		opcode   : in std_logic_vector(OPCODE_SIZE - 1  downto 0);
		div_done : in std_logic;
		mul_done : in std_logic;
		single_cycle_enable: out std_logic;
		cw       : out std_logic_vector(CW_SIZE - 1 downto 0)		
	);
end soup_controller;

architecture BEHAVIORAL of soup_controller is
	type state_type is (single_cycle, multi_cycle);
	
	type LUT is array (integer range 0 to LUT_MEM_SIZE -1) OF std_logic_vector(CW_SIZE -1 downto 0);
	signal cw_mem : LUT := (
						"11011000000000000000000101100101101",
 					    "10111100000000000000000101100101001",
 						"11011001000000000000001001100101101",
					    "10011101000000000000001001100101001",
 					    "11011000001000000000001001100101101",
						"10011100001000000000001001100101001",
						"11011000111000000000001001100101101",
						"10011100111000000000001001100101001",
						"11011001001000000000001001100101101",
						"10011101001000000000001001100101001",
						"10010100000000000000000111110000000",
						"10010100000000000000000101110000000",
						"00010000000000000000000001101000000",
						"00010000000000000000000001101100011",
						"10011100000000000000000101100110001",
						"00000000000000000000000000100001000",
						"11011001110000000000001001100101101",
						"10011101110000000000001001100101001",
						"11011010000000000001100001100101101",
						"10111010000000000001100001100101001",
						"11011010000000000000000001100101101",
						"10111010000000000000000001100101001",
						"11011010000000000010100001100101101",
						"10111010000000000010100001100101001",
					   	"11011010000000000010000001100101101",
						"10111010000000000010000001100101001",
						"11011010000000000000100001100101101",
						"10111010000000000000100001100101001",
						"11011010000000000001000001100101101",
						"10111010000000000001000001100101001",
						"11011000000000000000001101100101101",
						"10011100000000000000001101100101001",
						"11011000000010000000001101100101101",
						"10011100000010000000001101100101001",
						"11011010000000000000000101100101101",
						"10111110000000000000000101100101001",
						"11011100000000000000000101000000000",
						"11011000110000000000001001100101101",
						"10011100110000000000001001100101001",
						"11011000000001000100010001100101101",
						"11011000000001000000010001100101101",
						"11011000000000101000010101100101101",
						"11011000000000100000010101100101101",
						"11011000000000111000010101100101101",
						"11011000000000110000010101100101101");

	signal curr_state, next_state : state_type;
	 
begin
	RegProc : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				curr_state <= single_cycle;
			else
				curr_state <= next_state;
			end if;
		end if;
	end process RegProc;

	CombLogic : process (opcode, div_done, mul_done)
	begin
		single_cycle_enable <= '1';
		next_state <= curr_state;
		case (curr_state) is
			when single_cycle =>
				single_cycle_enable <= '1';
				
				cw <= cw_mem(to_integer(unsigned(opcode))); 

				--switch to multi_cycle if MUL or DIV
				if ((to_integer(unsigned(opcode)) = 44) or
					(to_integer(unsigned(opcode)) = 43 ) or
					(to_integer(unsigned(opcode)) = 42) or
					(to_integer(unsigned(opcode)) = 41 ) or
					(to_integer(unsigned(opcode)) = 40 ) or
					(to_integer(unsigned(opcode)) = 39 )) then

					next_state <= multi_cycle;

				end if;

			when multi_cycle =>
				single_cycle_enable <= '0';

				if ((div_done = '1') or (mul_done = '1')) then
					next_state <= single_cycle;
				end if;

			--it should never get to this point
			when others =>
				next_state <= single_cycle;
		end case;
	end process CombLogic;

end BEHAVIORAL;
