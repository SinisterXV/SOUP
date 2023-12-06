-- File              : a.b.i.b.b-SRTWrapper.vhd
-- Authors           : Giacomo Sansone      <s307761@studenti.polito.it> 
--                   : Giuseppe Silvestri   <s307792@studenti.polito.it>
--                   : Arianna Valenza      <s317742@studenti.polito.it>
-- Date              : 17.07.2023
--
-- Copyright (c) 2023
--
-- Licensed under the Solderpad Hardware License v 2.1 (the "License");
-- you may not use this file except in compliance with the License, or,
-- at your option, the Apache License version 2.0.
-- You may obtain a copy of the License at
--
--     https://solderpad.org/licenses/SHL-2.1/
--
-- Unless required by applicable law or agreed to in writing, any work
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity SRTWrapper is
	Generic(NBIT: integer := 32);
	Port(clk, rst: 		   	in  std_logic;
		 dividend: 		   	in  std_logic_vector(NBIT - 1 downto 0);
		 divisor: 		   	in  std_logic_vector(NBIT - 1 downto 0);
		 startDiv:			in  std_logic;
         doneDiv:           in  std_logic;
		 signedUnsignedbar: in  std_logic; --if 0, dividend is unsigned, else it's signed
		 negResult_ld:	   	in  std_logic;
		 shift_amount_ld: 	in  std_logic;
		 A_ld: 	  			in  std_logic;
     	 sel_A:	  		    in  std_logic_vector(1 downto 0);
		 B_ld:	  			in  std_logic;
		 Q_rst:				in  std_logic;
		 Q_ld:	  			in  std_logic;
		 correct_s: 		in  std_logic;
		 quotient:   	   	out std_logic_vector(NBIT - 1 downto 0);
		 remainder:  	   	out std_logic_vector(NBIT - 1 downto 0);
		 invalid_division: 	out std_logic;
		 A_MSB:	  			out std_logic);
end SRTWrapper;

architecture MIXED of SRTWrapper is
	component twosCompBlock is
		Generic(NBIT: integer := 32);
		Port(A: in  std_logic_vector(NBIT-1 downto 0);
			 Z: out std_logic_vector(NBIT-1 downto 0));
	end component;

	component zeroesCounter is
		Generic(NBIT: integer := 32;
			    CNTWIDTH: integer := 5); --width of the counter: has to be ceil(log2(N-1))
		Port(A:   in  std_logic_vector(NBIT - 1 downto 0);
			 cnt: out std_logic_vector(CNTWIDTH - 1 downto 0));
	end component;

	component SRTDivider is
		Generic(NBIT: integer := 32);
		Port(clk, rst: in  std_logic;
			dividend:  in  std_logic_vector(NBIT - 1 downto 0);
			divisor:   in  std_logic_vector(NBIT/2 - 1 downto 0);
			A_ld: 	   in  std_logic;
      		sel_A:	   in  std_logic_vector(1 downto 0);
			B_ld:	   in  std_logic;
			Q_rst:	   in  std_logic;
			Q_ld:	   in  std_logic;
			correct_s: in  std_logic;
			quotient:  out std_logic_vector(NBIT/2 - 1 downto 0);
			remainder: out std_logic_vector(NBIT/2 - 1 downto 0);
			A_MSB:	   out std_logic);
	end component;

	constant halfNZeroes: std_logic_vector(NBIT/2 - 1 downto 0) := (others => '0'); --constant used for concatenation
	constant shift_amount_length: integer := integer(ceil(log2(real(NBIT)))); --length of the counter for the leading zeroes of the dividend 

  	signal dividendComplement, divisorComplement, dividendMux, divisorMux, normalizedDividend: std_logic_vector(NBIT - 1 downto 0);
  	signal normalizedDivisor: std_logic_vector(NBIT/2 - 1 downto 0);
	signal SRTquotient, SRTremainder, correctedSRTremainder: std_logic_vector(NBIT/2 - 1 downto 0); --declaration of the outputs of the SRT divider
	signal resizedSRTquotient, resizedSRTremainder, quotientComplement, remainderComplement: std_logic_vector(NBIT - 1 downto 0);
	signal currNegResult, nextNegResult: std_logic_vector(1 downto 0); --negative result register declaration
	signal currShiftAmount, nextShiftAmount: std_logic_vector(shift_amount_length - 1 downto 0); --shift amount register declaration
	signal changeDividendSign, changeDivisorSign: std_logic; --mux selection signals: if 1, the operand is negative and needs to be made positive (by complementing it)
	signal shift_amount: std_logic_vector(shift_amount_length - 1 downto 0);

	signal invalid_division_unsigned: std_logic;
	signal invalid_division_signed: std_logic;
