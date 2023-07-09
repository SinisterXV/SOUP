library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity boothMul is
	Generic(NBIT: integer := 32); --multiplicand and multiplier length
	Port(clk, rst         : in  std_logic;
		 startMul         : in  std_logic; --start signal
		 A		          : in  std_logic_vector(NBIT-1 downto 0); --multiplicand
		 B		          : in  std_logic_vector(NBIT-1 downto 0); --multiplier
		 P		          : out std_logic_vector(2*NBIT-1 downto 0); --product
		 doneMul          : out std_logic); --done signal
end boothMul;

architecture MIXED of boothMul is
	component boothMulDatapath is
		Generic(NBIT: integer := 32); --length of the inputs
			Port(clk, rst		  : in  std_logic;
				 A		 		  : in  std_logic_vector(NBIT-1 downto 0); --multiplicand
				 A_ld	 		  : in  std_logic; --A register's load signal
				 A_shift 		  : in  std_logic; --A register's shift-left signal
				 B		 		  : in  std_logic_vector(NBIT-1 downto 0); --multiplier
				 B_ld	 		  : in  std_logic; --B register's load signal
				 B_shift 		  : in  std_logic; --B register's shift-right signal
				 P		 		  : out std_logic_vector(2*NBIT-1 downto 0); --iteration's output
				 P_ld	 		  : in  std_logic; --P register's load signal
				 P_rst			  : in  std_logic); --P register reset signal
	end component;

	component boothMulController is
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
	end component;

	--intermediate signals declarations
	signal A_ld_s, A_shift_s, B_ld_s, B_shift_s, P_ld_s, P_rst_s: std_logic;
begin
	boothmulcontroller_0: boothMulController
		Generic Map (NBIT => NBIT)
		Port Map (
			clk      => clk,
			rst      => rst,
			startMul => startMul,
			A_ld     => A_ld_s,
			A_shift  => A_shift_s,
			B_ld     => B_ld_s,
			B_shift  => B_shift_s,
			P_ld     => P_ld_s,
			P_rst    => P_rst_s,
			doneMul  => doneMul);

	boothmuldatapath_0: boothMulDatapath
		Generic Map (NBIT => NBIT)
		Port Map (
			clk               => clk,
			rst               => rst,
			A                 => A,
			A_ld              => A_ld_s,
			A_shift           => A_shift_s,
			B                 => B,
			B_ld              => B_ld_s,
			B_shift           => B_shift_s,
			P                 => P,
			P_ld              => P_ld_s,
			P_rst             => P_rst_s);
end MIXED;
