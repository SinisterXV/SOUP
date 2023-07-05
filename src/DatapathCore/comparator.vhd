library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
	generic (NBIT : integer := 32); --input sum and output size
	port
	(
		cout   : in std_logic;
		sum    : in std_logic_vector(NBIT - 1 downto 0);
		config : in std_logic_vector(2 downto 0);
		output : out std_logic_vector(NBIT - 1 downto 0)
	);
end comparator;

architecture BEHAVIORAL of comparator is
	constant NBITm1zeroes: std_logic_vector(NBIT - 2 downto 0) := (others => '0');

	--intermediate signals
	signal z, lessThanEq, lessThan, greaterThan, greaterThanEqual, equal, notEqual, selectOut: std_logic;
begin
	z <= '1' when (unsigned(sum) = 0) else
		'0';

	lessThanEq       <= z or not(cout);
	lessThan         <= not(cout);
	greaterThan      <= cout and not (z);
	greaterThanEqual <= cout;
	equal            <= z;
	notEqual         <= not(z);

	with (config) select
		selectOut <= lessThanEq when "000",
					lessThan when "001",
					greaterThan when "010",
					greaterThanEqual when "011",
					equal when "100",
					notEqual when "101",
					'0' when others;

	output <= NBITm1zeroes & selectOut;
	
end architecture;
