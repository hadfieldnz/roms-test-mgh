#!/bin/bash

# MGH 2016-03-23
#   A script to run the LMD_TEST case and save the output. Before running
#   this script, build the executable with build.bash

./oceanS < ocean_lmd_test.in | tee ocean_lmd_test.log
