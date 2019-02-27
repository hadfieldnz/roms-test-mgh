#! /bin/bash

# MGH 2018-10-04
#   A script to run the ROMS BASIN case in MPI mode under SLURM on the NeSI
#   system Maui and save the output.

#SBATCH --partition=nesi_research
#SBATCH --job-name=ROMS
#SBATCH --output=inlet_test_slurm.log
#SBATCH --error=inlet_test_slurm.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --time=01:00:00
#SBATCH --share
#SBATCH --hint=nomultithread

if test ! -f romsM
then
  echo The romsM executable is missing: build it with \"roms_build -m\"
  exit 1
fi

date
srun ./romsM coupling_inlet_test.in
date
