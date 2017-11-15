#!/bin/bash

# MGH 2011-06-29
#   A script to run the SHOREFACE case and save the output. Before running
#   this script, build the executable with build.bash

mpirun -np 2 ./oceanM ocean_shoreface.in | tee shoreface.log
