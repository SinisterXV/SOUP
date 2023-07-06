library ieee;
use ieee.std_logic_1164.all;

entity radix4_SRTDivider_toplevel is
	Generic(NBIT: integer := 32);
	Port(clk: 				in  std_logic;
		 rst: 				in  std_logic;
		 startsdiv: 		in  std_logic;
		 signedunsignedbar: in  std_logic;
		 dividend: 			in  std_logic_vector (NBIT - 1 downto 0);
		 divisor: 			in  std_logic_vector (NBIT - 1 downto 0);
		 donesdiv: 			out std_logic;
		 dividedbyzeroflag: out std_logic; --actually represents if the operands are invalid (also includes division by 0)
		 qout: 				out std_logic_vector (NBIT - 1 downto 0);
		 remout: 			out std_logic_vector (NBIT - 1 downto 0));
end radix4_SRTDivider_toplevel;

architecture STRUCTURAL of radix4_SRTDivider_toplevel is
	component SRTWrapper is
		Generic(NBIT: integer := 32);
		Port(clk, rst: 		   	in  std_logic;
			dividend: 		   	in  std_logic_vector(NBIT - 1 downto 0);
			divisor: 		   	in  std_logic_vector(NBIT - 1 downto 0);
			startDiv:			in  std_logic;
			signedUnsignedbar:  in  std_logic; --if 0, dividend is unsigned, else it's signed
			negResult_ld:	   	in  std_logic;
			shift_amount_ld: 	in  std_logic;
			A_ld: 	  			in  std_logic;
			sel_A:	  		    in  std_logic_vector(1 downto 0);
			B_ld:	  			in  std_logic;
			Q_rst:				in  std_logic;
			Q_ld:	  			in  std_logic;
			correct_s: 			in  std_logic;
			quotient:   	   	out std_logic_vector(NBIT - 1 downto 0);
			remainder:  	   	out std_logic_vector(NBIT - 1 downto 0);
			invalid_division: 	out std_logic;
			A_MSB:	  			out std_logic);
	end component;

	component SRTController is
		Generic(NBIT: integer := 32);
			Port(clk, rst:  	  in  std_logic;
				startDiv:  	      in  std_logic;
				invalid_division: in  std_logic;
				A_MSB:	  		  in  std_logic;
				doneDiv:   	      out std_logic;
				negResult_ld:	  out std_logic;
				shift_amount_ld:  out std_logic;
				A_ld: 	  		  out std_logic;
				sel_A:	  		  out std_logic_vector(1 downto 0);
				B_ld:	  		  out std_logic;
				Q_rst:  		  out std_logic;
				Q_ld:	  		  out std_logic;
				correct_s: 	      out std_logic);
	end component;

    signal negResult_ld_s, shift_amount_ld_s, A_MSB_s, A_ld_s, B_ld_s, Q_rst_s, Q_ld_s, correct_s_s, invalid_division_s: std_logic;
    signal sel_A_s: std_logic_vector(1 downto 0);
begin
	SRTController_1: SRTController
		Generic Map (NBIT => NBIT) 
		Port Map (
			clk              => clk,
			rst              => rst,
			startDiv         => startsdiv,
			invalid_division => invalid_division_s,
			A_MSB            => A_MSB_s,
			doneDiv          => donesdiv,
			negResult_ld     => negResult_ld_s,
			shift_amount_ld  => shift_amount_ld_s,
			A_ld             => A_ld_s,
			sel_A            => sel_A_s,
			B_ld             => B_ld_s,
			Q_rst            => Q_rst_s,
			Q_ld             => Q_ld_s,
			correct_s        => correct_s_s
		);

	SRTWrapper_1: SRTWrapper
		Generic Map (NBIT => NBIT)
		Port Map (
			clk               => clk,
			rst               => rst,
			dividend          => dividend,
			divisor           => divisor,
			startDiv		  => startsdiv,
			signedUnsignedbar => signedUnsignedbar,
			negResult_ld      => negResult_ld_s,
			shift_amount_ld   => shift_amount_ld_s,
			A_ld              => A_ld_s,
			sel_A             => sel_A_s,
			B_ld              => B_ld_s,
			Q_rst             => Q_rst_s,
			Q_ld              => Q_ld_s,
			correct_s         => correct_s_s,
			quotient          => qout,
			remainder         => remout,
			invalid_division  => invalid_division_s,
			A_MSB             => A_MSB_s
    );

  	dividedbyzeroflag <= invalid_division_s;
end architecture;