set_cmd_units -time ns -capacitance pF -current mA -voltage V -resistance kOhm -distance um
 
define_corners typical

read_lef ../../lefs/sky130_fd_sc_hd.tlef

source ../../lefs/lefs

read_liberty -corner typical ../../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog ../syn/seven_segment_seconds_netlist.v
link_design seven_segment_seconds

read_sdc ../../scr/sdc/const.sdc

