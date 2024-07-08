###############################################
#Load tlef and DEF
lef read ../../lefs/sky130.tlef
gds read ../../skywater-pdk/libs.tech/sky130_fd_sc_hd.gds
 
def read ../layout/final.def -noblockage -labels
################################################
#Set size
set DIE_AREA "0.0 0.0 xxx yyy"

box [lindex $DIE_AREA 0]um [lindex $DIE_AREA 1]um [lindex $DIE_AREA 2]um [lindex $DIE_AREA 3]um
property FIXED_BBOX [box values]
################################################

################################################
#Write GDS

select top cell
cellname filepath seven_segment_seconds .
save

gds readonly true
gds rescale false

load seven_segment_seconds
select top cell

cif *hier write disable
cif *array write disable

gds nodatestamp yes
gds write seven_segment_seconds.gds
################################################


