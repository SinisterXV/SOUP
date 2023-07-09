library ieee;
use ieee.std_logic_1164.all;

entity T2_Logic_Unit is
    generic(
        operand_size: natural := 64
    );
    port(
        A: in  std_logic_vector(operand_size - 1 downto 0);
        B: in  std_logic_vector(operand_size - 1 downto 0);
        S: in  std_logic_vector(3 downto 0);
        Z: out std_logic_vector(operand_size - 1 downto 0)
    );
end entity T2_Logic_Unit;

-- The idea is to compute 
--
-- OUT = not(L0 & L1 & L2 & L3) = 
--     = ... = 
--     =   s0 & not(A) & not(B) +
--       + s1 & not(A) &     B  +
--       + s2 &     A  & not(B) +
--       + s3 &     A  &     B 
--
-- -------------------------------------------------
--
-- In this way, we can consider the following control signals.
--
-- operation | s3 | s2 | s1 | s0
-- ----------+----+----+----+----
--    and    | 1  | 0  | 0  | 0   
--    nand   | 0  | 1  | 1  | 1
--    or     | 1  | 1  | 1  | 0
--    nor    | 0  | 0  | 0  | 1
--    xor    | 0  | 1  | 1  | 0
--    xnor   | 1  | 0  | 0  | 1   

architecture dataflow of T2_Logic_Unit is

    signal S0, S1, S2, S3: std_logic_vector(operand_size - 1 downto 0); 
    signal L0, L1, L2, L3: std_logic_vector(operand_size - 1 downto 0);

begin

    -- Extensions of the control signal on operand_size bits
    S0 <= (others => S(0));
    S1 <= (others => S(1));
    S2 <= (others => S(2));
    S3 <= (others => S(3));

    L0 <= not (((not A) and (not B)) and S0);
    L1 <= not (((not A) and (    B)) and S1);
    L2 <= not (((    A) and (not B)) and S2);
    L3 <= not (((    A) and (    B)) and S3);

    Z  <= not (L0 and L1 and L2 and L3);

end architecture dataflow;