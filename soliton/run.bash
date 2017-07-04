#!/bin/bash

# MGH 2012-01-20
#   A script to run the SOLITON case and save the output. Before running
#   this script, build the executable with build.bash

./oceanS < ocean_soliton.in | tee ocean_soliton.log
