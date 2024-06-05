set filler_cells "sky130_fd_sc_hd__fill_1 sky130_fd_sc_hd__fill_2 sky130_fd_sc_hd__fill_4"

filler_placement "$filler_cells"

check_placement
report_design_area

write_def fill.def
write_sdc func_fill.sdc

