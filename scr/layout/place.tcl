global_placement -routability_driven

buffer_ports -inputs

buffer_ports -outputs

insert_tiecells -prefix TIE sky130_fd_sc_hd__conb_1/HI
insert_tiecells -prefix TIE sky130_fd_sc_hd__conb_1/LO

repair_tie_fanout -verbose  sky130_fd_sc_hd__conb_1/HI
repair_tie_fanout -verbose  sky130_fd_sc_hd__conb_1/LO

detailed_placement

optimize_mirroring

check_placement

write_def place.def
