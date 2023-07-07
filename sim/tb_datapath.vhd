library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_datapath is
end entity;

architecture arch of tb_datapath is
	constant clk_period        : time := 1 ns;

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

		--TECHNICALLY NOT A NOP
		control_word <= "00000000000000000000000000100001000"; --nop
		wait for clk_period;

		control_word <= "10111100000000000000000101100101001"; --nop
		wait for clk_period;

		control_word <= "10111100000000000000000101100101001"; --nop
		wait for clk_period;

		control_word <= "00000000000000000000000000100001000"; --nop
		wait for clk_period;

		control_word <= "00000000000000000000000000100001000"; --nop
		wait for clk_period;

		control_word <= "00000000000000000000000000100001000"; --nop
		wait for clk_period;

		control_word <= "11011001000000000000001001100101101"; --nop
		wait for clk_period;

		control_word <= "11011000001000000000001001100101101"; --nop
		wait for clk_period;

		control_word <= "11011000111000000000001001100101101"; --nop
		wait for clk_period;

		control_word <= "11011001001000000000001001100101101"; --nop
		wait for clk_period;

		control_word <= "11011000110000000000001001100101101"; --nop
		wait for clk_period;

		control_word <= "11011001110000000000001001100101101"; --nop
		wait for clk_period;

		control_word <= "00000000000000000000000000100001000"; --nop
		wait for clk_period;

		control_word <= "00000000000000000000000000100001000"; --nop
		wait for clk_period;

		control_word <= "00000000000000000000000000100001000"; --nop
		wait for clk_period;

		single_cycle_enable <= '0';
		wait;
	end process;
end architecture;
