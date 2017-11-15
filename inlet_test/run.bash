#!/bin/bash

# MGH 2011-05-18
#   A script to run the INLET_TEST case and save the output. Before running
#   this script, build the executable with build.bash

mpirun -np 2 ./oceanM coupling_inlet_test.in | tee inlet_test.log
