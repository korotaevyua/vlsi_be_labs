pdngen -reset

add_global_connection -net VDD -pin_pattern "vdd" -power
add_global_connection -net VSS -pin_pattern "gnd" -ground

global_connect

set_voltage_domain -name Core -power VDD -ground VSS
define_pdn_grid -name Core -voltage_domain Core 

add_pdn_stripe -layer met4 -width 0.9 -offset 0.45 -pitch 3.6 -grid Core
add_pdn_stripe -layer met1 -grid Core -width 0.28 -followpins

add_pdn_connect -layers {met1 met4} -grid Core

pdngen

write_def ./fp.def

