library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity boothMulDatapath is
	Generic(NBIT: integer := 32); --length of the inputs
	Port(clk, rst		  : in  std_logic;
		 A		 		  : in  std_logic_vector(NBIT-1 downto 0); --multiplicand
		 A_ld	 		  : in  std_logic; --A register's load signal
		 A_shift 		  : in std_logic; --A register's shift-left signal
		 B		 		  : in  std_logic_vector(NBIT-1 downto 0); --multiplier
		 B_ld	 		  : in  std_logic; --B register's load signal
		 B_shift 		  : in  std_logic; --B register's shift-right signal
		 P		 		  : out std_logic_vector(2*NBIT-1 downto 0); --iteration's output
		 P_ld	 		  : in  std_logic; --P register's load signal
		 P_rst			  : in  std_logic); --P register reset signal
end boothMulDatapath;

architecture BEHAVIORAL of boothMulDatapath is
	component twosCompBlock is
		Generic(NBIT: integer := 32);
		Port(A: in std_logic_vector(NBIT-1 downto 0);
			 Z: out std_logic_vector(NBIT-1 downto 0));
	end component;

	constant NBITzeroes: std_logic_vector(NBIT-1 downto 0) := (others => '0'); --used to resize and load A into its register
	constant NBITones: std_logic_vector(NBIT-1 downto 0) := (others => '1'); --used to resize and load A into its register
	
	signal currA, nextA: std_logic_vector(2*NBIT-1 downto 0); --register containing A
	signal twoA, minusA, minusTwoA, muxOut: std_logic_vector(2*NBIT-1 downto 0); --signal representing 2A, -A, -2A, the output of the mux
	signal currB, nextB: std_logic_vector(NBIT downto 0); --register containing (B & '0')
	signal currP, nextP: std_logic_vector(2*NBIT-1 downto 0); --register containing the intermediate products
	
begin
	RegProc: process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				currA <= (others => '0');
				currB <= (others => '0');
				currP <= (others => '0');
			else
				currA <= nextA;
				currB <= nextB;
				currP <= nextP;
			end if;
		end if;
	end process RegProc;

	twosCompBlock_0: twosCompBlock Generic Map(NBIT => 2*NBIT)
								   Port Map(A => currA, Z => minusA);

	twoA <= currA(2*NBIT-2 downto 0) & '0';
	minusTwoA <= minusA(2*NBIT-2 downto 0) & '0';
	
	--dataflow description of mux + encoder
	with (currB(2 downto 0)) select
		muxOut <= currA			  when "001" | "010",
				  twoA			  when "011",
				  minusTwoA		  when "100",
				  minusA		  when "101" | "110",
				  (others => '0') when others;

	CombLogic: process(A, currA, A_ld, A_shift, B, currB, B_ld, B_shift, currP, P_ld, P_rst, muxOut)
	begin
		--A register combinational logic
		if (A_ld = '1') then
			if (A(NBIT-1) = '1') then
				--A is negative
				nextA <= NBITones & A; --load A_reg with A, sign extended with ones
			else 
				--A is positive
				nextA <= NBITzeroes & A; --load A_reg with A, extend it with zeroes
			end if;
		elsif(A_shift = '1') then
			--left_shift A by 2 positions
			nextA <= currA(2*NBIT-3 downto 0) & "00";
		else
			nextA <= currA;
		end if;

		--B register combinational logic
		if (B_ld = '1') then
			nextB <= B & '0';
		elsif (B_shift = '1') then
			--shift right B by 3 positions
			nextB <= "00" & currB(NBIT downto 2);
		else
			nextB <= currB;
		end if;

		--P register combinational logic
		if (P_rst = '1') then
			nextP <= (others => '0');
		elsif (P_ld = '1') then
			nextP <= std_logic_vector(signed(currP) + signed(muxOut)); --technically P and muxOut are signed but the cast makes no difference
		else
			nextP <= currP;
		end if;
	end process CombLogic;

	P <= currP; --output assignment
end BEHAVIORAL;
