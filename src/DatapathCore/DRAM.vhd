library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

-- Data memory for DLX
-- Memory filled by a process which reads from a file
-- file name is "data.mem"
-- THe file has one line per word (w**RAM_WIDTH words)
-- Lines are expressed in hex format
entity DRAM is
    generic (
        RAM_WIDTH : integer := 4;
        WORD_WIDTH : integer := 8);
    port (
        rst    : in  std_logic;
        clk    : in  std_logic;
        rw_bar : in  std_logic;
        addr   : in  std_logic_vector(RAM_WIDTH - 1 downto 0);
        d_in   : in  std_logic_vector(WORD_WIDTH - 1 downto 0);
        d_out  : out std_logic_vector(WORD_WIDTH - 1 downto 0)
    );

end DRAM;

architecture behavioral of DRAM is

    subtype word_type is std_logic_vector(WORD_WIDTH - 1 downto 0);
    type dram_type is array ((2 ** RAM_WIDTH) - 1 downto 0) of word_type;

    signal dram_memory : dram_type;

 begin

    -- combinational process in charge of reading the dram 
    read_dram: process(addr, rw_bar, rst)
    begin
        if ((rw_bar = '1') and (rst = '0')) then
            d_out <= dram_memory(to_integer(unsigned(addr)));
        end if;
    end process read_dram;

    -- Process in charge of filling the dram @rst or to modify it @posedge_clock
    write_dram: process (Rst, clk, rw_bar, addr, d_in)
        file mem_fp: text;
        variable file_line : line;
        variable index : integer := 0;
        variable tmp_data_u : word_type;
    begin 
        if (rst = '1') then
            file_open(mem_fp,"data.mem",READ_MODE);
            read_file : for index in 0 to (2**RAM_WIDTH - 1) loop
                -- read one line and put it into file_line
                readline(mem_fp,file_line);
                -- convert text line into a std_logic_vector
                hread(file_line,tmp_data_u);
                -- write the memory
                dram_memory(index) <= std_logic_vector(unsigned(tmp_data_u));       
                -- next index
            end loop read_file;
            file_close(mem_fp);
        else
            if rising_edge(clk) and rw_bar = '0' then
                dram_memory(to_integer(unsigned(addr))) <= d_in;
            end if;
        end if;
  end process write_dram;

end behavioral;
