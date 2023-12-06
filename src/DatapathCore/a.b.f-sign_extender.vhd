-- 
--  File              : sign_extender.vhd
--
--  Description       : Extends ad immediate value on 16 or 26 bits
--						on 32 bits, either in a signed or unsigned way
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

entity sign_extender is
    port
    (
        immediate16         : in std_logic_vector(15 downto 0);
        immediate26         : in std_logic_vector(25 downto 0);
        size_16_26_bar      : in std_logic;
        signed_unsigned_bar : in std_logic;
        result              : out std_logic_vector(31 downto 0)
    );
end sign_extender;

architecture BEHAVIORAL of sign_extender is
    constant sixteenOnes   : std_logic_vector(15 downto 0) := (others => '1');
    constant sixteenZeroes : std_logic_vector(15 downto 0) := (others => '0');
    constant sixOnes       : std_logic_vector(5 downto 0)  := (others => '1');
    constant sixZeros      : std_logic_vector(5 downto 0)  := (others => '0');
begin
    -- if size_16_26_bar is '0', then immediate26 input is considered, and it is
    -- extended as signed. Otherwise, the immediate16 input is considered: 
    -- depending on the value of signed_unsigned_bar, the extension
    -- is performed either signed or unsigned.
    combLogic: process(immediate16, immediate26, size_16_26_bar, signed_unsigned_bar)
    begin
        if(size_16_26_bar = '0') then
            if(signed_unsigned_bar = '1') then
                if(immediate26(25) = '1') then
                    result <= (sixOnes & immediate26);
                else
                    result <= (sixZeros & immediate26);
                end if;
            else
                result <= (sixZeros & immediate26);
            end if;
        else 
            if(signed_unsigned_bar = '1') then
                if(immediate16(15) = '1') then
                    result <= (sixteenOnes & immediate16);
                else
                    result <= (sixteenZeroes & immediate16);
                end if;
            else
                result <= (sixteenZeroes & immediate16);
            end if;
        end if;
    end process combLogic;

    -- result <= (sixOnes & immediate26) when ((size_16_26_bar = '0') and (immediate26(25) = '1')) else
    -- 		  (sixZeros & immediate26) when ((size_16_26_bar = '0') and (immediate26(25) = '0')) else
    -- 		  (sixteenOne & immediate16) when ((immediate16(15) = '1') and (signed_unsigned_bar = '1')) else
    -- 		  (sixteenZeroes & immediate16);

end BEHAVIORAL;