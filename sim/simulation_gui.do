# Suppress warnings and set 
quietly set StdArithNoWarnings 1
quietly set NumericStdNoWarnings 1
quietly set DefaultRadix hex

add wave -label CLK             sim:/tb_dlx/clk
add wave -label RST             sim:/tb_dlx/rst
add wave -label PC              sim:/tb_dlx/dlx_inst/dtpth/i_address
add wave -label OPCODE          sim:/tb_dlx/dlx_inst/dtpth/opcode
add wave -label RF              sim:/tb_dlx/dlx_inst/dtpth/rf/registers
add wave -label DRAM            sim:/tb_dlx/dlx_inst/dtpth/d_mem/dram_memory