library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
	port
	(
		clk, rst            : in std_logic;
		control_word        : in std_logic_vector(34 downto 0);
		single_cycle_enable : in std_logic;
		opcode              : out std_logic_vector(5 downto 0);
		mul_done, div_done  : out std_logic
	);
end datapath;

architecture STRUCTURAL of datapath is
	constant NBIT        : integer                             := 32;
	constant NBIT_log    : integer                             := 5; --should be log2(NBIT)
	constant RAM_WIDTH   : integer                             := 8;
	constant nbit_zeroes : std_logic_vector(NBIT - 1 downto 0) := (others => '0');
	constant opcode_size : integer                             := 6;
	constant safe_cw     : std_logic_vector(30 downto 0)       := "0000000000000000000000100001000";

	subtype word_type is std_logic_vector(NBIT - 1 downto 0);

	--CONTROL WORD SIGNALS
	--DECODE STAGE
	signal rf_rd1                  : std_logic;
	signal rf_rd2                  : std_logic;
	signal se_signed_unsigned_bar  : std_logic;
	signal de_enable               : std_logic;

	--EXECUTE STAGE
	signal ex_sel_a                : std_logic;
	signal ex_sel_b                : std_logic;
	signal alu_sub_add_bar         : std_logic;
	signal alu_logic_sel           : std_logic_vector(3 downto 0);
	signal alu_shift_sel           : std_logic_vector(1 downto 0);
	signal mul_start               : std_logic;
	signal div_start               : std_logic;
	signal div_signed_unsigned_bar : std_logic;
	signal mul_sel_p               : std_logic;
	signal div_sel                 : std_logic;
	signal cmp_config              : std_logic_vector(2 downto 0);
	signal ex_sel_out              : std_logic_vector(2 downto 0);
	signal branch_eq_neq_bar       : std_logic;
	signal em_enable               : std_logic;

	--MEMORY STAGE
	signal mem_rd_wr_bar           : std_logic;
	signal mem_branch_enable       : std_logic;
	signal mem_perform_jump        : std_logic;
	signal mw_enable               : std_logic;

	--WRITEBACK STAGE
	signal wb_sel                  : std_logic_vector(1 downto 0);
	signal rf_sel_dest             : std_logic;
	signal rf_write31              : std_logic;
	signal rf_wr                   : std_logic;
	--INTERMEDIATE SIGNALS
	--FETCH STAGE
	signal next_pc                 : word_type;
	signal incr_pc                 : word_type;
	signal i_address               : word_type;
	signal mem_instr_out           : word_type;
	signal ir_fd_out               : word_type;
	signal npc_fd_out              : word_type;

	--DECODE STAGE
	signal next_jmpdest_de         : word_type;
	signal jmpdest_de_out          : word_type;
	signal rf_out1                 : word_type;
	signal rf_out2                 : word_type;
	signal rf_dest_mux             : std_logic_vector(4 downto 0);
	signal se_out                  : word_type;
	signal npc_de_out              : word_type;
	signal a_de_out                : word_type;
	signal b_de_out                : word_type;
	signal im_de_out               : word_type;
	signal ir_de_out               : word_type;

	--EXECUTION STAGE
	signal op1_mux                 : word_type;
	signal op2_mux                 : word_type;
	signal add_carry               : std_logic;
	signal add_result              : word_type;
	signal logic_result            : word_type;
	signal shift_result            : word_type;
	signal mul_p                   : std_logic_vector(2 * NBIT - 1 downto 0);
	signal mul_p_high              : word_type;
	signal mul_p_low               : word_type;
	signal div_quot                : word_type;
	signal div_rem                 : word_type;
	signal cmp_result              : word_type;
	signal mul_mux                 : word_type;
	signal div_mux                 : word_type;
	signal exeout_mux              : word_type;
	signal zero_detector_result    : std_logic;
	signal jmpdest_em_out          : word_type;
	signal cond_out                : std_logic;
	signal npc_em_out              : word_type;
	signal exeout_em_out           : word_type;
	signal b_em_out                : word_type;
	signal ir_em_out               : word_type;

	--MEMORY STAGE
	signal jmp_mux                 : word_type;
	signal mem_data_out            : word_type;
	signal npc_mw_out              : word_type;
	signal exeout_mw_out           : word_type;
	signal lmd_mw_out              : word_type;
	signal ir_mw_out               : word_type;

	--WRITEBACK STAGE
	signal rf_data_in              : word_type;

	--CONTROL WORD REGISTERS
	signal cw_de_out               : std_logic_vector(30 downto 0);
	signal cw_em_out               : std_logic_vector(8 downto 0);
	signal cw_mw_out               : std_logic_vector(4 downto 0);
