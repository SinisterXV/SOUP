library ieee; 
use ieee.std_logic_1164.all;

entity CSB is
	Generic(N: integer := 32);
	Port (A:	In	std_logic_vector(N-1 downto 0); --first operand
		  B:	In	std_logic_vector(N-1 downto 0); --second operand
		  Ci:	In	std_logic; --external carry, used as selection signal
		  S:	Out std_logic_vector(N-1 downto 0)); --output
end CSB;

architecture STRUCTURAL of CSB is
	component RCA is 
		Generic (N: INTEGER := 16);
		Port (A:	In	std_logic_vector(N-1 downto 0);
			  B:	In	std_logic_vector(N-1 downto 0);
			  Ci:	In	std_logic;
			  S:	Out	std_logic_vector(N-1 downto 0);
			  Co:	Out	std_logic);
	end component; 

	signal carry0_RCA_Output, carry1_RCA_Output: std_logic_vector(N-1 downto 0); --outputs of the RCAs: one for the RCA with carry_in = 0, one for the RCA with carry_in = 1
	signal carry0_RCA_Cout, carry1_RCA_Cout: std_logic; --dummy signals for the RCAs' carry outs
begin
	--instantiation of the RCA with carry_in = 0
	RCA_0: RCA generic map(N => N)
			   port map(A => A, B => B, Ci => '0', S => carry0_RCA_Output, Co => carry0_RCA_Cout);
			   
	--instantiation of the RCA with carry_in = 1
	RCA_1: RCA generic map(N => N)
			   port map(A => A, B => B, Ci => '1', S => carry1_RCA_Output, Co => carry1_RCA_Cout);
			   
	--output selection mux: if external carry_in = 0 then S = output of RCA_0, else S = output of RCA_1
	S <= carry0_RCA_Output when Ci = '0' else carry1_RCA_Output;

end STRUCTURAL;

configuration CFG_CSB_STRUCTURAL of CSB is
	for STRUCTURAL
		for all: RCA
			use configuration WORK.CFG_RCA_STRUCTURAL;
		end for;
	end for;
end CFG_CSB_STRUCTURAL;
