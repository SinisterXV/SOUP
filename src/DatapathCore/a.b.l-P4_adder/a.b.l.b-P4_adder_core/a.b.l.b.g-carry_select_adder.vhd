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
begin
	--instantiation of the RCA with carry_in = 0
	RCA_0: RCA generic map(N => N)
			   port map(A => A, B => B, Ci => '0', S => carry0_RCA_Output, Co => open);
			   
	--instantiation of the RCA with carry_in = 1
	RCA_1: RCA generic map(N => N)
			   port map(A => A, B => B, Ci => '1', S => carry1_RCA_Output, Co => open);
			   
	--output selection mux: if external carry_in = 0 then S = output of RCA_0, else S = output of RCA_1
	S <= carry0_RCA_Output when Ci = '0' else carry1_RCA_Output;

end STRUCTURAL;
