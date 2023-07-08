library ieee;
use ieee.std_logic_1164.all;

entity dlx is
	port
	(
		clk, rst : in std_logic
	);
end entity;

architecture STRUCTURAL of dlx is
	signal opcode              : std_logic_vector(5 downto 0);
	signal div_done            : std_logic;
	signal mul_done            : std_logic;
	signal invalid_div         : std_logic;
	signal single_cycle_enable : std_logic;
	signal pc_enable           : std_logic;
	signal control_word        : std_logic_vector(35 downto 0);
begin
	cntrl : entity work.controller
		port map
		(
			clk                 => clk,
			rst                 => rst,
			opcode              => opcode,
			div_done            => div_done,
			mul_done            => mul_done,
			invalid_div         => invalid_div,
			pc_enable           => pc_enable,
			single_cycle_enable => single_cycle_enable,
			cw                  => control_word
		);

	dtpth : entity work.datapath
		port
		map (
		clk                 => clk,
		rst                 => rst,
		control_word        => control_word,
		pc_enable           => pc_enable,
		single_cycle_enable => single_cycle_enable,
		opcode              => opcode,
		mul_done            => mul_done,
		div_done            => div_done,
		invalid_div         => invalid_div
		);
end architecture;
