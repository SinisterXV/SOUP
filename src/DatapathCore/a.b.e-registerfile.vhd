-- 
--  File              : register_file.vhd
--
--  Description       : Register file for the dlx.
--						There are 2 reading ports and 1 writing port.
--						Writing is synchronous, while reading is asynchronous.	
--						When write31 is high, the 31th register is used as 
--						destination register. This operation has priority 
--						over any other writing operation.
--
--  Author            : Giacomo Sansone <s307761@studenti.polito.it>
--
--  Date              : 20.10.2023
--  Last Modified Date: 20.10.2023
--
--  Copyright (c) 2023
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity register_file is
	generic(NBIT: integer := 32); --width of each register
	port(clk: 		in std_logic;
		reset: 		in std_logic;
        -- general enable of the rf
		enable: 	in std_logic;
        -- enable read from port 1
		rd1: 		in std_logic;
        -- enable read from port 2
		rd2: 		in std_logic;
        -- enable write
		wr: 		in std_logic;
        -- force the writing on port 31
		write31:    in std_logic;
        -- port 1 selection
		add_rd1: 	in std_logic_vector(4 downto 0);
        -- port 2 selection
		add_rd2: 	in std_logic_vector(4 downto 0);
        -- port write selection
		add_wr: 	in std_logic_vector(4 downto 0);
        -- output port 1 
		out1: 		out std_logic_vector(NBIT - 1 downto 0);
        -- output port 2 
		out2: 		out std_logic_vector(NBIT - 1 downto 0);
        -- data in for writing
		datain: 	in std_logic_vector(NBIT - 1 downto 0));
end register_file;

architecture a of register_file is
	subtype reg_addr is natural range 0 to 31; --allowed register addresses
	type reg_array is array(reg_addr) of std_logic_vector(NBIT - 1 downto 0); --register file type declaration

    signal not_clk: std_logic;
	signal registers: reg_array; --register file signal declaration
begin

    -- with this signal, the writing operation is performed on the falling edge
    -- of the clock. Using `falling_edge(clk)` was not an option since it
    -- was not synthesizable using our library
    not_clk <= not(clk);
    
    -- Read port 1
	readproc1: process(registers, enable, rd1, add_rd1)
	begin
		if((enable = '1') and (rd1 = '1')) then
			out1 <= registers(to_integer(unsigned(add_rd1)));
		else
			out1 <= (others => '0');
		end if;
	end process readproc1;

    -- Read port 2
	readproc2: process(registers, enable, rd2, add_rd2)
	begin
		if((enable = '1') and (rd2 = '1')) then
			out2 <= registers(to_integer(unsigned(add_rd2)));
		else
			out2 <= (others => '0');
		end if;
	end process readproc2; 


    -- Write operation
	writeproc: process(not_clk)
	begin
		if(rising_edge(not_clk)) then
            -- synchronous reset
			if(reset = '1') then
				registers <= (others => (others => '0'));
            -- enable
			elsif((enable = '1') and (wr = '1')) then
                -- write31 is set
				if (write31 = '1') then
					registers(31) <= datain;
                -- we use the provided address
				elsif(unsigned(add_wr) /= 0) then --prevent writing to Regs[0]
					registers(to_integer(unsigned(add_wr))) <= datain;
				end if;
			end if;
		end if;
	end process writeproc;
end a;