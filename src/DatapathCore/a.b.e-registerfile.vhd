library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity register_file is
	generic(NBIT: integer := 32); --width of each register
	port(clk: 		in std_logic;
		reset: 		in std_logic;
        -- general enable of the rf
		enable: 	in std_logic;
        -- enable read from port 1
		rd1: 		in std_logic;
        -- enable read from port 2
		rd2: 		in std_logic;
        -- enable write
		wr: 		in std_logic;
        -- force the writing on port 31
		write31:    in std_logic;
        -- port 1 selection
		add_rd1: 	in std_logic_vector(4 downto 0);
        -- port 2 selection
		add_rd2: 	in std_logic_vector(4 downto 0);
        -- port write selection
		add_wr: 	in std_logic_vector(4 downto 0);
        -- output port 1 
		out1: 		out std_logic_vector(NBIT - 1 downto 0);
        -- output port 2 
		out2: 		out std_logic_vector(NBIT - 1 downto 0);
        -- data in for writing
		datain: 	in std_logic_vector(NBIT - 1 downto 0));
end register_file;

architecture a of register_file is
	subtype reg_addr is natural range 0 to 31; --allowed register addresses
	type reg_array is array(reg_addr) of std_logic_vector(NBIT - 1 downto 0); --register file type declaration

    signal not_clk: std_logic;
	signal registers: reg_array; --register file signal declaration
begin

    -- with this signal, the writing operation is performed on the falling edge
    -- of the clock. Using `falling_edge(clk)` was not an option since it
    -- was not synthesizable using our library
    not_clk <= not(clk);
    
    -- Read port 1
	readproc1: process(registers, enable, rd1, add_rd1)
	begin
		if((enable = '1') and (rd1 = '1')) then
			out1 <= registers(to_integer(unsigned(add_rd1)));
		end if;
	end process readproc1;

    -- Read port 2
	readproc2: process(registers, enable, rd2, add_rd2)
	begin
		if((enable = '1') and (rd2 = '1')) then
			out2 <= registers(to_integer(unsigned(add_rd2)));
		end if;
	end process readproc2; 


    -- Write operation
	writeproc: process(registers, reset, enable, wr, write31, add_wr, datain, not_clk)
	begin
		if(rising_edge(not_clk)) then
            -- synchronous reset
			if(reset = '1') then
				registers <= (others => (others => '0'));
            -- enable
			elsif((enable = '1') and (wr = '1')) then
                -- write31 is set
				if (write31 = '1') then
					registers(31) <= datain;
                -- we use the provided address
				elsif(unsigned(add_wr) /= 0) then --prevent writing to Regs[0]
					registers(to_integer(unsigned(add_wr))) <= datain;
				end if;
			end if;
		end if;
	end process writeproc;
end a;
