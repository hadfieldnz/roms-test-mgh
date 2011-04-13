/*
** svn $Id$
*******************************************************************************
** Copyright (c) 2002-2011 The ROMS/TOMS Group                               **
**   Licensed under a MIT/X style license                                    **
**   See License_ROMS.txt                                                    **
*******************************************************************************
**
** Options for Sediment Test Channel Case.
**
** Application flag:   TEST_CHAN
** Input scripts:      ocean_test_chan.in
**                     sediment_test_chan.in
*/

#define UV_ADV
#define UV_LOGDRAG
#define SOLVE3D
#define SPLINES

#define ANA_GRID
#define ANA_INITIAL
#define ANA_SMFLUX
#define ANA_STFLUX
#define ANA_BTFLUX
#ifdef SALINITY
# define ANA_SSFLUX
# define ANA_BSFLUX
#endif
#define ANA_SPFLUX
#define ANA_BPFLUX

#define NORTHERN_WALL
#define SOUTHERN_WALL
#define EAST_FSCHAPMAN
#define EAST_M2CLAMPED
#define EAST_M3GRADIENT
#define WEST_FSCHAPMAN
#define WEST_M2FLATHER
#define WEST_M3GRADIENT
#define ANA_FSOBC
#define ANA_M2OBC

#ifdef GLS_MIXING
# define KANTHA_CLAYSON
# define N2S2_HORAVG
#endif

#ifdef SEDIMENT
# define ANA_SEDIMENT
# define SUSPLOAD
#endif

