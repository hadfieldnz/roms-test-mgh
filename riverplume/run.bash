#!/bin/bash

# MGH 2011-09-06
#   A script to run the RIVERPLUME1 case and save the output. Before running
#   this script, build the executable with build.bash

./oceanS < ocean_riverplume1.in | tee ocean_riverplume1.log
