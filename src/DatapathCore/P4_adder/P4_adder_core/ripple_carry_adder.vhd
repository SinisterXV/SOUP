library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity RCA is 
	Generic(N: INTEGER := 16);
	Port(A:		In	std_logic_vector(N-1 downto 0);
		 B:		In	std_logic_vector(N-1 downto 0);
		 Ci:	In	std_logic;
		 S:		Out	std_logic_vector(N-1 downto 0);
		 Co:	Out	std_logic);
end RCA; 

architecture BEHAVIORAL of RCA is
	
	signal ATEMP: std_logic_vector(N downto 0);
	signal BTEMP: std_logic_vector(N downto 0);
	signal STEMP: std_logic_vector(N downto 0);

begin
  
  ATEMP <= '0' & A;
  BTEMP <= '0' & B;
  
  STEMP <= (ATEMP + BTEMP + Ci);
  
  S <= STEMP(N-1 downto 0);
  
  Co <= STEMP(N);
  
end BEHAVIORAL;
