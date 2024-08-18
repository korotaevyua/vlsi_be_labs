set_routing_layers -signal met2-met3 -clock met2-met3

set_wire_rc -clock -layer met3
set_wire_rc -signal -layer met3

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


