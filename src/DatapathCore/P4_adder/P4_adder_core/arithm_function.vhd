library ieee;
use ieee.std_logic_1164.all;

package arithm_function is

    function log2floor(n : integer) return integer;
    function log2ceil(n : integer) return integer;

end arithm_function;

package body arithm_function is

    -- Computes the ceil of the log2 of a number
    function log2ceil (n : integer) return integer is
        variable m, p : integer;
    begin
        m := 0;
        p := 1;
        for i in 0 to n loop
            if p < n then
                m := m + 1;
                p := p * 2;
            end if;
        end loop;
        return m;
    end log2ceil;

    -- Computes the floor of the log2 of a number
    function log2floor (n : integer) return integer is
        variable m, p : integer;
    begin
        m := -1;
        p := 1;
        for i in 0 to n loop
            if p < n then
                m := m + 1;
                p := p * 2;
            end if;
        end loop;
        return m;
    end log2floor;

end arithm_function;
