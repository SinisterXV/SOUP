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

architecture STRUCTURAL of RCA is

  signal STMP : std_logic_vector(N-1 downto 0);
  signal CTMP : std_logic_vector(N downto 0);

  component FA 
	  Port(A:	In	std_logic;
		   B:	In	std_logic;
		   Ci:	In	std_logic;
		   S:	Out	std_logic;
		   Co:	Out	std_logic);
  end component; 

begin

  CTMP(0) <= Ci;
  S <= STMP;
  Co <= CTMP(N);
  
  ADDER1: for I in 1 to N generate
    FAI : FA  
	  Port Map (A(I-1), B(I-1), CTMP(I-1), STMP(I-1), CTMP(I)); 
  end generate;

end STRUCTURAL;


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

configuration CFG_RCA_STRUCTURAL of RCA is
  for STRUCTURAL 
    for ADDER1
      for all : FA
        use configuration WORK.CFG_FA_BEHAVIORAL;
      end for;
    end for;
  end for;
end CFG_RCA_STRUCTURAL;

configuration CFG_RCA_BEHAVIORAL of RCA is
  for BEHAVIORAL 
  end for;
end CFG_RCA_BEHAVIORAL;
