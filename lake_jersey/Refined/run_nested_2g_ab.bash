#!/bin/bash

# MGH 2016-10-26
#   A script to run the LAKE_JERSEY Refined (nested_2g_ab) case in serial model and save the output.
#   Before running this script, build the executable with build.bash

./oceanS < ocean_lake_jersey_nested_2g_ab.in | tee ocean_lake_jersey_nested_2g_ab.log
