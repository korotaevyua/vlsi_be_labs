#Copyright (c) 2024 Yuri Korotaev
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.


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
