-- File              : a.b.i.b.c-zeroesCounter.vhd
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
USE ieee.std_logic_unsigned.all;

entity zeroesCounter is
	Generic(NBIT: integer := 32;
			CNTWIDTH: integer := 5); --width of the counter: has to be ⌈log2(N-1)⌉
	Port(A: in std_logic_vector(NBIT - 1 downto 0);
		 cnt: out std_logic_vector(CNTWIDTH - 1 downto 0));
end zeroesCounter;

architecture BEHAVIORAL of zeroesCounter is
begin
	process(A)
		variable tmpCnt: std_logic_vector(CNTWIDTH - 1 downto 0);
		variable flag: std_logic; --if 1 the first 0 has been found and the counting has to stop
	begin
		tmpCnt := (others => '0');
		flag := '0';
		
		for i in NBIT - 1 downto 0 loop
			if ((A(i) = '0') and (flag = '0')) then
				tmpCnt := tmpCnt + 1;
			else
				flag := '1';
			end if;
		end loop;

		cnt <= tmpCnt;
	end process;
end BEHAVIORAL;
