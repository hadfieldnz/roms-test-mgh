#! /bin/bash

# MGH 2018-10-04
#   A script to run the ROMS BASIN case in MPI mode under SLURM on the NeSI
#   system Maui and save the output.

#SBATCH --partition=nesi_research
#SBATCH --job-name=ROMS
#SBATCH --output=basin_slurm.log
#SBATCH --error=basin_slurm.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=06:00:00
#SBATCH --share
#SBATCH --hint=nomultithread

if test ! -f romsM
then
  echo The romsM executable is missing: build it with \"roms_build -m\"
  exit 1
fi

date
srun ./romsM roms_basin.in
date
