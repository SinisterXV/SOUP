library ieee;
use ieee.std_logic_1164.all;

entity PGNetwork is
    generic(
        NBIT: natural := 32
    );
    port(
        a:    in std_logic_vector(NBIT-1 downto 0);
        b:    in std_logic_vector(NBIT-1 downto 0);
        cin:  in std_logic;
        pOut: out std_logic_vector(NBIT-1 downto 0);
        gOut: out std_logic_vector(NBIT-1 downto 0)
    );
end entity PGNetwork;

architecture structural of PGNetwork is

begin

    cycle: for index in 0 to NBIT-1 generate
        -- Generate all the p elements
        pOut(index) <= a(index) XOR b(index);
        -- G elements have different expressions depending on index.
        -- In this way, we consider the presence of a cin as well.
        indexEq0: if index = 0 generate
            gOut(index) <= (a(index) AND b(index)) OR ((a(index) XOR b(index)) AND cin);
        end generate indexEq0;
        indexNeq0: if index /= 0 generate
            gOut(index) <= a(index) AND b(index);
        end generate indexNeq0;
    end generate cycle;

end architecture structural;
