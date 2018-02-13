#!/bin/bash

# MGH 2018-02-13
#   A script to build and run the UPWELLING case and save the output.

roms_build

./ocean < ocean_upwelling.in | tee ocean_upwelling.log
