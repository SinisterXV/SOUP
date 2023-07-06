library ieee;
use ieee.std_logic_1164.all;

package testbench_function is

    function to_string ( a: std_logic_vector) return string;
    function string_to_std_logic_vector(a : string) return std_logic_vector;

end testbench_function;

package body testbench_function is
    function string_to_std_logic_vector(a : string) return std_logic_vector is
        variable ret : std_logic_vector(a'length-1 downto 0);
    begin
        for i in 1 to a'length loop
            if a(i) = '0' then
                ret(a'length-i) := '0';
            else 
                ret(a'length-i) := '1';
            end if;
        end loop;
        return ret;
    end function string_to_std_logic_vector;

    function to_string ( a: std_logic_vector) return string is
        variable b : string (1 to a'length) := (others => NUL);
        variable stri : integer := 1; 
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
        stri := stri+1;
        end loop;
    return b;
    end function;
end testbench_function;
