pdngen -reset

add_global_connection -net VDD -pin_pattern "vdd" -power
add_global_connection -net VSS -pin_pattern "gnd" -ground

global_connect

set_voltage_domain -name Core -power VDD -ground VSS
define_pdn_grid -name Core -voltage_domain Core 

add_pdn_stripe -layer met5 -width 1.6 -offset 1.7 -pitch 6.4 -spacing 1.6  -grid Core
add_pdn_stripe -layer met4 -width 0.3 -offset 0.46 -pitch 1.2 -spacing 0.3  -grid Core
add_pdn_stripe -layer met1 -grid Core -width 0.66 -followpins

add_pdn_connect -layers {met1 met4} -grid Core
add_pdn_connect -layers {met4 met5} -grid Core

pdngen

write_def ./fp.def

