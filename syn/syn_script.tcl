##############################################################
# Analyse compilation list
##############################################################
set list_file [open "dlx_compile_sources.f" r]
while {[gets $list_file line] >= 0} {
    set exit_code [analyze -library WORK -format vhdl $line]
    if {$exit_code == 0} {
        puts "error while analysing $line"
        exit
    }
}

##############################################################
# Elaborate the dlx entity
##############################################################
elaborate dlx -update -library WORK 

##############################################################
# Set wire model
##############################################################
set_wire_load_model -name 5K_hvratio_1_4

##############################################################
# Create clock signal
##############################################################
set timing_constraint_ns 7
create_clock -name "clk" -period $timing_constraint_ns clk
report_clock
set_fix_hold "clk"

##############################################################
# Set combinatiorial timing constraints
##############################################################
set_max_delay $timing_constraint_ns -from [all_inputs] -to [all_outputs] 

##############################################################
# Compile the structure
##############################################################
compile -map_effort high

##############################################################
# Generate reports 
##############################################################

report_timing > ./reports/dlx_timing_report.rpt
report_power > ./reports/dlx_power_report.rpt
report_area > ./reports/dlx_area_report.rpt

write_sdc "./sdc/dlx_constraints.sdc"

##############################################################
# Generate post-synthesis netlist
##############################################################
write -hierarchy -format verilog -output ./netlist/dlx_postsyn_netlist.v
