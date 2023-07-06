library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SRTDivider is
  Generic(NBIT: integer := 32);
  Port(clk, rst:  in  std_logic;
       dividend:  in  std_logic_vector(NBIT - 1 downto 0);
	   divisor:   in  std_logic_vector(NBIT/2 - 1 downto 0);
	   A_ld: 	  in  std_logic;
       sel_A:	  in  std_logic_vector(1 downto 0);
	   B_ld:	  in  std_logic;
	   Q_rst:	  in  std_logic;
	   Q_ld:	  in  std_logic;
	   correct_s: in  std_logic;
       quotient:  out std_logic_vector(NBIT/2 - 1 downto 0);
	   remainder: out std_logic_vector(NBIT/2 - 1 downto 0);
	   A_MSB:	  out std_logic);
end SRTDivider;

architecture MIXED of SRTDivider is
	component digitLUT is
    Port (A: in  std_logic_vector(5 downto 0);
          B: in  std_logic_vector(2 downto 0);
          q: out std_logic_vector(2 downto 0));
	end component;

	signal currA, nextA: signed(NBIT + 2 downto 0); --register A declaration
	signal currB, nextB: signed(NBIT/2 + 1 downto 0); --register B declaration
  	signal currQ, nextQ: unsigned(NBIT/2 + 1 downto 0); --register Q declaration
	signal digit: std_logic_vector(2 downto 0); --current iteration generated digit
    signal B_mux: signed(NBIT/2 + 1 downto 0);

	--possible q digits used for comparison
	constant two: std_logic_vector(2 downto 0) := "010";
	constant one: std_logic_vector(2 downto 0) := "001";
	constant zero: std_logic_vector(2 downto 0) := "000";
	constant minusOne: std_logic_vector(2 downto 0) := "111";
	constant minusTwo: std_logic_vector(2 downto 0) := "110";
begin
  	digitLUT_1: digitLUT Port Map (A => std_logic_vector(currA(NBIT + 2 downto NBIT - 3)), B => std_logic_vector(currB(NBIT/2 - 2 downto NBIT/2 - 4)), q => digit);
	
	RegProc: process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				currA <= (others => '0');
				currB <= (others => '0');
				currQ <= (others => '0');
			else
				currA <= nextA;
				currB <= nextB;
				currQ <= nextQ;
			end if;
		end if;
	end process RegProc;

  	quotient <= std_logic_vector(currQ(NBIT/2 - 1 downto 0));
    remainder <= std_logic_vector(currA(NBIT + 1 downto NBIT/2 + 2));
    A_MSB <= nextA(NBIT + 2); --need to know the  A's sign before it updates the register to know if it should be corrected

  	CombLogic: process(dividend, divisor, currA, A_ld, sel_A, currB, B_ld, B_mux, currQ, Q_rst, Q_ld, correct_s, digit)
		variable aluOut: signed(NBIT/2 + 1 downto 0); --output of the alu that performs different sums
		variable concatenationTmp: signed(NBIT + 2 downto 0); --temporary variable containing (0 & input1 & input2)
		variable fourQ: unsigned(NBIT/2 + 1 downto 0); --will hold 4*Q
	begin
		--A register logic
		if (A_ld = '1') then
			if (sel_A = "00") then
        		nextA <= signed(("000" & dividend));
			elsif (sel_A = "01") then
        		aluOut := B_mux + currA(NBIT + 1 downto NBIT/2);
				concatenationTmp := '0' & aluOut & currA(NBIT/2 - 1 downto 0);
        		nextA <= shift_left(concatenationTmp, 2); --multiply the concatenation by 4
			elsif (sel_A = "10") then
				aluOut := ('0' & currA(NBIT + 2 downto NBIT/2 + 2)) + currB;
				concatenationTmp := '0' & aluOut & currA(NBIT/2 + 1 downto 2);
				nextA <= shift_left(concatenationTmp, 2); --multiply the concatenation by 4
			end if;
		else
			nextA <= currA;
		end if;

		--B register logic
		if (B_ld = '1') then
      		nextB <= signed("00" & divisor);
		else
			nextB <= currB;
		end if;

		--B_mux logic
		case (digit) is
			when two =>
				B_mux <= not(shift_left(currB, 1)) + 1; --two's complement of 2B, for subtraction
			when one =>
				B_mux <= not(currB) + 1; --two's complement of B, for subtraction
			when zero =>
				B_mux <= (others => '0');
			when minusOne =>
				B_mux <= currB;
			when minusTwo =>
        		B_mux <= shift_left(currB, 1);
			--unused
			when others =>
				B_mux <= (others => '0');
		end case;

		--Q register logic
		if (Q_ld = '1') then
			if (Q_rst = '1') then
				nextQ <= (others => '0');
			elsif (correct_s = '1') then
				nextQ <= currQ - 1;
			else
        		fourQ := unsigned(currQ(NBIT/2 - 1 downto 0) & "00");

				case (digit) is
					when two =>
						nextQ <= fourQ + 2;
					when one =>
						nextQ <= fourQ + 1;
					when zero =>
						nextQ <= fourQ;
					when minusOne =>
						nextQ <= fourQ - 1;
					when minusTwo =>
						nextQ <= fourQ - 2;
					--unused
					when others =>
						nextQ <= currQ;
					end case;
			end if;
		else
			nextQ <= currQ;
		end if;
	end process CombLogic;
end MIXED;