pdngen -reset

add_global_connection -net VDD -pin_pattern "vdd" -power
add_global_connection -net VSS -pin_pattern "gnd" -ground

global_connect

set_voltage_domain -name unithd -power VDD -ground VSS
define_pdn_grid -name unithd -voltage_domain Core 

#add_pdn_stripe -layer M7 -width 12 -offset 12 -pitch 96 -spacing 6  -grid Core
#add_pdn_stripe -layer M6 -width 8 -offset 8 -pitch 64 -spacing 4  -grid Core
add_pdn_stripe -layer met5 -width 20 -offset 4 -pitch 48 -spacing 4  -grid unithd
#add_pdn_stripe -layer M4 -width 3 -offset 2 -pitch 24 -spacing 2  -grid unithd
add_pdn_stripe -layer met1 -grid unithd -width 0.66 -followpins

#add_pdn_connect -layers {M1 M4} -grid Core
#add_pdn_connect -layers {M4 M5} -grid Core
#add_pdn_connect -layers {M5 M6} -grid Core
#add_pdn_connect -layers {M6 M7} -grid Core

pdngen

