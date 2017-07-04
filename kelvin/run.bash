#!/bin/bash

# MGH 2011-05-18
#   A script to run the KELVIN case and save the output. Before running
#   this script, build the executable with build.bash

./oceanS < ocean_kelvin.in | tee ocean_kelvin.log
