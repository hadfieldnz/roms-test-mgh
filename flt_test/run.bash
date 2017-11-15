#!/bin/bash

# MGH 2011-05-19
#   A script to run the FLT_TEST (3D) case and save the output. Before running
#   this script, build the executable with build.bash

./oceanS < ocean_flt_test3d.in | tee ocean_flt_test3d.log
