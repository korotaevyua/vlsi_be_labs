#openroad -gui -log log.txt
#source ../../scr/layout/run.tcl

#FP
source ../../scr/layout/load_design.tcl
source ../../scr/layout/set_fp.tcl
source ../../scr/layout/pins_placement.tcl
source ../../scr/layout/pg_net.tcl
source ../../scr/layout/taps.tcl

#place
source ../../scr/layout/place.tcl

#cts
source ../../scr/layout/cts.tcl

#route
source ../../scr/layout/route.tcl

#finish
source ../../scr/layout/finish.tcl
