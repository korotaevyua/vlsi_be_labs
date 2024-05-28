set inputs [all_inputs]

set input_pins ""

foreach input $inputs {
lappend input_pins to[get_full_name $input]
}

set outputs [all_outputs]

set output_pins ""

foreach output $outputs {
lappend output_pins [get_full_name $output]
}

set pins ""

foreach p $input_pins {
lappend pins $p
}

set y 0

for {set i 0} {$i < [llength $pins]} {incr i} {

place_pin \
-pin_name [lindex $pins $i] \
-layer met3 \
-location "0.42 $y" \
-pin_size {0.84 0.30}
set y [expr $y + 1.4]
}

set pins ""

foreach p $output_pins {
lappend pins $p
}

set y 10

for {set i 0} {$i < [llength $pins]} {incr i} {

place_pin \
-pin_name [lindex $pins $i] \
-layer met3 \
-location "100 $y" \
-pin_size {0.84 0.30}
set y [expr $y + 1.12]
}


