set_routing_layers -signal met1-met3 -clock met1-met3

global_route -verbose -congestion_report_file congection_map.rpt -guide_file groute.guide

estimate_parasitics -global_routing

repair_timing -setup

estimate_parasitics -global_routing

repair_timing -hold

detailed_placement
optimize_mirroring

check_placement

write_def route_global.def

detailed_route -bottom_routing_layer met1 -top_routing_layer met3 \
-output_guide droute.guide \
-output_drc drc.drc \
-droute_end_iter 5

write_def route_detail.def

