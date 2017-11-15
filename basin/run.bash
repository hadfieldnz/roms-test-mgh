#!/bin/bash

# MGH 2011-06-28
#   A script to run the BASIN case and save the output. Before running
#   this script, build the executable with build.bash

mpirun -np 4 ./oceanM ocean_basin.in | tee basin.log
