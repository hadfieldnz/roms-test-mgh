%
% PLOT_PSAS_ANALYSIS_SENSITIVITY:  Plots observation sensitivity for
%                                  4D-PSAS
%

% svn $Id$
%=========================================================================%
%  Copyright (c) 2002-2020 The ROMS/TOMS Group                            %
%    Licensed under a MIT/X style license                                 %
%    See License_ROMS.txt                                                 %
%=========================================================================%

clear                                  % clear workspace

PRINT=true;                            % switch to save figure as PNG

% Set input NetCDF files.
%
%   Inp0:   PSAS prior circulation file, Exercise 03
%   Inp1:   PSAS posterior circulation file, Exercise 03
%   Inpa:   adjoint forcing file (dI/dx), Exercise 06
%   Obs:    observation file
%   Mod:    4D-PSAS impact file, Exercise 06
%   NLmod:  4D-PSAS file, Exercise 03

Inp0 ='../PSAS/EX3_RPCG/wc13_fwd_000.nc';
Inp1 ='../PSAS/EX3_RPCG/wc13_fwd_001.nc';
Inpa ='../PSAS_analysis_sensitivity/EX6/wc13_ads.nc';
Obs  ='../Data/wc13_obs.nc';
Mod  ='../PSAS_analysis_sensitivity/EX6/wc13_mod.nc';
NLmod='../PSAS/EX3_RPCG/wc13_mod.nc';

% Read in impact variables.

varr=ncread(Inpa,'v');                     % transport weights
vb  =ncread(Inp0,'v');                     % prior velocity
va  =ncread(Inp1,'v');                     % posterior velocity

% Compute transports (Sv).

transb=nansum(nansum(nansum(nansum(varr.*vb,1),2),3),4);  % prior
transa=nansum(nansum(nansum(nansum(varr.*va,1),2),3),4);  % posterior

dtrans=transa-transb;                      % actual transport increment

% Read observations variables.

obs  =ncread(Obs,'obs_value');             % observation values
type =ncread(Obs,'obs_type');              % state variable flag
label=ncread(Obs,'obs_provenance');        % observation origin

% Read total observation sensitivities.

sen=ncread(Mod,'ObsSens_total');

% Read observation scale (bounded observations, scale=1).

scale=ncread(Mod,'obs_scale');

% Read NL model values in observation space.

NLM=ncread(NLmod,'NLmodel_initial');

% Compute the innovation vector.

innov=(obs-NLM).*scale;

% Sort by observation platform using label.

ind1=find(label==1);      % SSH
ind2=find(label==2);      % SST
ind3=find(label==3);      % T XBT
ind4=find(label==4);      % T CTD
ind5=find(label==5);      % S CTD
ind6=find(label==6);      % T Argo
ind7=find(label==7);      % S Argo

% Compute total sensitivities assuming a change dy=-d.

totimp=sum(sen.*innov,1);

timp1=sum(sen(ind1).*innov(ind1),1);
timp2=sum(sen(ind2).*innov(ind2),1);
timp3=sum(sen(ind3).*innov(ind3),1);
timp4=sum(sen(ind4).*innov(ind4),1);
timp5=sum(sen(ind5).*innov(ind5),1);
timp6=sum(sen(ind6).*innov(ind6),1);
timp7=sum(sen(ind7).*innov(ind7),1);

% Check.

timp=timp1+timp2+timp3+timp4+timp5+timp6+timp7;

% Plot observation sensitivity.

figure;

fonts=10;

subplot(3,1,1);
dn=[length(obs) length(ind1) length(ind2) length(ind3) length(ind4) ...
                length(ind5) length(ind6) length(ind7)];
b1=bar(dn,'r');
Y=b1.YData;
text(1:length(Y),Y,num2str(Y'),'vert','bottom','horiz','center');
grid on;
MyLabel={'Nobs','SSH','SST','T XBT','T CTD','S CTD','T Argo','S Argo'};
set(gca,'XTickLabel',MyLabel,'FontSize',fonts);
ylabel('N_{obs}');
title('4D-PSAS Analysis Observation Sensitivity');

subplot(3,1,2);
d2=[dtrans totimp timp1 timp2 timp3 timp4 timp5 timp6 timp7];
b2=bar(d2,'m');
grid on;
MyLabel={'NL dI','TL dI','SSH','SST','T XBT','T CTD','S CTD','T Argo','S Argo'};
set(gca,'XTickLabel',MyLabel,'FontSize',fonts);
ylabel('\Delta I');

if (PRINT)
  png_file='plot_psas_sensitivity.png';
  print(png_file, '-dpng', '-r300');
  if (exist('/opt/local/bin/convert','file'))
    unix(['/opt/local/bin/convert -verbose -crop 2100x1132+100+45',     ...
          ' +repage ', png_file, blanks(1), png_file]);
  end 
end
