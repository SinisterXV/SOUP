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
	constant sixteenOne    : std_logic_vector(15 downto 0) := (others => '1');
	constant sixteenZeroes : std_logic_vector(15 downto 0) := (others => '0');
	constant sixZeroes     : std_logic_vector(5 downto 0)  := (others => '0');
begin
	result <= (sixZeroes & immediate26) when (size_16_26_bar = '0') else
		(sixteenOne & immediate16) when ((immediate16(15) = '1') and (signed_unsigned_bar = '1')) else
		(sixteenZeroes & immediate16);
end BEHAVIORAL;
