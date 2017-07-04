#!/bin/bash

# MGH 2011-05-18
#   A script to run the ESTUARY_TEST case and save the output. Before running
#   this script, build the executable with build.bash

./oceanS < ocean_estuary_test.in | tee estuary_test.log
