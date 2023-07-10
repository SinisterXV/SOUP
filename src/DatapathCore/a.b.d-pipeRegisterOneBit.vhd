library ieee;
use ieee.std_logic_1164.all;

-- Just a PIPO register on 1 bit

entity pipeRegisterOneBit is
	generic (
		reset_value : std_logic);
	port
	(
		clk, rst : in std_logic;
		data_in  : in std_logic;
		enable   : in std_logic;
		data_out : out std_logic
	);
end pipeRegisterOneBit;

architecture BEHAVIORAL of pipeRegisterOneBit is
	signal curr_val : std_logic;
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				curr_val <= reset_value;
			elsif (enable = '1') then
				curr_val <= data_in;
			else
				curr_val <= curr_val;
			end if;
		end if;
	end process;

	data_out <= curr_val;
end architecture;
