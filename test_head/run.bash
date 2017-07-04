#!/bin/bash

# MGH 2011-06-27
#   A script to run the TEST_HEAD case and save the output. Before running
#   this script, build the executable with build.bash

mpirun -np 2 ./oceanM coupling_test_head.in | tee test_head.log