begin
	--CONTROL WORD DECOMPOSITION
	--DECODE STAGE
	rf_rd1                  <= control_word(34);
	rf_rd2                  <= control_word(33);
	se_signed_unsigned_bar  <= control_word(32);
	de_enable               <= control_word(31);

	--EXECUTION STAGE
	ex_sel_a                <= cw_de_out(30);
	ex_sel_b                <= cw_de_out(29);
	alu_sub_add_bar         <= cw_de_out(28);
	alu_logic_sel           <= cw_de_out(27 downto 24);
	alu_shift_sel           <= cw_de_out(23 downto 22);
	mul_start               <= cw_de_out(21);
	div_start               <= cw_de_out(20);
	div_signed_unsigned_bar <= cw_de_out(19);
	div_sel                 <= cw_de_out(18);
	mul_sel_p               <= cw_de_out(17);
	cmp_config              <= cw_de_out(16 downto 14);
	ex_sel_out              <= cw_de_out(13 downto 11);
	branch_eq_neq_bar       <= cw_de_out(10);
	em_enable               <= cw_de_out(9);

	--MEMORY STAGE
	mem_rd_wr_bar           <= cw_em_out(8);
	mem_branch_enable       <= cw_em_out(7);
	mem_perform_jump        <= cw_em_out(6);
	mw_enable               <= cw_em_out(5);

	--WRITEBACK STAGE
	wb_sel                  <= cw_mw_out(4 downto 3);
	rf_sel_dest             <= cw_mw_out(2);
	rf_write31              <= cw_mw_out(1);
	rf_wr                   <= cw_mw_out(0);

	--FETCH STAGE COMPONENTS
	pc : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port map
		(
			clk      => clk,
			rst      => rst,
			data_in  => next_pc,
			enable   => single_cycle_enable,
			data_out => i_address
		);

	i_mem : entity work.IRAM
		generic map(
			RAM_DEPTH => 64,
			I_SIZE    => NBIT
		)
		port
		map (
		Rst  => Rst,
		Addr => i_address,
		Dout => mem_instr_out
		);

	opcode  <= mem_instr_out(NBIT - 1 downto NBIT - opcode_size);

	incr_pc <= std_logic_vector(unsigned(i_address) + 1);

	--F/D REGISTERS
	ir_fd : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => mem_instr_out,
		enable   => single_cycle_enable,
		data_out => ir_fd_out
		);

	npc_fd : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => incr_pc,
		enable   => single_cycle_enable,
		data_out => npc_fd_out
		);

	--DECODE STAGE COMPONENTS
	next_jmpdest_de <= npc_fd_out(NBIT - 1 downto NBIT - 4) & ir_fd_out(25 downto 0) & "00";

	rf_dest_mux     <= ir_mw_out(20 downto 16) when (rf_sel_dest = '0') else
		ir_mw_out(15 downto 11);

	rf : entity work.register_file
		generic map(
			NBIT => NBIT
		)
		port
		map (
		clk     => clk,
		reset   => rst,
		enable  => '1',
		rd1     => rf_rd1,
		rd2     => rf_rd2,
		wr      => rf_wr,
		write31 => rf_write31,
		add_rd1 => ir_fd_out(25 downto 21),
		add_rd2 => ir_fd_out(20 downto 16),
		add_wr  => rf_dest_mux,
		out1    => rf_out1,
		out2    => rf_out2,
		datain  => rf_data_in
		);

	se : entity work.sign_extender
		port
		map (
		immediate           => ir_fd_out(15 downto 0),
		signed_unsigned_bar => se_signed_unsigned_bar,
		result              => se_out
		);

	--D/E REGISTERS
	jmpdest_de : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => next_jmpdest_de,
		enable   => de_enable,
		data_out => jmpdest_de_out
		);

	npc_de : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => npc_fd_out,
		enable   => de_enable,
		data_out => npc_de_out
		);

	a_de : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => rf_out1,
		enable   => de_enable,
		data_out => a_de_out
		);

	b_de : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => rf_out2,
		enable   => de_enable,
		data_out => b_de_out
		);

	imm_de : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => se_out,
		enable   => de_enable,
		data_out => im_de_out
		);

	ir_de : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => ir_fd_out,
		enable   => de_enable,
		data_out => ir_de_out
		);

	--EXECUTION STAGE COMPONENTS
	zd : entity work.zero_detector
		generic map(
			NBIT => NBIT
		)
		port
		map (
		data              => a_de_out,
		branch_eq_neq_bar => branch_eq_neq_bar,
		result_detection  => zero_detector_result
		);

	op1_mux <= npc_de_out when (ex_sel_a = '0') else
		a_de_out;

	op2_mux <= b_de_out when (ex_sel_b = '0') else
		im_de_out;

	p4_add : entity work.p4_adder
		generic map(
			nbit => NBIT
		)
		port
		map (
		a           => op1_mux,
		b           => op2_mux,
		sub_add_bar => alu_sub_add_bar,
		s           => add_result,
		cout        => add_carry
		);

	logic_unit : entity work.T2_Logic_Unit
		generic map(
			operand_size => NBIT
		)
		port
		map (
		A => op1_mux,
		B => op2_mux,
		S => alu_logic_sel,
		Z => logic_result
		);

	shifter : entity work.T2_shifter_generic
		generic map(
			Nbit => NBIT_log,
			N    => NBIT
		)
		port
		map (
		R1     => op1_mux,
		R2     => op2_mux(4 downto 0),
		conf   => alu_shift_sel,
		Result => shift_result
		);

	booth_multiplier : entity work.boothMul
		generic map(
			NBIT => NBIT
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		startMul => mul_start,
		A        => op1_mux,
		B        => op2_mux,
		P        => mul_p,
		doneMul  => mul_done
		);

	mul_p_high <= mul_p(NBIT * 2 - 1 downto NBIT);
	mul_p_low  <= mul_p(NBIT - 1 downto 0);

	srt_radix4_divisor : entity work.radix4_SRTDivider_toplevel
		generic map(
			NBIT => NBIT
		)
		port
		map (
		clk               => clk,
		rst               => rst,
		startsdiv         => div_start,
		signedunsignedbar => div_signed_unsigned_bar,
		dividend          => op1_mux,
		divisor           => op2_mux,
		donesdiv          => div_done,
		dividedbyzeroflag => open,
		qout              => div_quot,
		remout            => div_rem
		);

	mul_mux <= mul_p_low when (mul_sel_p = '0') else
		mul_p_high;

	div_mux <= div_rem when (div_sel = '0') else
		div_quot;

	cmp : entity work.comparator
		generic map(
			NBIT => NBIT
		)
		port
		map (
		cout   => add_carry,
		sum    => add_result,
		config => cmp_config,
		output => cmp_result
		);

	exeout_mux <= cmp_result when (ex_sel_out = "000") else
		add_result when (ex_sel_out = "001") else
		logic_result when (ex_sel_out = "010") else
		shift_result when (ex_sel_out = "011") else
		mul_mux when (ex_sel_out = "100") else
		div_mux when (ex_sel_out = "101") else
		nbit_zeroes;

	--E/M REGISTERS
	jmpdest_em : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => jmpdest_de_out,
		enable   => em_enable,
		data_out => jmpdest_em_out
		);

	cond : entity work.pipeRegisterOneBit
		generic map(
			reset_value => '0'
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => zero_detector_result,
		enable   => em_enable,
		data_out => cond_out
		);

	npc_em : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => npc_de_out,
		enable   => em_enable,
		data_out => npc_em_out
		);

	exeout_em : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => exeout_mux,
		enable   => em_enable,
		data_out => exeout_em_out
		);

	b_em : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => b_de_out,
		enable   => em_enable,
		data_out => b_em_out
		);

	ir_em : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => ir_de_out,
		enable   => em_enable,
		data_out => ir_em_out
		);

	--MEMORY STAGE COMPONENTS
	jmp_mux <= exeout_em_out when ((cond_out and mem_branch_enable) = '1') else
		incr_pc;

	next_pc <= jmp_mux when (mem_perform_jump = '0') else
		jmpdest_em_out;

	d_mem : entity work.DRAM
		generic map(
			RAM_WIDTH  => RAM_WIDTH,
			WORD_WIDTH => NBIT
		)
		port
		map (
		rst    => rst,
		clk    => clk,
		rw_bar => mem_rd_wr_bar,
		addr   => exeout_em_out(RAM_WIDTH - 1 downto 0),
		d_in   => b_em_out,
		d_out  => mem_data_out
		);

	--M/W REGISTERS
	npc_mw : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => npc_em_out,
		enable   => mw_enable,
		data_out => npc_mw_out
		);

	exeout_mw : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => exeout_em_out,
		enable   => mw_enable,
		data_out => exeout_mw_out
		);

	lmd_mw : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => mem_data_out,
		enable   => mw_enable,
		data_out => lmd_mw_out
		);

	ir_mw : entity work.pipeRegister
		generic map(
			NBIT        => NBIT,
			reset_value => nbit_zeroes
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => ir_em_out,
		enable   => mw_enable,
		data_out => ir_mw_out
		);

	--WRITEBACK COMPONENTS
	rf_data_in <= npc_mw_out when (wb_sel = "00") else
		exeout_mw_out when (wb_sel = "01") else
		lmd_mw_out when (wb_sel = "10") else
		nbit_zeroes;
	
	--CONTROL WORD REGISTERS
	cw_de : entity work.pipeRegister
		generic map(
			NBIT        => 31,
			reset_value => safe_cw(30 downto 0)
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => control_word(30 downto 0),
		enable   => single_cycle_enable,
		data_out => cw_de_out
		);

	cw_em : entity work.pipeRegister
		generic map(
			NBIT        => 9,
			reset_value => safe_cw(8 downto 0)
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => cw_de_out(8 downto 0),
		enable   => single_cycle_enable,
		data_out => cw_em_out
		);

	cw_mw : entity work.pipeRegister
		generic map(
			NBIT        => 5,
			reset_value => safe_cw(4 downto 0)
		)
		port
		map (
		clk      => clk,
		rst      => rst,
		data_in  => cw_em_out(4 downto 0),
		enable   => single_cycle_enable,
		data_out => cw_mw_out
		);

end architecture;