begin
	RegProc: process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				currNegResult <= (others => '0');
				currShiftAmount <= (others => '0');
			else
				currNegResult <= nextNegResult;
				currShiftAmount <= nextShiftAmount;
			end if;
		end if;
	end process RegProc;

	twosCompBlock_1: twosCompBlock Generic Map (NBIT => NBIT) Port Map (A => dividend, Z => dividendComplement); --compute 2's complement of dividend
	twosCompBlock_2: twosCompBlock Generic Map (NBIT => NBIT) Port Map (A => divisor, Z => divisorComplement); --compute 2's complement of divisor

	changeDividendSign <= signedUnsignedbar and dividend(NBIT - 1); --compute dividend selection signal
	changeDivisorSign <= signedUnsignedbar and divisor(NBIT / 2 - 1); --compute divisor selection signal

	dividendMux <= dividend when (changeDividendSign = '0') else
				   dividendComplement;
	
	divisorMux <= divisor when (changeDivisorSign = '0') else
				  divisorComplement;

  	zeroesCounter_1: zeroesCounter Generic Map (NBIT => NBIT/2, CNTWIDTH => shift_amount_length) Port Map (A => divisorMux(NBIT/2 - 1 downto 0), cnt => shift_amount);

	normalizedDividend <= std_logic_vector(shift_left(unsigned(dividendMux), to_integer(unsigned(shift_amount))));
	normalizedDivisor <= std_logic_vector(shift_left(unsigned(divisorMux(NBIT/2 - 1 downto 0)), to_integer(unsigned(shift_amount))));

	SRTDivider_1: SRTDivider Generic Map (NBIT => NBIT) 
							 Port Map (clk => clk, rst => rst, divisor => normalizedDivisor, dividend => normalizedDividend,
									   A_ld => A_ld, sel_a => sel_a, B_ld => B_ld, Q_rst => Q_rst, Q_ld => Q_ld, correct_s => correct_s, 
									   quotient => SRTquotient, remainder => SRTremainder, A_MSB => A_MSB);

    correctedSRTremainder <= std_logic_vector(shift_right(unsigned(SRTremainder), to_integer(unsigned(currShiftAmount))));

    resizedSRTquotient <= halfNZeroes & SRTquotient;
	resizedSRTremainder <= halfNZeroes & correctedSRTremainder;

	twosCompBlock_3: twosCompBlock Generic Map (NBIT => NBIT) Port Map (A => resizedSRTquotient, Z => quotientComplement); --compute 2's complement of resized quotient
	twosCompBlock_4: twosCompBlock Generic Map (NBIT => NBIT) Port Map (A => resizedSRTremainder, Z => remainderComplement); --compute 2's complement of resized remainder

	quotient <= resizedSRTquotient when (currNegResult(1) = '0') else
				quotientComplement;

	remainder <= resizedSRTremainder when (currNegResult(0) = '0') else
				 remainderComplement;

	invalid_div_signed_logic: process(doneDiv, currNegResult, SRTquotient)
        variable two_to_N_minus_1 : std_logic_vector(NBIT/2 - 1 downto 0);
	begin
        two_to_N_minus_1 := "01" & halfNZeroes(NBIT/2 - 3 downto 0);
		if ((unsigned(SRTquotient) >= unsigned(two_to_N_minus_1)) and
            (currNegResult(1) = '0') and
			(signedUnsignedBar = '1') and
            (doneDiv = '1')) then
            invalid_division_signed <= '1';
		elsif ((unsigned(SRTquotient) > unsigned(two_to_N_minus_1)) and
            (currNegResult(1) = '1') and
			(signedUnsignedBar = '1') and
            (doneDiv = '1')) then
            invalid_division_signed <= '1'; 
        else
            invalid_division_signed <= '0';
        end if;
	end process invalid_div_signed_logic;


	ComparatorLogic: process(dividendMux, divisorMux, startDiv)
		variable leftShiftedDivisor: std_logic_vector(NBIT - 1 downto 0);
	begin
		leftShiftedDivisor := divisorMux(NBIT/2 - 1 downto 0) & halfNZeroes;
		if (unsigned(dividendMux) >= unsigned(leftShiftedDivisor)) then
			invalid_division_unsigned <= '1' and startDiv;
		else
			invalid_division_unsigned <= '0';
		end if;
	end process ComparatorLogic;

    invalid_division <= invalid_division_signed or invalid_division_unsigned;

  	RegistersCombLogic: process(changeDividendSign, changeDivisorSign, currNegResult, negResult_ld, shift_amount, currShiftAmount, shift_amount_ld)
	begin
		--negResult register logic
		if (negResult_ld = '1') then
			nextNegResult <= (changeDividendSign xor changeDivisorSign) & changeDividendSign;
		else
			nextNegResult <= currNegResult;
		end if;

		--shift_amount register logic
		if (shift_amount_ld = '1') then
			nextShiftAmount <= shift_amount;
		else
			nextShiftAmount <= currShiftAmount;
		end if;
	end process RegistersCombLogic;
end MIXED;
