library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Using the outputs of a subtractor (both carry-out and the result), this component
-- tells what is the relation between the two operands A and B.

entity comparator is
	generic (NBIT : integer := 32); --input sum and output size
	port(
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

    -- A == B iff the result of the subtraction is zero, so when z = '1'
    -- A >  B iff cout == 1
    -- By putting together these two conditions we can end up with this relations.
	lessThanEq       <= z or not(cout);
	lessThan         <= not(cout);
	greaterThan      <= cout and not (z);
	greaterThanEqual <= cout;
	equal            <= z;
	notEqual         <= not(z);

    -- The correct output is chosen and extended over 32 bits
	with (config) select
		selectOut <= lessThanEq when "000",
					lessThan when "001",
					greaterThan when "010",
					greaterThanEqual when "011",
					equal when "100",
					notEqual when "101",
					'0' when others; --it should not get to this point

	output <= NBITm1zeroes & selectOut;
	
end architecture;
