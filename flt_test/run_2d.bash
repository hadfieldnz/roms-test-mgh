#!/bin/bash

# MGH 2018-02-20
#   A script to run the FLT_TEST (2D) case and save the output. Before running
#   this script, build the executable with "roms_build -b .build_env_2d"

./ocean < ocean_flt_test2d.in | tee ocean_flt_test2d.log
