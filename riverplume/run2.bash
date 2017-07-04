#!/bin/bash

# MGH 2011-09-06
#   A script to run the RIVERPLUME2 case and save the output. Before running
#   this script, build the executable with build2.bash

./oceanS < ocean_riverplume2.in | tee ocean_riverplume2.log
