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

############################################################################################
#set units
set_cmd_units -time ns -capacitance pF -current mA -voltage V -resistance kOhm -distance um
############################################################################################

############################################################################################
#Read LEF files
read_lef ../../lefs/sky130.tlef ; # Techlef

read_lef ../../lefs/sky130_fd_sc_hd.lef ; # load all cell lefs
############################################################################################

############################################################################################
# Define corners and read corresponding LIB files
define_corners fast typical slow

read_liberty -corner fast    ../../lib/sky130_fd_sc_hd__ff_n40C_1v95.lib
read_liberty -corner typical ../../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_liberty -corner slow    ../../lib/sky130_fd_sc_hd__ss_100C_1v40.lib
############################################################################################

############################################################################################
# Read the netlist
read_verilog ../syn/segment_seconds_netlist.v
link_design seven_segment_seconds
############################################################################################

############################################################################################
# Read SDC file
read_sdc ../../scr/sdc/const.sdc
############################################################################################
