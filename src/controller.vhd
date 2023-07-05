library ieee;
use ieee.std_logic_1164.all;

entity soupController is
	port
	(
		clk, rst : in std_logic;
		opcode   : in std_logic_vector(5 downto 0);
		div_done : in std_logic;
		mul_done : in std_logic;
		cw       : out std_logic_vector(34 downto 0)
	);
end soupController;

architecture BEHAVIORAL of soupController is
	type StateType is (singleCycle, multiCycle);

	signal currState, nextState : StateType;
	signal pc_enable            : std_logic;
begin
	RegProc : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				currState <= singleCycle;
			else
				currState <= nextState;
			end if;
		end if;
	end process RegProc;

	CombLogic: process(opcode, div_done, mul_done)
	begin
		pc_enable <= '1';
		nextState <= currState;
		case (currState) is
			when singleCycle => 
				--TODO: HARDWIRED BEHAVIOUR


				--switch to multicycle
				if ((opcode = MUL) or (opcode = DIV)) then
					nextState <= multiCycle;
				end if;

			when multiCycle => 
				pc_enable <= '0';
				if ((div_done = '1') or (mul_done = '1')) then
					nextState <= singleCycle;
				end if;

			--it should never get to this point
			when others => 
				nextState <= singleCycle;
		end case;
	end process CombLogic;
	
end BEHAVIORAL;
