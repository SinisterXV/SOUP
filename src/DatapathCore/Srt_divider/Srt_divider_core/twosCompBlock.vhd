--block used to generate the 2's complement of a number A
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity twosCompBlock is
	Generic(NBIT: integer := 32);
	Port(A: in std_logic_vector(NBIT-1 downto 0);
		 Z: out std_logic_vector(NBIT-1 downto 0));
end twosCompBlock;

architecture STRUCTURAL of twosCompBlock is
	signal notA: std_logic_vector(NBIT-1 downto 0); --will store not(A)
begin
	notA <= not(A);
	Z <= std_logic_vector(unsigned(notA) + 1);
end STRUCTURAL;
