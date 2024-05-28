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
lappend input_pins [get_full_name $input]
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

#add_pdn_stripe -layer M7 -width 12 -offset 12 -pitch 96 -spacing 6  -grid Core
#add_pdn_stripe -layer M6 -width 8 -offset 8 -pitch 64 -spacing 4  -grid Core
add_pdn_stripe -layer met5 -width 20 -offset 4 -pitch 20 -spacing 4  -grid unithd
#add_pdn_stripe -layer M4 -width 3 -offset 2 -pitch 24 -spacing 2  -grid unithd
add_pdn_stripe -layer met1 -grid unithd -width 0.66 -followpins

#add_pdn_connect -layers {M1 M4} -grid Core
#add_pdn_connect -layers {M4 M5} -grid Core
#add_pdn_connect -layers {M5 M6} -grid Core
#add_pdn_connect -layers {M6 M7} -grid Core

pdngen


write_def ./fp.def



 
