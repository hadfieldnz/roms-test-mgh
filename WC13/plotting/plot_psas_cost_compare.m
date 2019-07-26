%
% PLOT_PSAS_COST_COMPARE:  Plots 4D-PSAS cost function comparison
%                          with different minimization algorithms
%                          and primal formulation (I4D-Var)
%

% svn $Id$
%=========================================================================%
%  Copyright (c) 2002-2019 The ROMS/TOMS Group                            %
%    Licensed under a MIT/X style license                                 %
%    See License_ROMS.txt                                                 %
%=========================================================================%

clear                                  % clear workspace

SINGLE_PLOT=true;                      % Plot all outer-loop together
PRINT=true;                            % switch to save figure as PNG

ymax=3;                                % Y-axis limit for log10 scale.

% Set input NetCDF files.

Inp1='../PSAS/EX3_CONGRA/wc13_mod.nc';      % W4D-PSAS default
Inp2='../PSAS/EX3_MINRES/wc13_mod.nc';      % W4D-PSAS MINRES
Inp3='../PSAS/EX3_RPCG/wc13_mod.nc';        % W4D-PSAS RPCG
Inp4='../I4DVAR/EX1/wc13_mod.nc';           % I4D-Var

% Read in dual cost function variables.

% Default PSAS

Jo1 =nc_read(Inp1,'Jobs',[],NaN);        % observation cost function
Jb1 =nc_read(Inp1,'Jb',[],NaN);          % background cost function
J1  =nc_read(Inp1,'Jact',[],NaN);        % total cost function
JNL1=nc_read(Inp1,'NL_fDataPenalty');    % final NL model data penalty

% PSAS with MINRES

Jo2 =nc_read(Inp2,'Jobs',[],NaN);        % observation cost function
Jb2 =nc_read(Inp2,'Jb',[],NaN);          % background cost function
J2  =nc_read(Inp2,'Jact',[],NaN);        % total cost function
JNL2=nc_read(Inp2,'NL_fDataPenalty');    % final NL model data penalty

% PSAS with RPCG

Jo3 =nc_read(Inp3,'Jobs',[],NaN);        % observation cost function
Jb3 =nc_read(Inp3,'Jb',[],NaN);          % background cost function
J3  =nc_read(Inp3,'Jact',[],NaN);        % total cost function
JNL3=nc_read(Inp3,'NL_fDataPenalty');    % final NL model data penalty

% Read in primal (I4D-Var) cost function variables.

Jop =nc_read(Inp4,'TLcost_function');    % observation cost function
Jbp =nc_read(Inp4,'back_function');      % background  cost function
JNLp=nc_read(Inp4,'NLcost_function');    % nonlinar model misfit
Jp  =Jop+Jbp;                            % total cost function

%Jo(1,:)=NaN;
%Jb(1,:)=NaN;
%J (1,:)=NaN;

Jo1=Jo1./2;                              % Need to divide by 2
Jb1=Jb1./2;                              % because of definition
J1=J1./2;                                % of penalty functional
JNL1=JNL1./2;

Jo2=Jo2./2;                              % Need to divide by 2
Jb2=Jb2./2;                              % because of definition
J2=J2./2;                                % of penalty functional
JNL2=JNL2./2;

Jo3=Jo3./2;                              % Need to divide by 2
Jb3=Jb3./2;                              % because of definition
J3=J3./2;                                % of penalty functional
JNL3=JNL3./2;

[Niter,Nouter]=size(Jo1);                % number of 4D-Var iterations

% Compute theoretical minimum cost function value (Nobs/2).  Find number
% of bounded 4D-Var observations by counting nonzero values of the
% screening flag (obs_scale).

obs_scale=nc_read(Inp3,'obs_scale');
Nobs=length(nonzeros(obs_scale));

Jmin=Nobs/2;

% Plot cost functions.

if (SINGLE_PLOT),

  figure;
  plot(log10(squeeze(J1 (:))),'k','LineWidth',2);
  hold on;
  plot(log10(squeeze(J2(:))),'b','LineWidth',2);
  plot(log10(squeeze(J3(2:end))),'r','LineWidth',2);
  h=plot(log10(squeeze(Jp(:))),'s','LineWidth',1, ...
         'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',6);

  axis([1 Niter*Nouter-1 ymax max(log10(J1(:)))]);

  legend('PSAS','MINRES','RPCG','I4DVAR','Location','Northeast');
  title(['WC13: W4D-PSAS Cost Functions, outer loops = ', num2str(1:Nouter)]);
  ylabel('log_{10}(J)');
  xlabel('Iteration number');
  grid on;
  hold off;

  if (PRINT)
    print -dpng -r300 plot_psas_cost.png
  end

else

  for outer=1:Nouter
    figure;
    plot(log10(squeeze(J1 (:,outer))),'k','LineWidth',2);
    hold on;
    plot(log10(squeeze(J2(:,outer))),'b','LineWidth',2);
    plot(log10(squeeze(J3(2:end,outer))),'r','LineWidth',2);
    plot(log10(squeeze(Jp(:,outer))),'ko','LineWidth',2, ...
         'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);


    axis([1 Niter-1 ymax max(log10(J1(:)))]);

    legend('PSAS','MINRES','RPCG','I4DVAR','Location','Northeast');
    title(['WC13: Cost Functions, outer loop = ', num2str(outer)]);
    ylabel('log_{10}(J)');
    xlabel('Iteration number');
    grid on;
    hold off;

    if (PRINT),
      print -dpng -r300 plot_psas_cost.png
    end
  end

end
