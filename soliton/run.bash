#!/bin/bash

# MGH 2012-01-20
#   A script to run the SOLITON case and save the output. Before running
#   this script, build the executable with roms_build

./ocean < ocean_soliton.in | tee ocean_soliton.log
