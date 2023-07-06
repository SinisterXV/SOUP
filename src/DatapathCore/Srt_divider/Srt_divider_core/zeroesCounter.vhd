library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity zeroesCounter is
	Generic(NBIT: integer := 32;
			CNTWIDTH: integer := 5); --width of the counter: has to be ⌈log2(N-1)⌉
	Port(A: in std_logic_vector(NBIT - 1 downto 0);
		 cnt: out std_logic_vector(CNTWIDTH - 1 downto 0));
end zeroesCounter;

architecture BEHAVIORAL of zeroesCounter is
begin
	process(A)
		variable tmpCnt: std_logic_vector(CNTWIDTH - 1 downto 0);
		variable flag: std_logic; --if 1 the first 0 has been found and the counting has to stop
	begin
		tmpCnt := (others => '0');
		flag := '0';
		
		for i in NBIT - 1 downto 0 loop
			if ((A(i) = '0') and (flag = '0')) then
				tmpCnt := tmpCnt + 1;
			else
				flag := '1';
			end if;
		end loop;

		cnt <= tmpCnt;
	end process;
end BEHAVIORAL;