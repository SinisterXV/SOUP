library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb_dlx is
end entity;

architecture arch of tb_dlx is
	constant clk_period : time    := 1 ns;
	constant RAM_DEPTH  : integer := 8;
	constant I_SIZE     : integer := 32;
	constant RAM_WIDTH  : integer := 8;
	constant WORD_WIDTH : integer := 32;

	signal clk          : std_logic;
	signal rst          : std_logic;
	signal iram_out     : std_logic_vector(31 downto 0);
	signal dram_out     : std_logic_vector(31 downto 0);
	signal iram_address : std_logic_vector(31 downto 0);
	signal dram_address : std_logic_vector(31 downto 0);
	signal dram_rw_bar  : std_logic;
	signal dram_in      : std_logic_vector(31 downto 0);

begin
	inst_mem : entity work.IRAM
		generic map(
			RAM_DEPTH => RAM_DEPTH,
			I_SIZE    => I_SIZE
		)
		port map
		(
			Rst  => Rst,
			Addr => iram_address,
			Dout => iram_out
		);

	data_mem : entity work.DRAM
		generic map(
			RAM_WIDTH  => RAM_WIDTH,
			WORD_WIDTH => WORD_WIDTH
		)
		port
		map (
		rst    => rst,
		clk    => clk,
		rw_bar => dram_rw_bar,
		addr   => dram_address,
		d_in   => dram_in,
		d_out  => dram_out
		);

	dlx_inst : entity work.dlx
		port
		map (
		clk          => clk,
		rst          => rst,
		iram_out     => iram_out,
		dram_out     => dram_out,
		iram_address => iram_address,
		dram_address => dram_address,
		dram_rw_bar  => dram_rw_bar,
		dram_in      => dram_in
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
		wait for 2 * clk_period;
		rst <= '0';
		wait for 1000 * clk_period;
		rst <= '1';
		wait;

	end process;
end architecture;
