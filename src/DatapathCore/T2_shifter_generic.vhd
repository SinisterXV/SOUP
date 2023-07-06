library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Generic shifter on N bit (where N is a power of 2)
-- Nbit is the log2(N)
entity T2_shifter_generic is
    generic(
        Nbit: integer := 6;
        N:    integer := 64
    );
    port(
        -- Value to shift
        R1:     in  std_logic_vector(N - 1    downto 0);
        -- Amount to shift
        R2:     in  std_logic_vector(Nbit - 1 downto 0);
        -- Configuration input (L/A, L/R)
        conf:   in  std_logic_vector(1        downto 0);
        -- Result
        Result: out std_logic_vector(N - 1    downto 0)
    );  
end entity T2_shifter_generic;

-- The shift is performed by three successive approximation:
-- 1:
--      We build N/8 masks, each made of N + 7 bits.
-- 2: 
--      We select a proper mask depending on R2 (MSB)
-- 3:  
--      We shift the selected mask according to R2 (LSB)
architecture behavioural of T2_shifter_generic is

    -----------------------
    -- Constant declaration
    -----------------------

    -- Length of a mask
	constant mask_length: integer := N+7;
    -- Number of masks
	constant mask_number: integer := N/8;
    
    -----------------------
    -- Type declaration
    -----------------------

    -- Type of shift
    type shift_operation_type is (arithmetic, logical);
    -- Direction of shift
    type direction_type is (left, right);
    -- Subtype for mask
    subtype mask_type is std_logic_vector(mask_length - 1 downto 0);
    -- Type for array of masks
    type mask_array_type is array (mask_number - 1 downto 0) of mask_type;

    -----------------------
    -- Signal declaration
    -----------------------

    -- Signal for direction of shift    
    signal shift_direction: direction_type; 
    -- Signal for shift operation
    signal shift_operation: shift_operation_type;
    -- Signal for amount of shift
    signal shift_amount: unsigned(2 downto 0);
    -- Signal for the data to fill result after shifting
    signal shift_fill: std_logic_vector(N - 1 downto 0);
    -- Signal for the selection of the proper mask
    signal shift_mask_selection: unsigned(Nbit - 1 downto 3);
    -- Signal for the array of masks
    signal shift_mask: mask_array_type;
    -- Signal for the selected mask
    signal selected_mask : mask_type;

begin
    
    -- Set direction
    shift_direction <= left when conf(0) = '0' else 
                       right;

    -- Set shift type
    shift_operation <= logical when conf(1) = '0' else 
                       arithmetic;

    -- Set shift_amount depending on direction and R2 
    shift_amount <= unsigned(R2(2 downto 0)) when shift_direction = right else 
                    unsigned(not(R2(2 downto 0)));

    -- Set shift_mask_selection depending on R2
    shift_mask_selection <= unsigned(R2(Nbit - 1 downto 3));

    -- Set shift_fill depending on direction and operation
    shift_fill <= (others => R1(N - 1)) when shift_direction = right and shift_operation = arithmetic 
                  else (others => '0');
    
    -- Generation of the masks depending on the operation and the direction
    maskGeneration: process(R1, shift_fill, shift_direction)   
        -- How many bits to delete
        variable del_bits : integer;
    begin 
        if shift_direction = left then
            for i in 0 to mask_number - 1 loop
                del_bits := 8 * i;
                -- If it's left, we set the i-th mask as the MSB of R1 & part of the fill
                shift_mask(i) <= R1(N - 1 - del_bits downto 0) &
                                 shift_fill(6 + del_bits downto 0);
            end loop;
        else
            for i in 0 to mask_number - 1 loop
                del_bits := 8 * i;
                -- If it's right, we set the i-th mask as part of the fill & the MSB of R1
                shift_mask(i) <= shift_fill(6 + del_bits downto 0) &
                                 R1(N - 1 downto del_bits);
            end loop;
        end if;
    end process maskGeneration;
    
    -- Selection of the correct mask
    maskSelection: process(shift_mask, shift_mask_selection)
    begin
        selected_mask <= shift_mask(to_integer(shift_mask_selection));
    end process maskSelection;
    
    -- Compute the result of the shift operation
    shiftResult: process(selected_mask, shift_amount)
    begin
        Result <= selected_mask(N - 1 + to_integer(shift_amount) downto to_integer(shift_amount));
    end process shiftResult;

end architecture behavioural;
