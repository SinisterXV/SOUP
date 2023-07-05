library ieee;
use ieee.std_logic_1164.all;

entity soup_controller is
	port
	(
		clk, rst : in std_logic;
		opcode   : in std_logic_vector(5 downto 0);
		div_done : in std_logic;
		mul_done : in std_logic;
		cw       : out std_logic_vector(36 downto 0)
	);
end soup_controller;

architecture BEHAVIORAL of soup_controller is
	type state_type is (single_cycle, multi_cycle);

	signal curr_state, next_state : state_type;
	signal pc_enable              : std_logic;
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
		pc_enable <= '1';
		next_state <= curr_state;
		case (curr_state) is
			when single_cycle =>
				--TODO: HARDWIRED BEHAVIOUR
				--switch to multi_cycle
				if ((opcode = MUL) or (opcode = DIV)) then
					next_state <= multi_cycle;
				end if;

			when multi_cycle =>
				pc_enable <= '0';
				if ((div_done = '1') or (mul_done = '1')) then
					next_state <= single_cycle;
				end if;

			--it should never get to this point
			when others =>
				next_state <= single_cycle;
		end case;
	end process CombLogic;

end BEHAVIORAL;
