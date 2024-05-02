yosys -import
# read design
read_verilog ../../verilog/seven_segment_seconds.v
hierarchy -top seven_segment_seconds

# the high-level stuff 
fsm 
opt
memory 
opt

# mapping to internal cell library
techmap

opt

# mapping flip-flops to mycells.lib
dfflibmap -liberty ../../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# mapping logic to mycells.lib
abc -liberty ../../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# cleanup
clean

write_verilog seven_segment_seconds_syn.v
