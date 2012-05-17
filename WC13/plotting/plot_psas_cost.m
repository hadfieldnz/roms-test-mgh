%
% PLOT_PSAS_COST:  Plot 4D-PSAS cost function
%

% svn $Id$
%===========================================================================%
%  Copyright (c) 2002-2012 The ROMS/TOMS Group                              %
%    Licensed under a MIT/X style license                                   %
%    See License_ROMS.txt                                                   %
%===========================================================================%

clear                                  % clear workspace
close all                              % close all figures

PRINT=0;                               % switch to save figure as PNG

% Set input NetCDF files.

Inp='../PSAS/wc13_mod.nc';             % ROMS 4D-Var file

% Read in cost function variables.

Jo =nc_read(Inp,'Jobs');               % observation cost function
Jb =nc_read(Inp,'Jb');                 % background cost function
J  =nc_read(Inp,'Jact');               % total cost function
JNL=nc_read(Inp,'NL_fDataPenalty');    % final NL model data penalty

Jo=Jo./2;                              % Need to divide by 2
Jb=Jb./2;                              % because of definition
J=J./2;                                % of penalty functional
JNL=JNL./2;

Niter=length(Jo);                      % number of 4D-Var iterations

% Compute theoretical minimum cost function value (Nobs/2).  Find number
% of bounded 4D-Var observations by counting nonzero values of the
% screening flag (obs_scale).

obs_scale=nc_read(Inp,'obs_scale');
Nobs=length(nonzeros(obs_scale));

Jmin=Nobs/2;

% Plot cost functions.

plot(log10(J),'k','LineWidth',2);
hold on;
plot(log10(Jo),'b','LineWidth',2);
plot(log10(Jb),'r','LineWidth',2);
axis([1 Niter 0 max(log10(J))]);

line([1 Niter],[log10(Jmin) log10(Jmin)], ...
     'LineStyle','--','Color',[0 0 0],'LineWidth',2);
plot(Niter,log10(JNL(1,end)+Jb(end)),'rx','LineWidth',2,'MarkerSize',10);

legend('J','J_o','J_b','J_{min}','J_{NL}','Location','Southeast');

title('PSAS Cost Function');
ylabel('log_{10}(J)');
xlabel('Iteration number');

if (PRINT),
  print -dpng -r300 plot_psas_cost.png
end,
