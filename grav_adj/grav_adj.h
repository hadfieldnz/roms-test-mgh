/*
** svn $Id$
*******************************************************************************
** Copyright (c) 2002-2021 The ROMS/TOMS Group                               **
**   Licensed under a MIT/X style license                                    **
**   See License_ROMS.txt                                                    **
*******************************************************************************
**
** Options for Gravitational Adjustment Test.
**
** Application flag:   GRAV_ADJ
** Input script:       roms_grav_adj.in
*/

#define UV_ADV
#define UV_LDRAG
#define DJ_GRADPS
#define SOLVE3D
#define SPLINES_VDIFF
#define SPLINES_VVISC
#define ANA_GRID
#define ANA_INITIAL
#define ANA_SMFLUX
#define ANA_STFLUX
#define ANA_BTFLUX
