set_cmd_units -time ns -capacitance pF -current mA -voltage V -resistance kOhm -distance um
 
define_corners typical

read_lef /home/ykorotaev/lab/skywater-pdk/libraries/skywater-pdk-libs-sky130_fd_sc_hd/tech/sky130_fd_sc_hd.tlef

source /home/ykorotaev/lab/lef/lefs

read_liberty -corner typical ../../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog ../syn/seven_segment_seconds_syn.v
link_design seven_segment_seconds

read_sdc ../../scr/const.sdc

##CORE 0.28 3.92

initialize_floorplan \
-site unithd \
-core_area "0 0 100 100" \
-die_area "0 0 100 100"


make_tracks

set inputs [all_inputs]

set input_pins ""

foreach input $inputs {
lappend input_pins to[get_full_name $input]
}

set outputs [all_outputs]

set output_pins ""

foreach output $outputs {
lappend output_pins [get_full_name $output]
}

set pins ""

foreach p $input_pins {
lappend pins $p
}

set y 0

for {set i 0} {$i < [llength $pins]} {incr i} {

place_pin \
-pin_name [lindex $pins $i] \
-layer met3 \
-location "0.42 $y" \
-pin_size {0.84 0.30}
set y [expr $y + 1.4]
}

set pins ""

foreach p $output_pins {
lappend pins $p
}


set y 10

for {set i 0} {$i < [llength $pins]} {incr i} {

place_pin \
-pin_name [lindex $pins $i] \
-layer met3 \
-location "100 $y" \
-pin_size {0.84 0.30}
set y [expr $y + 1.12]
}

pdngen -reset

add_global_connection -net VDD -pin_pattern "vdd" -power
add_global_connection -net VSS -pin_pattern "gnd" -ground

global_connect

set_voltage_domain -name unithd -power VDD -ground VSS
define_pdn_grid -name unithd -voltage_domain Core 

add_pdn_stripe -layer met5 -width 5 -offset 4 -pitch 20 -spacing 4  -grid unithd
add_pdn_stripe -layer met4 -width 3 -offset 2 -pitch 20 -spacing 2  -grid unithd
add_pdn_stripe -layer met1 -grid unithd -width 0.66 -followpins

add_pdn_connect -layers {met1 met4} -grid Core
add_pdn_connect -layers {met4 met5} -grid Core
#add_pdn_connect -layers {M5 M6} -grid Core
#add_pdn_connect -layers {M6 M7} -grid Core

pdngen


write_def ./fp.def


set_routing_layers -signal met2-met3 -clock met2-met3

set_global_routing_layer_adjustment met1 0
set_global_routing_layer_adjustment met2 0
set_global_routing_layer_adjustment met3 0
set_global_routing_layer_adjustment met4 0
set_global_routing_layer_adjustment met5 0

set_wire_rc -clock -layer met3
set_wire_rc -signal -layer met3

##path groups
group_path -name reg2reg -from [all_registers] -to [all_registers]
group_path -name in2reg -from [all_inputs] -to [all_registers]
group_path -name reg2out -from [all_registers] -to [all_outputs]
group_path -name in2out -from [all_inputs] -to [all_outputs]

##
set_false_path -from [all_inputs] -to [all_registers]
set_false_path -from [all_registers] -to [all_outputs]
set_false_path -from [all_inputs] -to [all_outputs]

#
unset_propagated_clock [all_clocks]

#
#global_placement -verbose_level 1 -routability_driven
global_placement -routability_driven

##remove buffers adding by synt
remove_buffers    

## add bufer between inputs and its loads
buffer_ports -inputs

## add bufer between outputs and its fanins
buffer_ports -outputs

estimate_parasitics -placement


## fix slew,fanout,cap, wires
#repair_design

insert_tiecells -prefix TIE THHVT/Z
insert_tiecells -prefix TIE TLHVT/Z

repair_tie_fanout -verbose  THHVT/Z
repair_tie_fanout -verbose  TLHVT/Z

detailed_placement



optimize_mirroring

check_placement



set_pdnsim_net_voltage -net VDD -voltage 1.1
check_power_grid -net VDD

set_layer_rc -via VIA6 -resistance 28e-6
set_layer_rc -via VIA5 -resistance 28e-6
set_layer_rc -via VIA4 -resistance 28e-6
set_layer_rc -via VIA3 -resistance 28e-6
set_layer_rc -via VIA2 -resistance 28e-6
set_layer_rc -via VIA1 -resistance 28e-6

analyze_power_grid -net VDD -enable_em -outfile ./$TIME/ir_drop.txt -em_outfile ./$TIME/current_ir.txt -vsrc ./vsrc_90.txt


analyze_power_grid -net VSS -enable_em -outfile ./$TIME/vss/ir_drop.txt -em_outfile ./$TIME/vss/current_ir.txt -vsrc ./vsrc_vss_90.txt



 
