library ieee;
use ieee.std_logic_1164.all;

-- This zero_detector is used to implement branches. Branches can be
-- done either if a value is zero of if it is different from zero.
-- If branch_eq_neq_bar is '0', then we output '1' in case data is not zero;
-- If branch_eq_neq_bar is '1', then we output '1' in case data is zero;
-- In all the other cases, the output is 0.
entity zero_detector is
    generic (
        NBIT: integer := 32
    );
    port(
        data:               in std_logic_vector(NBIT - 1 downto 0);
        branch_eq_neq_bar : in std_logic;
        result_detection:   out std_logic 
    );
end entity zero_detector;

architecture behavioral of zero_detector is
    signal comparison : std_logic_vector(NBIT - 1 downto 0) := (others => '0');
begin
    compute_result: process(data, branch_eq_neq_bar) 
    begin
        if branch_eq_neq_bar = '1' and data = comparison then
            result_detection <= '1';
        elsif branch_eq_neq_bar = '0' and data /= comparison then
            result_detection <= '1';
        else
            result_detection <= '0';
        end if;
    end process compute_result;
end architecture behavioral;