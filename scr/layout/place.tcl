#place_tapcells -master sky130_fd_sc_hd__tap_1 -distance 11

tapcell\
-tapcell_master "sky130_fd_sc_hd__tap_2"\
-endcap_master "sky130_fd_sc_hd__tap_1" \
-distance 20.4 \
-tap_prefix WELLTAP \
-endcap_prefix ENDCAP

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

write_def .place.def
