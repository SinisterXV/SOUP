library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_datapath is
end entity;

architecture arch of tb_datapath is
	constant clk_period        : time := 1 us;

	signal clk                 : std_logic;
	signal rst                 : std_logic;
	signal control_word        : std_logic_vector(34 downto 0);
	signal single_cycle_enable : std_logic;
begin
	datapath_inst : entity work.datapath
		port map
		(
			clk                 => clk,
			rst                 => rst,
			control_word        => control_word,
			single_cycle_enable => single_cycle_enable,
			opcode              => open,
			mul_done            => open,
			div_done            => open
		);

	process
	begin
		clk <= '0';
		wait for (clk_period / 2);
		clk <= '1';
		wait for (clk_period / 2);
	end process;

	process
	begin
		rst <= '1';
		wait for clk_period;

		rst <= '0';
		single_cycle_enable <= '1';

		
	end process;
end architecture;
