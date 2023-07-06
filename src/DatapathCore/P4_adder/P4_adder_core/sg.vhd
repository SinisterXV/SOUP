library ieee; 
use ieee.std_logic_1164.all;


entity SUM_GENERATOR is
		generic (
			NBIT_PER_BLOCK: integer := 4;
			NBLOCKS:	integer := 8);
		port (
			A:	in	std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
			B:	in	std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
			Ci:	in	std_logic_vector(NBLOCKS-1 downto 0);
			S:	out	std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0));
end SUM_GENERATOR;


architecture structural of SUM_GENERATOR is

	component csb is 
	Generic(N: integer:=4);
	Port (A:	In	std_logic_vector(N-1 downto 0); 
		  B:	In	std_logic_vector(N-1 downto 0); 
		  Ci:	In	std_logic; 
		  S:	Out std_logic_vector(N-1 downto 0)); 

	end component;
	
begin
	--generate loop
	An: for i in 0 to NBLOCKS-1 generate
		
		CSB_i : csb 	generic map(N=>NBIT_PER_BLOCK)
						port map(A=>A( ((i+1)*NBIT_PER_BLOCK)-1 downto i*NBIT_PER_BLOCK), 
								 B=>B( ((i+1)*NBIT_PER_BLOCK)-1 downto i*NBIT_PER_BLOCK),
								 Ci=> Ci(i),
								 S=>S( ((i+1)*NBIT_PER_BLOCK)-1 downto i*NBIT_PER_BLOCK ));
		end generate;

end structural;



