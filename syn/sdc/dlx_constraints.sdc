###################################################################

# Created by write_sdc on Sun Jul  9 17:49:54 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_wire_load_model -name 5K_hvratio_1_4 -library NangateOpenCellLibrary
create_clock [get_ports clk]  -period 7  -waveform {0 3.5}
set_max_delay 7  -from [list [get_ports clk] [get_ports rst] [get_ports {iram_out[31]}]        \
[get_ports {iram_out[30]}] [get_ports {iram_out[29]}] [get_ports               \
{iram_out[28]}] [get_ports {iram_out[27]}] [get_ports {iram_out[26]}]          \
[get_ports {iram_out[25]}] [get_ports {iram_out[24]}] [get_ports               \
{iram_out[23]}] [get_ports {iram_out[22]}] [get_ports {iram_out[21]}]          \
[get_ports {iram_out[20]}] [get_ports {iram_out[19]}] [get_ports               \
{iram_out[18]}] [get_ports {iram_out[17]}] [get_ports {iram_out[16]}]          \
[get_ports {iram_out[15]}] [get_ports {iram_out[14]}] [get_ports               \
{iram_out[13]}] [get_ports {iram_out[12]}] [get_ports {iram_out[11]}]          \
[get_ports {iram_out[10]}] [get_ports {iram_out[9]}] [get_ports {iram_out[8]}] \
[get_ports {iram_out[7]}] [get_ports {iram_out[6]}] [get_ports {iram_out[5]}]  \
[get_ports {iram_out[4]}] [get_ports {iram_out[3]}] [get_ports {iram_out[2]}]  \
[get_ports {iram_out[1]}] [get_ports {iram_out[0]}] [get_ports {dram_out[31]}] \
[get_ports {dram_out[30]}] [get_ports {dram_out[29]}] [get_ports               \
{dram_out[28]}] [get_ports {dram_out[27]}] [get_ports {dram_out[26]}]          \
[get_ports {dram_out[25]}] [get_ports {dram_out[24]}] [get_ports               \
{dram_out[23]}] [get_ports {dram_out[22]}] [get_ports {dram_out[21]}]          \
[get_ports {dram_out[20]}] [get_ports {dram_out[19]}] [get_ports               \
{dram_out[18]}] [get_ports {dram_out[17]}] [get_ports {dram_out[16]}]          \
[get_ports {dram_out[15]}] [get_ports {dram_out[14]}] [get_ports               \
{dram_out[13]}] [get_ports {dram_out[12]}] [get_ports {dram_out[11]}]          \
[get_ports {dram_out[10]}] [get_ports {dram_out[9]}] [get_ports {dram_out[8]}] \
[get_ports {dram_out[7]}] [get_ports {dram_out[6]}] [get_ports {dram_out[5]}]  \
[get_ports {dram_out[4]}] [get_ports {dram_out[3]}] [get_ports {dram_out[2]}]  \
[get_ports {dram_out[1]}] [get_ports {dram_out[0]}]]  -to [list [get_ports {iram_address[31]}] [get_ports {iram_address[30]}]       \
[get_ports {iram_address[29]}] [get_ports {iram_address[28]}] [get_ports       \
{iram_address[27]}] [get_ports {iram_address[26]}] [get_ports                  \
{iram_address[25]}] [get_ports {iram_address[24]}] [get_ports                  \
{iram_address[23]}] [get_ports {iram_address[22]}] [get_ports                  \
{iram_address[21]}] [get_ports {iram_address[20]}] [get_ports                  \
{iram_address[19]}] [get_ports {iram_address[18]}] [get_ports                  \
{iram_address[17]}] [get_ports {iram_address[16]}] [get_ports                  \
{iram_address[15]}] [get_ports {iram_address[14]}] [get_ports                  \
{iram_address[13]}] [get_ports {iram_address[12]}] [get_ports                  \
{iram_address[11]}] [get_ports {iram_address[10]}] [get_ports                  \
{iram_address[9]}] [get_ports {iram_address[8]}] [get_ports {iram_address[7]}] \
[get_ports {iram_address[6]}] [get_ports {iram_address[5]}] [get_ports         \
{iram_address[4]}] [get_ports {iram_address[3]}] [get_ports {iram_address[2]}] \
[get_ports {iram_address[1]}] [get_ports {iram_address[0]}] [get_ports         \
{dram_address[31]}] [get_ports {dram_address[30]}] [get_ports                  \
{dram_address[29]}] [get_ports {dram_address[28]}] [get_ports                  \
{dram_address[27]}] [get_ports {dram_address[26]}] [get_ports                  \
{dram_address[25]}] [get_ports {dram_address[24]}] [get_ports                  \
{dram_address[23]}] [get_ports {dram_address[22]}] [get_ports                  \
{dram_address[21]}] [get_ports {dram_address[20]}] [get_ports                  \
{dram_address[19]}] [get_ports {dram_address[18]}] [get_ports                  \
{dram_address[17]}] [get_ports {dram_address[16]}] [get_ports                  \
{dram_address[15]}] [get_ports {dram_address[14]}] [get_ports                  \
{dram_address[13]}] [get_ports {dram_address[12]}] [get_ports                  \
{dram_address[11]}] [get_ports {dram_address[10]}] [get_ports                  \
{dram_address[9]}] [get_ports {dram_address[8]}] [get_ports {dram_address[7]}] \
[get_ports {dram_address[6]}] [get_ports {dram_address[5]}] [get_ports         \
{dram_address[4]}] [get_ports {dram_address[3]}] [get_ports {dram_address[2]}] \
[get_ports {dram_address[1]}] [get_ports {dram_address[0]}] [get_ports         \
dram_rw_bar] [get_ports {dram_in[31]}] [get_ports {dram_in[30]}] [get_ports    \
{dram_in[29]}] [get_ports {dram_in[28]}] [get_ports {dram_in[27]}] [get_ports  \
{dram_in[26]}] [get_ports {dram_in[25]}] [get_ports {dram_in[24]}] [get_ports  \
{dram_in[23]}] [get_ports {dram_in[22]}] [get_ports {dram_in[21]}] [get_ports  \
{dram_in[20]}] [get_ports {dram_in[19]}] [get_ports {dram_in[18]}] [get_ports  \
{dram_in[17]}] [get_ports {dram_in[16]}] [get_ports {dram_in[15]}] [get_ports  \
{dram_in[14]}] [get_ports {dram_in[13]}] [get_ports {dram_in[12]}] [get_ports  \
{dram_in[11]}] [get_ports {dram_in[10]}] [get_ports {dram_in[9]}] [get_ports   \
{dram_in[8]}] [get_ports {dram_in[7]}] [get_ports {dram_in[6]}] [get_ports     \
{dram_in[5]}] [get_ports {dram_in[4]}] [get_ports {dram_in[3]}] [get_ports     \
{dram_in[2]}] [get_ports {dram_in[1]}] [get_ports {dram_in[0]}]]
