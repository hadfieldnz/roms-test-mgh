/*
** svn $Id$
*******************************************************************************
** Copyright (c) 2002-2012 The ROMS/TOMS Group                               **
**   Licensed under a MIT/X style license                                    **
**   See License_ROMS.txt                                                    **
*******************************************************************************
**
** Options for North Atlantic DAMEE Application, 3/4 degree resolution
**
** Application flag:   DAMEE_4
** Input script:       ocean_damee_4.in
*/

#define UV_ADV
#define UV_COR
#define UV_QDRAG
#define DJ_GRADPS
#ifdef TS_U3ADV_SPLIT
# define TS_DIF4
# define DIFF_GRID
# define MIX_GEO_TS
#endif
#ifdef UV_U3ADV_SPLIT
# define UV_VIS4
# define VISC_GRID
# define MIX_GEO_UV
#endif
#define NONLIN_EOS
#define SALINITY
#define SOLVE3D
#define MASKING
#define SPLINES
#define QCORRECTION
#define SRELAXATION
#define CURVGRID

#ifdef LMD_MIXING
# define LMD_RIMIX
# define LMD_CONVEC
# define LMD_SKPP
# define LMD_NONLOCAL
#endif

#define TCLIMATOLOGY
#define TCLM_NUDGING
#define ANA_BSFLUX
#define ANA_BTFLUX
