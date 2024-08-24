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

###########################################
#set the block size
set X_size 86.02
set Y_size 87.04
###########################################

set X_right_core [expr $X_size + 0.46]
set Y_top_core   [expr $Y_size + 2.72]

set DIE_X_size   [expr $X_size + (0.46*2)]
set DIE_Y_size   [expr $Y_size + (2.72*2)]
###########################################
initialize_floorplan \
-site unithd \
-core_area "0.46 0.46 $X_right_core $Y_top_core" \
-die_area "0 0 $DIE_X_size $DIE_Y_size"

make_tracks
###########################################
