library ieee;
use ieee.std_logic_1164.all;

-- PIPO register on N bits

entity pipeRegister is
	generic (
		NBIT        : integer := 32;
		reset_value : std_logic_vector);
	port
	(
		clk, rst : in std_logic;
		data_in  : in std_logic_vector(NBIT - 1 downto 0);
		enable   : in std_logic;
		data_out : out std_logic_vector(NBIT - 1 downto 0)
	);
end pipeRegister;

architecture BEHAVIORAL of pipeRegister is
	signal curr_val : std_logic_vector(NBIT - 1 downto 0);
begin
	process(clk)
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
