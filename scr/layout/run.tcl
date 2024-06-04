#openroad -gui -log log.txt

#FP
source ../../scr/layout/load_design.tcl
source ../../scr/layout/set_fp.tcl
source ../../scr/layout/pins_placement.tcl
source ../../scr/layout/pg_net.tcl

#place
source ../../scr/layout/place.tcl

#cts
source ../../scr/layout/cts.tcl

#route
source ../../scr/layout/route.tcl
