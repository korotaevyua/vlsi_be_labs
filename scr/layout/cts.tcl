set_routing_layers -signal met2-met3 -clock met2-met3

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

set_propagated_clock [all_clocks]

set max_slew [expr 0.50 * 1e-9]; # must convert to seconds
set max_cap  [expr 5 * 1e-12]; # must convert to farad

repair_clock_inverters

configure_cts_characterization\
    -max_slew $max_slew\
    -max_cap $max_cap
    
set ckbuf_list "sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4"
set root_ckbuf_list "sky130_fd_sc_hd__clkbuf_8"


clock_tree_synthesis \
-buf_list $ckbuf_list \
-root_buf $root_ckbuf_list

set_propagated_clock [all_clocks]

estimate_parasitics -placement

repair_timing -setup

estimate_parasitics -placement

repair_timing -hold

detailed_placement
optimize_mirroring

check_placement

write_def cts_opt.def
write_sdc func_optCTS.sdc

estimate_parasitics -placement


