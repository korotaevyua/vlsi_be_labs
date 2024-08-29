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

set_routing_layers -signal met1-met3 -clock met1-met3
set_wire_rc -clock -signal -layer met1 -layer met2 -layer met3

##############################################################################################
set ckbuf_list "sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4"
set root_ckbuf_list "sky130_fd_sc_hd__clkbuf_8"

clock_tree_synthesis -buf_list $ckbuf_list -root_buf $root_ckbuf_list
##############################################################################################

set_propagated_clock [all_clocks]

estimate_parasitics -placement

repair_clock_nets

detailed_placement
optimize_mirroring
estimate_parasitics -placement

write_def cts_opt.def



