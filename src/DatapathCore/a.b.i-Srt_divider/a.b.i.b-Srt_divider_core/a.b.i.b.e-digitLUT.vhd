-- File              : a.b.i.b.e-digitLUT.vhd
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

entity digitLUT is
  Port (A: in  std_logic_vector(5 downto 0);
        B: in  std_logic_vector(2 downto 0);
        q: out std_logic_vector(2 downto 0));
end entity;

architecture BEHAVIORAL of digitLUT is
  type LUTtype is array(0 to 511) of std_logic_vector(2 downto 0);

  constant LUT: LUTType := ("000", "000", "001", "001", "001", "001", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "111", "111", "111", "111", "000", "000", 
                            "000", "000", "001", "001", "001", "001", "001", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "111", "111", "111", "111", "111", "000", "000", 
                            "000", "000", "001", "001", "001", "001", "001", "001", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "111", "111", "111", "111", "111", "111", "000", "000", 
                            "000", "000", "001", "001", "001", "001", "001", "001", 
                            "001", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "111", 
                            "111", "111", "111", "111", "111", "111", "000", "000", 
                            "000", "000", "000", "001", "001", "001", "001", "001", 
                            "001", "001", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "111", "111", 
                            "111", "111", "111", "111", "111", "000", "000", "000", 
                            "000", "000", "000", "001", "001", "001", "001", "001", 
                            "001", "001", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "111", "111", 
                            "111", "111", "111", "111", "111", "000", "000", "000", 
                            "000", "000", "000", "001", "001", "001", "001", "001", 
                            "001", "001", "001", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "111", "111", "111", 
                            "111", "111", "111", "111", "111", "000", "000", "000", 
                            "000", "000", "000", "001", "001", "001", "001", "001", 
                            "001", "001", "001", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "010", "010", "010", "010", "010", "010", "010", "010", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "110", "110", "110", 
                            "110", "110", "110", "110", "110", "111", "111", "111", 
                            "111", "111", "111", "111", "111", "000", "000", "000"); 

begin
	process(A, B)
		variable BA: std_logic_vector(8 downto 0);
	begin
    	BA := B & A;
		q <= LUT(to_integer(unsigned(BA)));
	end process;
end architecture;
