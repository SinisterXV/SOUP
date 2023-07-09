# Suppress warnings and set 
quietly set StdArithNoWarnings 1
quietly set NumericStdNoWarnings 1
quietly set DefaultRadix hex

add wave -label CLK             sim:/tb_dlx/clk
add wave -label RST             sim:/tb_dlx/rst

add wave -label PC              sim:/tb_dlx/dlx_inst/dtpth/i_address
add wave -label OPCODE          sim:/tb_dlx/dlx_inst/cntrl/opcode
add wave -label RF              sim:/tb_dlx/dlx_inst/dtpth/rf/registers
add wave -label DRAM            sim:/tb_dlx/data_mem/dram_memory

add wave    -group FETCH    -label i_address    -color "light blue"    sim:/tb_dlx/dlx_inst/dtpth/i_address
add wave    -group FETCH    -label mem_inst_out -color "light blue"    sim:/tb_dlx/dlx_inst/dtpth/mem_instr_out

add wave    -group DECODE   -label rf_out_1     -color "yellow"        sim:/tb_dlx/dlx_inst/dtpth/rf_out1
add wave    -group DECODE   -label rf_out_2     -color "yellow"        sim:/tb_dlx/dlx_inst/dtpth/rf_out2
add wave    -group DECODE   -label se_out       -color "yellow"        sim:/tb_dlx/dlx_inst/dtpth/se_out
add wave    -group DECODE   -label ir_fd_out    -color "yellow"        sim:/tb_dlx/dlx_inst/dtpth/ir_fd_out
add wave    -group DECODE   -label npc_fd_out   -color "yellow"        sim:/tb_dlx/dlx_inst/dtpth/npc_fd_out

add wave    -group EXECUTE  -label op1_mux      -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/op1_mux
add wave    -group EXECUTE  -label op2_mux      -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/op2_mux
add wave    -group EXECUTE  -label add_carry    -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/add_carry
add wave    -group EXECUTE  -label add_result   -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/add_result
add wave    -group EXECUTE  -label cmp_result   -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/cmp_result
add wave    -group EXECUTE  -label shift_result -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/shift_result
add wave    -group EXECUTE  -label logic_result -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/logic_result
add wave    -group EXECUTE  -label mul_mux      -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/mul_mux
add wave    -group EXECUTE  -label div_mux      -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/div_mux
add wave    -group EXECUTE  -label exeout_mux   -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/exeout_mux
add wave    -group EXECUTE  -label npc_de_out   -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/npc_de_out
add wave    -group EXECUTE  -label zero_detect  -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/zero_detector_result
add wave    -group EXECUTE  -label ir_de_out    -color "pink"          sim:/tb_dlx/dlx_inst/dtpth/ir_de_out

add wave    -group MEMORY   -label next_pc      -color "green"         sim:/tb_dlx/dlx_inst/dtpth/next_pc
add wave    -group MEMORY   -label exout_em_out -color "green"         sim:/tb_dlx/dlx_inst/dtpth/exeout_em_out
add wave    -group MEMORY   -label b_em_out     -color "green"         sim:/tb_dlx/dlx_inst/dtpth/b_em_out

add wave    -group WBACK    -label npc_mw_out   -color "white"         sim:/tb_dlx/dlx_inst/dtpth/npc_mw_out
add wave    -group WBACK    -label exout_mw_out -color "white"         sim:/tb_dlx/dlx_inst/dtpth/exeout_mw_out
add wave    -group WBACK    -label lmd_mw_out   -color "white"         sim:/tb_dlx/dlx_inst/dtpth/lmd_mw_out
add wave    -group WBACK    -label rf_data_in   -color "white"         sim:/tb_dlx/dlx_inst/dtpth/rf_data_in