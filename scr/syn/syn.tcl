# usage yosys ../../scr/syn/syn.tcl -l log.txt

# to use tcl correctly
yosys -import

#############################################################
# 1. Reading design
read_verilog ../../verilog/seven_segment_seconds.v
hierarchy -check -top seven_segment_seconds
##############################################################

##############################################################
# 2. Optimization
procs
fsm  
opt
memory 
opt
##############################################################

##############################################################
# 3. Mapping to the library
techmap
opt

dfflibmap -liberty ../../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

clean
###############################################################

###############################################################
# 4. Report
stat
###############################################################

###############################################################
# 5. Write netlist
write_verilog segment_seconds_netlist.v
###############################################################
