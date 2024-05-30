set X_size 92.48
set Y_size 92.48

initialize_floorplan \
-site unithd \
-core_area "0 0 $X_size $Y_size" \
-die_area "0 0 $X_size $Y_size"

make_tracks

