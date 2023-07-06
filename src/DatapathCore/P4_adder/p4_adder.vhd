library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity p4_adder is
  generic (
    nbit : integer := 32
  );
  port (
    a           : in    std_logic_vector(nbit - 1 downto 0);
    b           : in    std_logic_vector(nbit - 1 downto 0);
    sub_add_bar : in    std_logic;
    s           : out   std_logic_vector(nbit - 1 downto 0);
    cout        : out   std_logic
  );
end entity p4_adder;

architecture structural of p4_adder is

  component carry_generator is
    generic (
      nbit           : integer := 32;
      nbit_per_block : integer := 4
    );
    port (
      a   : in    std_logic_vector(nbit - 1 downto 0);
      b   : in    std_logic_vector(nbit - 1 downto 0);
      cin : in    std_logic;
      co  : out   std_logic_vector((nbit / nbit_per_block) downto 0)
    );
  end component;

  component sum_generator is
    generic (
      nbit_per_block : integer := 4;
      nblocks        : integer := 8
    );
    port (
      a  : in    std_logic_vector(nbit_per_block * nblocks - 1 downto 0);
      b  : in    std_logic_vector(nbit_per_block * nblocks - 1 downto 0);
      ci : in    std_logic_vector(nblocks - 1 downto 0);
      s  : out   std_logic_vector(nbit_per_block * nblocks - 1 downto 0)
    );
  end component;

  constant nbit_per_block_c : integer := 8;
  signal   carry            : std_logic_vector(nbit / nbit_per_block_c  downto 0);
  signal   b_sub_add        : std_logic_vector(nbit - 1 downto 0);

begin

  b_sub_add <= b when sub_add_bar = '0' else
               not(b);

  carry_g : component carry_generator
    generic map (
      nbit => nbit, nbit_per_block=> nbit_per_block_c
    )
    port map (
      a   => a,
      b   => b_sub_add,
      cin => sub_add_bar,
      co  => carry
    );

  sum_g : component sum_generator
    generic map (
      nbit_per_block => nbit_per_block_c, nblocks=> nbit / nbit_per_block_c
    )
    port map (
      a  => a,
      b  => b_sub_add,
      ci => carry(nbit / nbit_per_block_c - 1 downto 0),
      s  => s
    );

  cout <= carry(nbit / nbit_per_block_c);

end architecture structural;



