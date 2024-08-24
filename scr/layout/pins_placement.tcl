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

set input_pins {}
set output_pins {}

set inputs [all_inputs]
set outputs [all_outputs]

foreach input_pin $inputs {
lappend input_pins [get_full_name $input_pin]
}

foreach output_pin $outputs {
lappend output_pins [get_full_name $output_pin]
}

set number_input_pins [llength $input_pins]
set y_step_inputs [expr {double($Y_size) / double($number_input_pins + 1) }]
set y_step_inputs [format "%.2f" $y_step_inputs]
set y_inputs [expr 2.72 + $y_step_inputs]

for {set i 0} {$i < $number_input_pins} {incr i} {

place_pin \
-pin_name [lindex $input_pins $i] \
-layer met3 \
-location "0.46 $y_inputs" \
-pin_size {0.46 0.30}
set y_inputs [expr $y_inputs + $y_step_inputs]

}

set number_output_pins [llength $output_pins]
set y_step_outputs [expr {double($Y_size) / double($number_output_pins + 1)}]
set y_step_outputs [format "%.2f" $y_step_outputs]
set y_outputs [expr 2.72 + $y_step_outputs]

for {set i 0} {$i < $number_output_pins} {incr i} {

place_pin \
-pin_name [lindex $output_pins $i] \
-layer met3 \
-location "$X_right_core $y_outputs" \
-pin_size {0.46 0.30}
set y_outputs [expr $y_outputs + $y_step_outputs]

}


