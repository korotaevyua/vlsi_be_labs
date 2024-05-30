set inputs [all_inputs]

set input_pins {}

foreach input $inputs {
lappend input_pins [get_full_name $input]
}

set outputs [all_outputs]

set output_pins {}

foreach output $outputs {
lappend output_pins [get_full_name $output]
}

set y 0

for {set i 0} {$i < [llength $input_pins]} {incr i} {

place_pin \
-pin_name [lindex $input_pins $i] \
-layer met3 \
-location "0.23 $y" \
-pin_size {0.46 0.30}
set y [expr $y + 2.72]

}

set y $Y_size

for {set i 0} {$i < [llength $output_pins]} {incr i} {

place_pin \
-pin_name [lindex $output_pins $i] \
-layer met3 \
-location "$X_size $y" \
-pin_size {0.46 0.30}
set y [expr $y - 2.72]

}


