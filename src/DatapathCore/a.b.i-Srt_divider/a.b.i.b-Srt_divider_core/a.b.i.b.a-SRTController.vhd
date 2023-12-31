-- File              : a.b.i.b.a-SRTController.vhd
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

entity SRTController is
  Generic(NBIT: integer := 32);
	Port(clk, rst:  	   in  std_logic;
		 startDiv:  	   in  std_logic;
		 invalid_division: in  std_logic;
		 A_MSB:	  		   in  std_logic;
		 doneDiv:   	   out std_logic;
	     negResult_ld:	   out std_logic;
	     shift_amount_ld:  out std_logic;
  	     A_ld: 	  		   out std_logic;
         sel_A:	  		   out std_logic_vector(1 downto 0);
		 B_ld:	  		   out std_logic;
		 Q_rst:  		   out std_logic;
	     Q_ld:	  		   out std_logic;
	     correct_s: 	   out std_logic);
end SRTController;

architecture BEHAVIORAL of SRTController is
	type StateType is (idle, preProc, divide, correctSign, skipSign, postProc);
	constant CNTWIDTH: integer := integer(ceil(log2(real(NBIT/4)))) + 1;

	signal currState, nextState: StateType;
  signal currCount, nextCount: unsigned(CNTWIDTH - 1 downto 0);
begin
	RegProc: process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				currState <= idle;
        		currCount <= to_unsigned(NBIT/4, CNTWIDTH);
			else
				currState <= nextState;
				currCount <= nextCount;
			end if;
		end if;
	end process RegProc;

    CombLogic: process(currState, currCount, startDiv, invalid_division, A_MSB)
	begin
		doneDiv <= '0'; negResult_ld <= '0';
		shift_amount_ld <= '0'; A_ld <= '0';
		sel_A <= "00"; B_ld <= '0';
    	Q_rst <= '0'; Q_ld <= '0'; correct_s <= '0';
        nextState <= currState;

		case (currState) is
			when idle =>
				if (startDiv = '1' and invalid_division = '0') then
					nextState <= preProc;
				end if;

			when preProc =>
				if (invalid_division = '0') then
					nextState <= divide;
				else
					nextState <= idle;
				end if;

				negResult_ld <= '1'; shift_amount_ld <= '1';
				A_ld <= '1'; sel_A <= "00";
				B_ld <= '1'; Q_rst <= '1';
				nextCount <= to_unsigned(NBIT/4, CNTWIDTH);

			when divide =>
				if (invalid_division = '1') then
					nextState <= idle;
				elsif (currCount = 0) then
					if (A_MSB = '1') then
						nextState <= correctSign;
					else
						nextState <= skipSign;
					end if;
				end if;

				A_ld <= '1'; sel_A <= "01";
				Q_ld <= '1';
				nextCount <= currCount - 1;

			when correctSign =>
				nextState <= postProc;
				A_ld <= '1'; sel_A <= "10";
				Q_ld <= '1'; correct_s <= '1';

			--needed to make the division always last the same amount of cycles
			when skipSign =>
				nextState <= postProc;

			when postProc =>
				doneDiv <= '1';
				nextState <= idle;

			--to prevent misbehaviour in case the FSM is in an illegal state
			when others =>
				nextState <= idle;
		end case;
	end process CombLogic;
end BEHAVIORAL;
