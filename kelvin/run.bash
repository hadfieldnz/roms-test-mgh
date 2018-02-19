#!/bin/bash

# MGH 2018-02-20
#   A script to run the KELVIN case and save the output. Before running
#   this script, build the executable with roms_build

./ocean < ocean_kelvin.in | tee ocean_kelvin.log
