###########################################
#set the block size
set X_size xxx
set Y_size yyy
###########################################

###########################################
initialize_floorplan \
-site unithd \
-core_area "0 0 $X_size $Y_size" \
-die_area "0 0 $X_size $Y_size"

make_tracks
###########################################
