#!/bin/csh -f
#
# svn $Id$
#######################################################################
# Copyright (c) 2002-2020 The ROMS/TOMS Group                         #
#   Licensed under a MIT/X style license                              #
#   See License_ROMS.txt                                              #
#######################################################################
#                                                                     #
# Strong/Weak constraint 4D-PSAS forecast observation impact job      #
# CSH script:                                                         #
#                                                                     #
# This script NEEDS to be run before any run:                         #
#                                                                     #
#   (1) It copies a new clean nonlinear model initial conditions      #
#       file. The nonlinear model is initialized from the previous    #
#       cycle 4D-PSAS analysis.                                       #
#   (2) Sets the observation file to carry out VERIFICATION, which    #
#       interpolates NLM forecast at the observation locations.       #
#   (3) Copy a clean copy of the observations NetCDF file.            #
#   (4) Create 4D-Var input script "psas.in" from template and        #
#       specify observation file to be used.                          #
#                                                                     #
#######################################################################

# Set path definition to two directories up in the tree.

 set Dir=`dirname ${PWD}`
 set Dir=`dirname ${Dir}`

# Set string manipulations perl script.

 set SUBSTITUTE=${ROMS_ROOT}/ROMS/Bin/substitute

# Copy nonlinear model initial conditions file.

 cp -p ${Dir}/PSAS/EX3_RPCG/wc13_dai.nc wc13_ini.nc

# Set observations file for verification.

 set OBSname=forecast_obs.nc

# Get a clean copy of the observation file.  This is really
# important since this file is modified.

 cp -p ${Dir}/Data/${OBSname} .

# Modify 4D-Var template input script and specify above files

 set PSAS=psas.in
 if (-e $PSAS) then
   /bin/rm $PSAS
 endif
 cp s4dvar.in $PSAS

 $SUBSTITUTE $PSAS roms_obs.nc $OBSname
 $SUBSTITUTE $PSAS roms_mod.nc wc13_mod.nc
