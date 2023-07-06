library ieee;
  use ieee.std_logic_1164.all;
  use work.arithm_function.all;

entity carry_generator is
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
end entity carry_generator;

architecture structural of carry_generator is

  component gblock is
    port (
      gl   : in    std_logic;
      pl   : in    std_logic;
      gr   : in    std_logic;
      gout : out   std_logic
    );
  end component gblock;

  component pgblock is
    port (
      gl   : in    std_logic;
      pl   : in    std_logic;
      gr   : in    std_logic;
      pr   : in    std_logic;
      gout : out   std_logic;
      pout : out   std_logic
    );
  end component pgblock;

  component pgnetwork is
    generic (
      nbit : natural := 32
    );
    port (
      a    : in    std_logic_vector(nbit - 1 downto 0);
      b    : in    std_logic_vector(nbit - 1 downto 0);
      cin  : in    std_logic;
      pout : out   std_logic_vector(nbit - 1 downto 0);
      gout : out   std_logic_vector(nbit - 1 downto 0)
    );
  end component pgnetwork;

  constant iterationsstep1 : integer := log2ceil(nbit_per_block);
  constant iterationsstep2 : integer := log2ceil(nbit / nbit_per_block);
  constant rows            : integer := log2ceil(nbit) + 1;

  -- Declaration of two matrixes, one for the p values and one
  -- for the g values of each block.

  type signalmatrix_type is array(rows - 1 downto 0) of
                              std_logic_vector(nbit - 1 downto 0);

  signal matrixp, matrixg : signalmatrix_type;

begin

  -- The carry generator is made of three parts:
  -- 0. In the initial step, we simply use the PGNetwork circuit to generate all the p
  --    and g to start the algorithm. It corresponds to the first row of the matrix
  -- 1. In this first part, we instantiate PG and G blocks combining in pairs
  --    elements of the previous row, until we have AS MUCH ELEMENTS AS THE CARRIES
  --    TO GENERATE. This means that we need log2(NBIT_PER_BLOCK) levels.
  -- 2. In this second part, we instantiate PG and G block until we have generated
  --    all the blocks we need. In the end, we have lgo2(NBIT/NBIT_PER_BLOCK) levels.
  --    The expressions for the generic interconnection between the blocks can be
  --    seen below.

  pgnetwork_instance : component pgnetwork
    generic map (
      nbit => nbit
    )
    port map (
      a    => a,
      b    => b,
      cin  => cin,
      pout => matrixp(0),
      gout => matrixg(0)
    );

  co(0) <= cin;

  co(1) <= matrixg(iterationsstep1)((2 ** iterationsstep1) - 1);

  -- We iterate over all the rows of the first part

  g1_outer : for i in 1 to iterationsstep1 generate

    -- For each row, we need to instantiate NBIT/2**i elements

    g1_inner : for j in 1 to nbit / 2 ** i generate

      -- If j==1, we are on the first block, which is always a G

      g1_gblock : if j = 1 generate

        g_elem : component gblock
          port map (
            gl   => matrixg(i - 1)(j * (2 ** i) - 1),

            pl   => matrixp(i - 1)(j * (2 ** i) - 1),

            gr   => matrixg(i - 1)(j * (2 ** i) - 1 - (2 ** (i - 1))),

            gout => matrixg(i)(j * (2 ** i) - 1)
          );

      end generate g1_gblock;

      g1_pgblock : if j /= 1 generate

        pg_elem : component pgblock
          port map (
            gl   => matrixg(i - 1)(j * (2 ** i) - 1),

            pl   => matrixp(i - 1)(j * (2 ** i) - 1),

            gr   => matrixg(i - 1)(j * (2 ** i) - 1 - (2 ** (i - 1))),
            
            pr   => matrixp(i - 1)(j * (2 ** i) - 1 - (2 ** (i - 1))),

            gout => matrixg(i)(j * (2 ** i) - 1),

            pout => matrixp(i)(j * (2 ** i) - 1)
          );

      end generate g1_pgblock;

    end generate g1_inner;

  end generate g1_outer;

  -- We iterate over all the rows of the second part

  g2_outer : for i in 1 to iterationsstep2 generate

    -- We divide the row in NBIT/(NBIT_PER_BLOCK*(2**(i-1)) consequent blocks.
    -- When j is even we put 2**(i-1) blocks, otherwise we skip

    g2_inner : for j in 1 to nbit / (nbit_per_block * (2 ** (i - 1))) generate

      g2_skipempty : if j mod 2 = 1 generate

        -- We put 2**(i-1) blocks. If j==1, these blocks are G-type, and they
        -- are connected to the carries.

        g2_group : for k in 1 to 2 ** (i - 1) generate

          g2_gblock : if j = 1 generate

            g_elem : component gblock
              port map (
                gl   => matrixg(iterationsstep1 + log2ceil(k))
                                           (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1),

                pl   => matrixp(iterationsstep1 + log2ceil(k))
                                           (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1),

                gr   => matrixg(i + iterationsstep1 - 1)
                                           (j * (2 ** (iterationsstep1 + i - 1)) - 1),

                gout => matrixg(i + iterationsstep1)
                                           (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1)
              );

            co(2 ** (i - 1) + k) <= matrixg(i + iterationsstep1)
                                    (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1);

          end generate g2_gblock;

          g2_gpblock : if j/= 1 generate

            pg_elem : component pgblock
              port map (
                gl   => matrixg(iterationsstep1 + log2ceil(k))
                                           (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1),

                pl   => matrixp(iterationsstep1 + log2ceil(k))
                                           (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1),

                gr   => matrixg(i + iterationsstep1 - 1)
                                           (j * (2 ** (iterationsstep1 + i - 1)) - 1),

                pr   => matrixp(i + iterationsstep1 - 1)
                                           (j * (2 ** (iterationsstep1 + i - 1)) - 1),

                gout => matrixg(i + iterationsstep1)
                                           (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1),

                pout => matrixp(i + iterationsstep1)
                                           (nbit_per_block * (j * (2 ** (i - 1)) + k) - 1)

              );

          end generate g2_gpblock;

        end generate g2_group;

      end generate g2_skipempty;

    end generate g2_inner;

  end generate g2_outer;

end architecture structural;
