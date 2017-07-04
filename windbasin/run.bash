#!/bin/bash

# MGH 2012-01-20
#   A script to run the WINDBASIN case and save the output. Before running
#   this script, build the executable with build.bash

./oceanS < ocean_windbasin.in | tee ocean_windbasin.log
