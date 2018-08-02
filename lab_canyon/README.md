# README for the the ROMS test upwelling case

## Mark Hadfield, 2018-08-02

This case is built with the roms_build script:

https://github.com/hadfieldnz/roms-scripts-mgh/blob/master/roms_build

The simulation-specific environment variables required by roms_build are
specified in the build-environment file, .build_env.

To build and run the case, set up host-specific variables like FORT and the
NETCDF variables, and then invoke

  * "roms_build" followed by "run-serial" to build and run a serial executable
  * "roms_build -o" followed by "run-openmp" to build and run an OpenMP executable
  * "roms_build -m" followed by "run-mpi" to build and run an MPI executable


