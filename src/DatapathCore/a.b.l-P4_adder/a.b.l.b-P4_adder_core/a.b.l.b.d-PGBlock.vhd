library ieee;
use ieee.std_logic_1164.all;

entity PGBlock is
    port(
        gL, pL, gR, pR: in  std_logic;
        gOut, pOut:     out std_logic
        );
end entity PGBlock;

architecture behaviour of PGBlock is
begin
    combLogic: process(gL, pL, gR, pR) 
    begin
        pOut <= pL AND pR;
        gOut <= gL OR (pL AND gR);
    end process combLogic;
end architecture behaviour;
