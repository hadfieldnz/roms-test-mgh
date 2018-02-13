# README for the the ROMS test upwellking case

## Mark Hadfield, 2018-02-13

This case is built with the roms_build script:

https://github.com/hadfieldnz/roms-scripts-mgh/blob/master/roms_build

The simulation-specific environment variables required by roms_build are
specified in the file build_parameters.

To build and run the case, set up host-specific variables like FORT and the
NETCDF variables, and invoke run.bash, which calls roms_build to build the
executable and then runs it.


