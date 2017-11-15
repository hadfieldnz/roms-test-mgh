#!/bin/bash

# MGH 2011-06-29
#   A script to run the SED_TEST case and save the output. Before running
#   this script, build the executable with build.bash

nice ./oceanS < ocean_sed_test1.in | tee sed_test1.log
