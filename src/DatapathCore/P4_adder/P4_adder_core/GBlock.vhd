library ieee;
use ieee.std_logic_1164.all;

entity GBlock is
    port(
        gL, pL, gR: in  std_logic;
        gOut:       out std_Logic
        );
end entity GBlock;

architecture behavioural of GBlock is
begin
    combLogic: process(gL, pL, gR)
    begin
        gOut <= gL OR ( pL AND gR);
    end process combLogic;
end architecture behavioural;
