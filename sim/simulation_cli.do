# Suppress warnings and set 
quietly set StdArithNoWarnings 1
quietly set NumericStdNoWarnings 1
quietly set DefaultRadix dec
# Start simulation
puts "\n########## SIMULATION STARTS ##########"
run 1 us
puts "##########  SIMULATION ENDS  ##########\n"
# Select dump file
quietly set dump_file [open "dump_rf_dmem.dump" w]
puts "Dump of the register file..."
quietly set register_file_values [examine -radix d sim:/tb_dlx/dlx_inst/dtpth/rf/registers]
# puts $register_file_values
puts $dump_file "REGISTER FILE"
puts $dump_file $register_file_values 
puts $dump_file ""
puts "Dump of the DRAM..."
quietly set dram_values [examine -radix d sim:/tb_dlx/dlx_inst/dtpth/d_mem/dram_memory]
# puts $dram_values
puts $dump_file "DRAM"
puts $dump_file $dram_values
puts "Dump file `dump_rf_dmem.dump` has been generated"
exit