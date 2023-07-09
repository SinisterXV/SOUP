library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_dlx is
end entity;

architecture arch of tb_dlx is
	constant clk_period        : time := 1 ns;
	signal clk                 : std_logic;
	signal rst                 : std_logic;

begin
	dlx_inst : entity work.dlx
		port map
		(
			clk                 => clk,
			rst                 => rst
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
		wait for 2*clk_period;
		rst <= '0';
        wait for 250*clk_period;
		wait;

	end process;
end architecture;
