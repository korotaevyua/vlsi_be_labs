set_routing_layers -signal met2-met3 -clock met2-met3

set_global_routing_layer_adjustment met2 0.5
set_global_routing_layer_adjustment met3 0.5
set_global_routing_layer_adjustment met4 0.5

set_wire_rc -clock -layer met3
set_wire_rc -signal -layer met3

global_route -verbose -congestion_report_file congection_map.rpt -guide_file groute.guide

#repair_design

#check_antennas -report_file ./$TIME/antenna_fix.rpt

estimate_parasitics -global_routing

repair_timing -setup

estimate_parasitics -global_routing

repair_timing -hold

detailed_placement
optimize_mirroring

check_antennas -report_file antenna.rpt

check_placement

write_def route_global.def
write_sdc func_route_global.sdc

#write_guides  ./$TIME/groute.guide


detailed_route -bottom_routing_layer met1 -top_routing_layer met3 \
-output_guide droute.guide \
-output_drc drc.drc

write_def route_detail.def
write_sdc func_route_detail.sdc

