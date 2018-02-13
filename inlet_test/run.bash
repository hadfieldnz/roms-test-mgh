#!/bin/bash

# MGH 2011-05-18
#   A script to run the INLET_TEST case and save the output. Before running
#   this script, build the executable with build.bash
# MGH 2018-02-14
#   The executable should now be built with "roms_build -m", using environment
#   variables set in .build_env. The executable name is now "ocean".

mpirun -np 2 ./ocean coupling_inlet_test.in | tee inlet_test.log
