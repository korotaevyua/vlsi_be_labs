set_cmd_units -time ns -capacitance pF -current mA -voltage V -resistance kOhm -distance um
 
define_corners typical

read_lef /home/ykorotaev/lab/skywater-pdk/libraries/skywater-pdk-libs-sky130_fd_sc_hd/tech/sky130_fd_sc_hd.tlef

source /home/ykorotaev/lab/skywater-pdk/libraries/skywater-pdk-libs-sky130_fd_sc_hd/lefs

read_liberty -corner typical sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog test.v
link_design seven_segment_seconds

read_sdc test.sdc

##CORE 0.28 3.92

initialize_floorplan \
-site unithd \
-core_area "0 0 100 100" \
-die_area "0 0 100 100"


make_tracks

 
