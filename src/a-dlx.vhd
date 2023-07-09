library ieee;
use ieee.std_logic_1164.all;

entity dlx is
	port
	(
		clk, rst     : in std_logic;
		iram_out     : in std_logic_vector(31 downto 0);
		dram_out     : in std_logic_vector(31 downto 0);
		iram_address : out std_logic_vector(31 downto 0);
		dram_address : out std_logic_vector(31 downto 0);
		dram_rw_bar  : out std_logic;
		dram_in      : out std_logic_vector(31 downto 0)
	);
end entity;

architecture STRUCTURAL of dlx is
	signal div_done            : std_logic;
	signal mul_done            : std_logic;
	signal invalid_div         : std_logic;
	signal single_cycle_enable : std_logic;
	signal pc_enable           : std_logic;
	signal control_word        : std_logic_vector(32 downto 0);
begin
	cntrl : entity work.controller
		port map
		(
			clk                 => clk,
			rst                 => rst,
			opcode              => iram_out(31 downto 26),
			div_done            => div_done,
			mul_done            => mul_done,
			invalid_div         => invalid_div,
			pc_enable           => pc_enable,
			single_cycle_enable => single_cycle_enable,
			cw                  => control_word
		);

	dtpth: entity work.datapath
		port map (
			clk                 => clk,
			rst                 => rst,
			control_word        => control_word,
			iram_out            => iram_out,
			dram_out            => dram_out,
			pc_enable           => pc_enable,
			single_cycle_enable => single_cycle_enable,
			iram_address        => iram_address,
			dram_address        => dram_address,
			dram_rw_bar         => dram_rw_bar,
			dram_in             => dram_in,
			mul_done            => mul_done,
			div_done            => div_done,
			invalid_div         => invalid_div
		);
end architecture;
