# README for the the ROMS test LMD_TEST case

## Mark Hadfield, 2018-09-03

This case is built with the roms_build script:

https://github.com/hadfieldnz/roms-scripts-mgh/blob/master/roms_build

The simulation-specific environment variables required by roms_build are
specified in the build-environment file, .build_env.

To build and run the case, set up host-specific variables like FORT and the
NETCDF variables, and then invoke

  * "roms_build" followed by "run-serial" to build and run a serial executable

OpenMP and MPI runs are not supported, because the domain is only 10x10.

