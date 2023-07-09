#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Jul  9 17:58:58 2023                
#                                                     
#######################################################

#@(#)CDS: Innovus v20.11-s130_1 (64bit) 08/05/2020 15:53 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.11-s130_1 NR200802-2257/20_11-UB (database version 18.20.512) {superthreading v2.9}
#@(#)CDS: AAE 20.11-s008 (64bit) 08/05/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.11-s059_1 () Aug  2 2020 05:46:30 ( )
#@(#)CDS: SYNTECH 20.11-s028_1 () Aug  1 2020 06:14:27 ( )
#@(#)CDS: CPE v20.11-s013
#@(#)CDS: IQuantus/TQuantus 19.1.3-s260 (64bit) Thu May 28 10:57:28 PDT 2020 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set fpIsMaxIoHeight 0
set init_gnd_net gnd
set init_mmmc_file DLX.view
set init_oa_search_lib {}
set init_pwr_net vdd
set init_verilog ../syn/netlist/dlx_postsyn_netlist.v
set init_lef_file /eda/dk/nangate45/lef/NangateOpenCellLibrary.lef
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 1.0 0.6 5 5 5 5
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site FreePDK45_38x28_10R_NP_162NW_34O -r 0.997404318772 0.59986 5.13 5.04 5.13 5.04
uiSetTool select
getIoFlowFlag
fit
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {gnd vdd} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 0.8 bottom 0.8 left 0.8 right 0.8} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {gnd vdd} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 0.8 bottom 0.8 left 0.8 right 0.8} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {vdd gnd} -layer metal10 -direction vertical -width 0.8 -spacing 0.8 -set_to_set_distance 20 -start_from left -start_offset 15 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets {vdd gnd} -layer metal10 -direction vertical -width 0.8 -spacing 0.8 -set_to_set_distance 20 -start_from left -start_offset 15 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { gnd vdd } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { gnd vdd } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
place_design
setDrawView ameba
zoomBox -108.62000 9.43500 306.08150 187.72100
zoomBox -75.69050 25.02300 276.80550 176.56600
zoomBox -47.70050 38.27250 251.92100 167.08400
zoomBox -23.90950 49.53450 230.76950 159.02450
zoomBox 13.50300 67.24450 197.50850 146.35100
zoomBox 40.57300 80.04000 173.51750 137.19450
zoomBox 51.14500 85.02150 164.14800 133.60300
zoomBox 67.76950 92.85450 149.41500 127.95500
zoomBox 74.26200 95.91400 143.66100 125.74950
zoomBox 67.76900 92.85450 149.41550 127.95550
zoomBox 51.14400 85.02100 164.14950 133.60350
zoomBox 28.13350 74.17850 184.54300 141.42100
zoomBox -3.71550 59.17150 212.76900 152.24100
zoomBox -23.96900 49.62800 230.71900 159.12200
zoomBox -75.82950 25.19150 276.68050 176.74050
zoomBox -108.90650 9.65150 305.81150 187.94450
zoomBox -147.82050 -8.63050 340.08300 201.12600
zoomBox -66.15600 13.32550 150.33150 106.39650
zoomBox -39.66250 20.52100 93.28850 77.67850
zoomBox -33.30650 22.23900 79.70200 70.82300
zoomBox -18.89600 26.37100 50.50550 56.20750
zoomBox -15.36600 27.39000 43.62500 52.75100
zoomBox -7.52300 29.67200 28.70500 45.24700
zoomBox -5.63800 30.22900 25.15600 43.46800
zoomBox -21.17950 25.17950 48.22400 55.01700
zoomBox -32.18050 21.46400 63.87950 62.76150
zoomBox -41.95050 18.17200 71.06100 66.75700
zoomBox -53.46050 14.26750 79.49450 71.42650
zoomBox -67.00150 9.67400 89.41600 76.92000
zoomBox -82.93200 4.27000 101.08850 83.38300
zoomBox -101.90300 -2.08750 114.59200 90.98650
zoomBox -124.22150 -9.56700 130.47850 99.93200
zoomBox -96.69750 -1.28000 119.79800 91.79450
zoomBox -239.98500 -44.43650 174.75300 133.86500
zoomBox -514.47900 -127.11200 280.03000 214.45850
setDrawView ameba
setDrawView ameba
setDrawView fplan
setDrawView ameba
setDrawView place
zoomBox -407.06200 -93.42150 268.27100 196.91350
zoomBox -314.32950 -65.26100 259.70400 181.52400
zoomBox -235.30450 -41.45900 252.62400 168.30800
zoomBox -167.96100 -21.28450 246.77800 157.01750
zoomBox -110.71950 -4.13650 241.80950 147.42050
zoomBox -62.06400 10.43950 237.58600 139.26300
zoomBox -20.70650 22.82900 233.99600 132.32900
setDrawView ameba
zoomBox 27.85400 38.27500 211.87800 117.38950
zoomBox 5.42400 31.30700 221.92300 124.38300
zoomBox -52.00900 13.46500 247.64400 142.29000
zoomBox -88.53200 2.11900 264.00050 153.67750
zoomBox -131.50050 -11.22950 283.24350 167.07450
zoomBox -91.01650 12.34950 261.51550 163.90800
zoomBox -57.01950 32.26700 242.63300 161.09200
zoomBox -5.64350 65.86150 210.85650 158.93800
zoomBox 14.42050 79.00900 198.44700 158.12450
zoomBox 45.97250 99.68400 178.93200 156.84500
zoomBox 58.52900 107.61750 171.54500 156.20450
zoomBox 69.20200 114.36100 165.26600 155.66000
zoomBox 78.39850 120.05900 160.05300 155.16350
zoomBox 86.21500 124.90250 155.62200 154.74150
zoomBox 98.68850 132.33850 148.83500 153.89700
zoomBox 103.60100 135.24200 146.22550 153.56700
gui_select -rect {133.14100 151.23050 133.00750 149.99550}
zoomSelected
zoomBox 91.71550 132.48550 150.71250 157.84900
zoomBox 83.89700 129.95000 153.30500 159.78950
zoomBox 74.69800 126.96700 156.35500 162.07250
zoomBox 51.07100 119.27950 164.09150 167.86850
zoomBox 33.93750 114.20350 166.90300 171.36700
zoomBox -9.45400 101.20600 174.58150 180.32550
zoomBox -36.81900 92.63550 179.69350 185.71700
zoomBox -101.02800 63.78650 198.64400 192.61950
zoomBox 7.37700 114.73100 163.80850 181.98300
zoomBox 25.10800 123.23850 158.07550 180.40300
zoomBox 52.76000 137.46550 148.82900 178.76700
zoomBox 63.55900 143.06250 145.21850 178.16900
zoomBox 80.54100 151.86400 139.54000 177.22850
zoomBox 87.17300 155.30100 137.32250 176.86100
zoomBox 92.81050 158.22300 135.43750 176.54900
zoomBox 105.13750 164.61200 131.31600 175.86650
zoomBox 112.72300 168.54300 128.80050 175.45500
zoomBox 105.13500 164.61050 131.31700 175.86650
zoomBox 97.51150 160.68100 133.75000 176.26050
zoomBox 79.97050 151.78300 138.97950 177.15200
zoomBox 38.24850 130.75300 151.29300 179.35250
zoomBox -16.59600 103.10850 167.47900 182.24500
zoomBox -71.18500 75.59200 183.59000 185.12350
zoomBox -146.74250 37.50700 205.89000 189.10850
zoomBox -18.66350 59.03100 197.89850 152.13400
zoomBox 94.73300 78.08700 190.82300 119.39750
zoomBox 137.96550 85.35250 188.12550 106.91700
zoomBox 156.18350 88.42900 186.98850 101.67250
zoomBox 167.37150 90.31850 186.29050 98.45200
zoomBox 170.04250 90.76950 186.12400 97.68300
zoomBox 145.04300 86.44300 187.68400 104.77500
zoomBox 94.80450 77.31600 190.90750 118.63200
zoomBox 38.10700 66.86550 194.59550 134.14200
zoomBox -96.21100 41.50550 203.57250 170.38650
zoomBox -272.77500 8.02100 215.37250 217.88250
zoomBox -121.58300 66.11350 178.20150 194.99500
zoomBox -27.37300 102.34750 156.73250 181.49700
zoomBox 30.53850 124.60000 143.60350 173.20800
zoomBox -53.86000 92.17050 162.73700 185.28850
zoomBox -164.80300 49.43450 187.88850 201.06150
zoomBox -428.07500 -52.73900 247.57400 237.73200
zoomBox -200.31150 -25.22250 214.62300 153.16350
setDrawView place
setDrawView ameba
setDrawView fplan
zoomBox -82.43800 7.31050 134.16150 100.42950
zoomBox -242.24100 -34.37050 245.92050 175.49700
setDrawView ameba
zoomBox -183.46700 -15.04650 231.47100 163.34100
zoomBox -91.93850 15.92250 207.85400 144.80750
zoomBox -56.26700 28.10650 198.55750 137.65900
deselectAll
selectObject Module dtpth
zoomBox -86.65750 15.81650 213.13650 144.70200
zoomBox -122.41050 1.35800 230.28800 152.98800
setDrawView fplan
zoomBox -32.21150 36.77300 222.61350 146.32600
zoomBox -120.96600 1.28700 231.73400 152.91750
setDrawView place
zoomBox -179.69800 -20.74350 235.24350 157.64550
zoomBox -237.84200 -44.25350 250.32450 165.61600
zoomBox -185.20250 -25.78950 229.73900 152.59950
zoomBox -141.09250 -10.19250 211.60750 141.43800
zoomBox -103.59900 3.06450 196.19600 131.95050
zoomBox -2.04350 38.97350 154.45200 106.25300
zoomBox 28.73300 49.85600 141.80100 98.46550
zoomBox 40.75250 54.10600 136.86050 95.42400
zoomBox 50.96900 57.71850 132.66100 92.83900
zoomBox 28.73300 49.85600 141.80100 98.46550
zoomBox -2.04400 38.97350 154.45150 106.25300
zoomBox -44.64150 23.91150 171.96100 117.03200
zoomBox -141.09400 -10.19350 211.60800 141.43800
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType center -spacing 0.14 -pin clk
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType center -spacing 0.14 -pin rst
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Top -layer 1 -spreadType center -spacing 0.14 -pin dram_rw_bar
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Right -layer 1 -spreadType center -spacing 0.14 -pin {{dram_address[0]} {dram_address[1]} {dram_address[2]} {dram_address[3]} {dram_address[4]} {dram_address[5]} {dram_address[6]} {dram_address[7]} {dram_address[8]} {dram_address[9]} {dram_address[10]} {dram_address[11]} {dram_address[12]} {dram_address[13]} {dram_address[14]} {dram_address[15]} {dram_address[16]} {dram_address[17]} {dram_address[18]} {dram_address[19]} {dram_address[20]} {dram_address[21]} {dram_address[22]} {dram_address[23]} {dram_address[24]} {dram_address[25]} {dram_address[26]} {dram_address[27]} {dram_address[28]} {dram_address[29]} {dram_address[30]} {dram_address[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -spreadDirection clockwise -side Right -layer 1 -spreadType side -pin {{dram_address[0]} {dram_address[1]} {dram_address[2]} {dram_address[3]} {dram_address[4]} {dram_address[5]} {dram_address[6]} {dram_address[7]} {dram_address[8]} {dram_address[9]} {dram_address[10]} {dram_address[11]} {dram_address[12]} {dram_address[13]} {dram_address[14]} {dram_address[15]} {dram_address[16]} {dram_address[17]} {dram_address[18]} {dram_address[19]} {dram_address[20]} {dram_address[21]} {dram_address[22]} {dram_address[23]} {dram_address[24]} {dram_address[25]} {dram_address[26]} {dram_address[27]} {dram_address[28]} {dram_address[29]} {dram_address[30]} {dram_address[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Right -layer 1 -spreadType side -pin {{dram_in[0]} {dram_in[1]} {dram_in[2]} {dram_in[3]} {dram_in[4]} {dram_in[5]} {dram_in[6]} {dram_in[7]} {dram_in[8]} {dram_in[9]} {dram_in[10]} {dram_in[11]} {dram_in[12]} {dram_in[13]} {dram_in[14]} {dram_in[15]} {dram_in[16]} {dram_in[17]} {dram_in[18]} {dram_in[19]} {dram_in[20]} {dram_in[21]} {dram_in[22]} {dram_in[23]} {dram_in[24]} {dram_in[25]} {dram_in[26]} {dram_in[27]} {dram_in[28]} {dram_in[29]} {dram_in[30]} {dram_in[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Right -layer 1 -spreadType side -pin {{dram_out[0]} {dram_out[1]} {dram_out[2]} {dram_out[3]} {dram_out[4]} {dram_out[5]} {dram_out[6]} {dram_out[7]} {dram_out[8]} {dram_out[9]} {dram_out[10]} {dram_out[11]} {dram_out[12]} {dram_out[13]} {dram_out[14]} {dram_out[15]} {dram_out[16]} {dram_out[17]} {dram_out[18]} {dram_out[19]} {dram_out[20]} {dram_out[21]} {dram_out[22]} {dram_out[23]} {dram_out[24]} {dram_out[25]} {dram_out[26]} {dram_out[27]} {dram_out[28]} {dram_out[29]} {dram_out[30]} {dram_out[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Left -layer 1 -spreadType side -pin {{iram_address[0]} {iram_address[1]} {iram_address[2]} {iram_address[3]} {iram_address[4]} {iram_address[5]} {iram_address[6]} {iram_address[7]} {iram_address[8]} {iram_address[9]} {iram_address[10]} {iram_address[11]} {iram_address[12]} {iram_address[13]} {iram_address[14]} {iram_address[15]} {iram_address[16]} {iram_address[17]} {iram_address[18]} {iram_address[19]} {iram_address[20]} {iram_address[21]} {iram_address[22]} {iram_address[23]} {iram_address[24]} {iram_address[25]} {iram_address[26]} {iram_address[27]} {iram_address[28]} {iram_address[29]} {iram_address[30]} {iram_address[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Left -layer 1 -spreadType side -pin {{iram_out[0]} {iram_out[1]} {iram_out[2]} {iram_out[3]} {iram_out[4]} {iram_out[5]} {iram_out[6]} {iram_out[7]} {iram_out[8]} {iram_out[9]} {iram_out[10]} {iram_out[11]} {iram_out[12]} {iram_out[13]} {iram_out[14]} {iram_out[15]} {iram_out[16]} {iram_out[17]} {iram_out[18]} {iram_out[19]} {iram_out[20]} {iram_out[21]} {iram_out[22]} {iram_out[23]} {iram_out[24]} {iram_out[25]} {iram_out[26]} {iram_out[27]} {iram_out[28]} {iram_out[29]} {iram_out[30]} {iram_out[31]}}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -spreadDirection clockwise -side Left -layer 1 -spreadType side -pin {{iram_out[0]} {iram_out[1]} {iram_out[2]} {iram_out[3]} {iram_out[4]} {iram_out[5]} {iram_out[6]} {iram_out[7]} {iram_out[8]} {iram_out[9]} {iram_out[10]} {iram_out[11]} {iram_out[12]} {iram_out[13]} {iram_out[14]} {iram_out[15]} {iram_out[16]} {iram_out[17]} {iram_out[18]} {iram_out[19]} {iram_out[20]} {iram_out[21]} {iram_out[22]} {iram_out[23]} {iram_out[24]} {iram_out[25]} {iram_out[26]} {iram_out[27]} {iram_out[28]} {iram_out[29]} {iram_out[30]} {iram_out[31]}}
setPinAssignMode -pinEditInBatch false
zoomBox -101.98100 20.66700 114.62300 113.78800
zoomBox -114.52300 10.96850 140.30550 120.52300
zoomBox -129.27900 -0.37100 170.52050 128.51700
zoomBox -146.51400 -13.42150 206.19150 138.21150
zoomBox -190.64450 -47.15600 297.52900 162.71650
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
deselectAll
zoomBox -142.89150 -21.00500 156.90800 107.88300
getFillerMode -quiet
addFiller -cell FILLCELL_X1 FILLCELL_X16 FILLCELL_X2 FILLCELL_X32 FILLCELL_X4 FILLCELL_X8 -prefix FILLER
addFiller -cell FILLCELL_X1 FILLCELL_X16 FILLCELL_X2 FILLCELL_X32 FILLCELL_X4 FILLCELL_X8 -prefix FILLER
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
setAnalysisMode
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
optDesign -postRoute -hold
saveDesign dlx
saveDesign dlx
saveDesign dlx
saveDesign dlx.innovus
saveDesign dlx.innovus
win
set_analysis_view -setup {default} -hold {default}
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix dlx_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix dlx_postRoute -outDir timingReports
getAnalysisMode -checkType
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -late > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
verifyConnectivity -type all -error 1000 -warning 50
reportGateCount -level 5 -limit 100 -outfile dlx.gateCount
saveNetlist dlx.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network dlx.sdf
reset_parasitics
extractRC
rcOut -setload dlx.setload -rc_corner standard
rcOut -setres dlx.setres -rc_corner standard
rcOut -spf dlx.spf -rc_corner standard
rcOut -spef dlx.spef -rc_corner standard
fit
zoomBox -113.03250 9.60700 301.66900 187.89300
zoomBox -12.60150 60.67600 203.87650 153.74300
zoomBox 26.77700 82.58950 159.72200 139.74450
zoomBox 51.00000 96.04650 132.64650 131.14750
zoomBox 65.87650 104.31100 116.01800 125.86750
zoomBox 77.21900 110.58500 103.39400 121.83800
zoomBox 79.29100 111.67650 101.54000 121.24150
zoomBox 82.39450 113.39250 98.47000 120.30350
zoomBox 85.38200 115.07250 95.25450 119.31700
zoomBox 86.64850 115.81450 93.78250 118.88150
zoomBox 87.56450 116.35100 92.71900 118.56700
zoomBox 87.92250 116.56050 92.30350 118.44400
zoomBox 88.48500 116.88950 91.65050 118.25050
zoomBox 88.70400 117.01800 91.39550 118.17500
zoomBox 89.05100 117.22050 90.99550 118.05650
zoomBox 89.18650 117.29950 90.83950 118.01000
zoomBox 89.30200 117.36650 90.70700 117.97050
zoomBox 89.40000 117.42350 90.59450 117.93700
zoomBox 89.48650 117.47700 90.50200 117.91350
zoomBox 89.56000 117.52350 90.42350 117.89450
zoomBox 89.62250 117.56300 90.35650 117.87850
zoomBox 89.67550 117.59600 90.29950 117.86450
zoomBox 89.72050 117.62450 90.25100 117.85250
zoomBox 89.75850 117.64850 90.21000 117.84250
zoomBox 89.82100 117.66750 90.20500 117.83250
zoomBox 89.84650 117.68050 90.17350 117.82100
zoomBox 89.84650 117.66650 90.17350 117.80700
zoomBox 89.84650 117.65250 90.17350 117.79300
zoomBox 89.91650 117.68800 90.08750 117.76150
uiSetTool select
gui_select -rect {89.96800 117.73400 90.02050 117.71400}
zoomBox 89.91650 117.68050 90.08750 117.75400
zoomBox 89.91650 117.67300 90.08750 117.74650
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomBox -129.81450 20.10600 310.17950 209.26550
setDrawView ameba
setDrawView place
setDrawView fplan
zoomBox -129.81450 39.02200 310.17950 228.18150
zoomBox -129.81450 57.93800 310.17950 247.09750
zoomBox -129.81450 114.68600 310.17950 303.84550
zoomBox -129.81450 133.60200 310.17950 322.76150
zoomBox -168.66850 119.92100 348.97250 342.46200
zoomBox -214.37850 103.82600 394.61100 365.63900
zoomBox -269.58550 91.11850 446.87250 399.13350
zoomBox -334.53500 76.16850 508.35650 438.53900
zoomBox -64.84400 139.78050 253.05350 276.44900
zoomBox -1.82900 155.34200 193.40000 239.27350
zoomBox 26.00050 162.21450 167.05450 222.85550
zoomBox 26.00050 156.15050 167.05450 216.79150
zoomBox 26.00050 144.02250 167.05450 204.66350
zoomBox 26.00050 137.95850 167.05450 198.59950
zoomBox 26.00050 125.83050 167.05450 186.47150
zoomBox 26.00050 113.70250 167.05450 174.34350
zoomBox 58.26000 124.79000 131.89150 156.44500
zoomBox 71.85450 129.19450 117.07400 148.63500
zoomBox 75.05150 130.23000 113.48850 146.75450
zoomBox 77.70150 131.11050 110.37300 145.15650
zoomBox 79.91950 131.88200 107.69050 143.82100
zoomBox 81.79450 132.53750 105.40050 142.68600
zoomBox 86.74250 134.59100 99.06500 139.88850
zoomBox 87.55300 134.93400 98.02700 139.43700
zoomBox 89.39450 135.81650 95.82700 138.58200
zoomBox 89.84700 136.01850 95.31500 138.36950
zoomBox 90.55850 136.33650 94.51000 138.03550
zoomBox 90.83750 136.46100 94.19650 137.90500
zoomBox 91.28300 136.66950 93.71000 137.71300
zoomBox 91.45700 136.75100 93.52000 137.63800
zoomBox 91.72300 136.92550 93.21400 137.56650
zoomBox 91.99000 137.11350 92.90650 137.50750
zoomBox 92.15450 137.22850 92.71800 137.47100
zoomBox 92.19350 137.25600 92.67300 137.46200
zoomBox 92.19350 137.23550 92.67300 137.44150
zoomBox 92.15400 137.20800 92.71850 137.45050
zoomBox 92.10750 137.17600 92.77200 137.46150
zoomBox 92.10750 137.23300 92.77200 137.51850
zoomBox 92.10750 137.26150 92.77200 137.54700
zoomBox 92.10750 137.14750 92.77200 137.43300
zoomBox 92.10750 137.09050 92.77200 137.37600
zoomBox 92.10750 137.06200 92.77200 137.34750
zoomBox 92.10750 137.03350 92.77200 137.31900
zoomBox 92.05100 137.00800 92.83250 137.34400
zoomBox 91.98400 136.97800 92.90400 137.37350
zoomBox 91.90550 136.94250 92.98800 137.40800
zoomBox 91.81250 136.90100 93.08700 137.44900
zoomBox 91.70400 136.85250 93.20300 137.49700
setDrawView place
zoomBox 91.70400 136.91700 93.20300 137.56150
zoomBox 91.70400 136.98150 93.20300 137.62600
zoomBox 91.70400 137.04600 93.20300 137.69050
zoomBox 91.91200 137.14600 92.99600 137.61200
zoomBox 91.99350 137.18500 92.91500 137.58100
zoomBox 92.06250 137.21800 92.84650 137.55500
zoomBox 92.12150 137.24600 92.78800 137.53250
zoomBox 92.21400 137.29050 92.69550 137.49750
zoomBox 92.28100 137.32300 92.62900 137.47250
zoomBox 92.30700 137.33500 92.60300 137.46250
zoomBox 92.33950 137.35450 92.55400 137.44650
zoomBox 92.36300 137.36850 92.51900 137.43550
zoomBox 92.36300 137.36200 92.51900 137.42900
zoomBox 92.34150 137.34900 92.55800 137.44200
zoomBox 92.32800 137.34050 92.58250 137.45000
zoomBox 92.31200 137.33050 92.61150 137.45950
zoomBox 92.29250 137.31900 92.64600 137.47100
zoomBox 92.24400 137.28950 92.73400 137.50000
zoomBox 92.21350 137.27050 92.79000 137.51850
zoomBox 92.17700 137.24850 92.85600 137.54050
zoomBox 92.13450 137.22250 92.93350 137.56600
zoomBox 92.02650 137.15600 93.13250 137.63150
zoomBox 91.66900 136.93650 93.78950 137.84800
zoomBox 91.19950 136.64800 94.65250 138.13250
zoomBox 90.08350 135.96350 96.70100 138.80850
zoomBox 88.61800 135.06400 99.39450 139.69700
zoomBox 86.21150 133.57900 103.76000 141.12350
zoomBox 82.27850 131.17650 110.85500 143.46200
zoomBox 72.75400 125.50000 127.49750 149.03500
zoomBox 54.50000 114.62550 159.37350 159.71200
zoomBox 47.68850 110.52400 171.06900 163.56700
zoomBox 19.15500 93.36700 220.06050 179.73900
zoomBox -9.24650 76.44750 268.82450 195.99400
zoomBox 37.27950 95.18250 182.43450 157.58650
zoomBox 51.53700 100.98600 156.41150 146.07300
zoomBox 72.32350 109.66650 118.85750 129.67200
zoomBox 80.26500 113.06250 104.55750 123.50600
zoomBox 81.56600 113.61850 102.21500 122.49600
zoomBox 84.85350 115.37800 97.53500 120.83000
zoomBox 86.87200 116.45850 94.66100 119.80700
zoomBox 88.32100 117.01850 92.38700 118.76650
zoomBox 88.55800 117.11000 92.01450 118.59600
zoomBox 89.10550 117.37350 91.22800 118.28600
zoomBox 89.23600 117.43600 91.04050 118.21200
zoomBox 89.34650 117.48950 90.88100 118.14900
zoomBox 89.44100 117.53450 90.74550 118.09550
zoomBox 89.58900 117.60600 90.53200 118.01150
zoomBox 89.64700 117.63350 90.44900 117.97850
zoomBox 89.64650 117.53000 90.44900 117.87500
zoomBox 89.64650 117.49550 90.44900 117.84050
zoomBox 89.57600 117.46100 90.52000 117.86700
zoomBox 89.39400 117.37300 90.70250 117.93550
zoomBox 89.27800 117.31650 90.81800 117.97850
zoomBox 89.14150 117.24950 90.95350 118.02850
zoomBox 88.98100 117.17050 91.11300 118.08700
zoomBox 88.98100 117.35350 91.11300 118.27000
zoomBox 88.98100 117.44500 91.11300 118.36150
zoomBox 88.98100 117.81100 91.11300 118.72750
zoomBox 88.98100 118.17700 91.11300 119.09350
zoomBox 88.98100 118.63450 91.11300 119.55100
zoomBox 88.98100 119.00050 91.11300 119.91700
zoomBox 88.98100 119.09200 91.11300 120.00850
zoomBox 88.98100 119.27500 91.11300 120.19150
zoomBox 88.98100 119.36650 91.11300 120.28300
zoomBox 88.98100 119.64100 91.11300 120.55750
zoomBox 88.98100 120.00700 91.11300 120.92350
zoomBox 88.98100 120.09850 91.11300 121.01500
zoomBox 88.98100 120.46450 91.11300 121.38100
zoomBox 88.98100 120.55600 91.11300 121.47250
zoomBox 88.98100 120.64750 91.11300 121.56400
zoomBox 88.98100 120.83050 91.11300 121.74700
zoomBox 88.98100 121.10500 91.11300 122.02150
zoomBox 88.98100 121.47100 91.11300 122.38750
zoomBox 88.98100 121.83700 91.11300 122.75350
zoomBox 88.98100 122.20300 91.11300 123.11950
zoomBox 88.98100 122.56900 91.11300 123.48550
zoomBox 88.98100 122.93500 91.11300 123.85150
zoomBox 88.98100 123.30100 91.11300 124.21750
zoomBox 88.98100 123.66700 91.11300 124.58350
zoomBox 88.98100 124.03300 91.11300 124.94950
zoomBox 88.98100 124.39900 91.11300 125.31550
zoomBox 88.98100 124.76500 91.11300 125.68150
zoomBox 88.98100 124.85650 91.11300 125.77300
zoomBox 88.98100 125.22250 91.11300 126.13900
zoomBox 88.98100 125.58850 91.11300 126.50500
zoomBox 88.98100 125.95450 91.11300 126.87100
zoomBox 88.98100 126.22900 91.11300 127.14550
zoomBox 88.98100 126.41200 91.11300 127.32850
zoomBox 88.98100 126.32050 91.11300 127.23700
zoomBox 88.78400 126.21800 91.29200 127.29600
zoomBox 88.55200 126.09700 91.50250 127.36550
zoomBox 88.27900 125.95500 91.75050 127.44750
zoomBox 87.95750 125.78800 92.04200 127.54400
zoomBox 86.61250 125.08850 93.26400 127.94800
zoomBox 86.61250 126.51850 93.26400 129.37800
zoomBox 86.61250 127.66250 93.26400 130.52200
zoomBox 86.61250 128.52050 93.26400 131.38000
zoomBox 86.61250 129.09250 93.26400 131.95200
zoomBox 86.61250 130.52250 93.26400 133.38200
zoomBox 86.61250 131.66650 93.26400 134.52600
zoomBox 86.61250 132.81050 93.26400 135.67000
zoomBox 86.61250 133.95450 93.26400 136.81400
zoomBox 86.61250 134.24050 93.26400 137.10000
zoomBox 86.61250 135.38450 93.26400 138.24400
zoomBox 86.61250 136.52850 93.26400 139.38800
zoomBox 86.61250 137.95850 93.26400 140.81800
zoomBox 86.61250 139.10250 93.26400 141.96200
zoomBox 86.61250 140.24650 93.26400 143.10600
zoomBox 86.61250 141.10450 93.26400 143.96400
zoomBox 86.61250 141.39050 93.26400 144.25000
zoomBox 86.61250 141.10450 93.26400 143.96400
zoomBox 86.61250 140.81850 93.26400 143.67800
zoomBox 86.61250 140.53250 93.26400 143.39200
zoomBox 86.61250 140.24650 93.26400 143.10600
zoomBox 85.22300 139.56800 94.42950 143.52600
zoomBox 84.33500 139.13650 95.16600 143.79300
zoomBox 83.28950 138.62900 96.03300 144.10750
zoomBox 82.06000 138.03200 97.05250 144.47750
zoomBox 80.61350 137.32950 98.25200 144.91250
zoomBox 78.91150 136.50300 99.66350 145.42450
zoomBox 71.78450 133.04150 105.57550 147.56850
zoomBox 64.69000 129.59550 111.46000 149.70250
zoomBox 60.17850 127.40400 115.20200 151.05950
zoomBox 54.87050 124.82650 119.60450 152.65650
zoomBox 48.59900 121.75800 124.75750 154.49950
zoomBox 41.22150 118.14800 130.81950 156.66750
zoomBox 32.54200 113.90100 137.95150 159.21800
zoomBox 22.33050 108.90400 146.34200 162.21850
zoomBox 10.31650 103.02600 156.21300 165.74900
zoomBox -3.81750 96.11050 167.82600 169.90250
zoomBox -20.44500 87.85600 181.48850 174.67000
zoomBox -40.00700 78.14500 197.56200 180.27900
zoomBox -63.02100 66.72000 216.47200 186.87800
zoomBox -90.09650 53.27900 238.71950 194.64150
zoomBox -121.95000 37.46600 264.89250 203.77500
fit
setDrawView ameba
selectObject Module dtpth
deselectAll
selectObject Module dtpth
deselectAll
selectObject Module dtpth
deselectAll
selectObject Module dtpth
deselectAll
selectObject Module dtpth
setDrawView ameba
setDrawView fplan
setDrawView ameba
zoomBox -116.70050 8.34600 298.00100 186.63200
zoomBox -89.86000 23.64150 262.63600 175.18450
zoomBox -67.04600 36.68400 232.57600 165.49550
zoomBox -30.33300 57.84800 186.14400 150.91450
zoomBox -12.35550 66.31550 171.65000 145.42200
zoomBox 2.94700 73.51300 159.35150 140.75350
zoomBox -51.53900 47.88600 203.14000 157.37600
zoomBox -180.83450 -12.92700 307.05150 196.82200
zoomBox -140.26050 6.15650 274.44350 184.44350
setDrawView ameba
setDrawView fplan
setDrawView ameba
setDrawView place
setLayerPreference violation -isVisible 0
setLayerPreference violation -isVisible 1
setLayerPreference violation -isVisible 0
setDrawView ameba
setLayerPreference node_inst -isVisible 0
setLayerPreference node_inst -isVisible 1
setDrawView place
setLayerPreference violation -isVisible 1
setLayerPreference violation -isVisible 0
setLayerPreference violation -isVisible 1
fit
setDrawView ameba
setDrawView fplan
