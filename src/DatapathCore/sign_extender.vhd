library ieee;
use ieee.std_logic_1164.all;

entity sign_extender is
	port(
		immediate           : in std_logic_vector(15 downto 0);
		signed_unsigned_bar : in std_logic;
		result              : out std_logic_vector(31 downto 0)
	);
end sign_extender;

architecture BEHAVIORAL of sign_extender is
	constant sixteenOne    : std_logic_vector(15 downto 0) := (others => '1');
	constant sixteenZeroes : std_logic_vector(15 downto 0) := (others => '0');
begin
	result <= (sixteenOne & immediate) when ((immediate(15) = '1') and (signed_unsigned_bar = '1')) else
		(sixteenZeroes & immediate);
end BEHAVIORAL;
