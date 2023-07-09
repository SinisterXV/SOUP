library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity boothMulController is
	Generic(NBIT: integer := 32); --length of the inputs
	Port(clk, rst: in  std_logic;
		 startMul: in  std_logic; --multiplication start signal
		 A_ld	 : out std_logic; --A register's load signal
		 A_shift : out std_logic; --A register's shift-left signal)
		 B_ld	 : out std_logic; --B register's load signal
		 B_shift : out std_logic; --B register's shift-right signal
		 P_ld	 : out std_logic; --P register's load signal
		 P_rst   : out std_logic; --P register's reset signal
		 doneMul : out std_logic); --signal used to notify multiplication end
end boothMulController;

architecture BEHAVIORAL of boothMulController is
	type StateType is (idle, mul, done);
	constant CNTWIDTH: integer := integer(ceil(log2(real(NBIT/2-1)))); --length of the counter register: will count from NBIT/2-2 to 0

	signal currState, nextState: StateType; --state register
	signal currCount, nextCount: unsigned(CNTWIDTH-1 downto 0); --iteration counter register
begin
	RegProc: process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				currState <= idle;
				currCount <= to_unsigned(NBIT/2-1, CNTWIDTH);
			else
				currState <= nextState;
				currCount <= nextCount;
			end if;
		end if;
	end process RegProc;

	CombLogic: process(startMul, currState, currCount)
	begin
		doneMul <= '0';
		A_ld <= '0'; A_shift <= '0';
		B_ld <= '0'; B_shift <= '0';
		P_rst <= '0'; P_ld <= '0'; 
		doneMul <= '0';
		nextState <= currState;
		nextCount <= currCount;

		case (currState) is
			when idle => 
				--load input registers
				A_ld <= '1';
				B_ld <= '1';
				P_rst <= '1';

				if (startMul = '1') then
					nextState <= mul;
				end if;

				--reset counter
				nextCount <= to_unsigned(NBIT/2-1, CNTWIDTH); --reset counter

			when mul => 
				--shift A and B, and load P
				A_shift <= '1';
				B_shift <= '1';
				P_ld <= '1';

				if (currCount = 0) then
					nextState <= done;
				end if;

				--decrement counter
				nextCount <= currCount - 1;

			when done =>
				--multiplication done
				doneMul <= '1';
				nextState <= idle;

			--this point should never be reached
			when others =>
				nextState <= idle;
		end case;
	end process CombLogic;
end BEHAVIORAL;