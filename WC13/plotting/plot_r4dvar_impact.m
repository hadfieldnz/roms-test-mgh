%
% This script plots the observation impact for R4D-Var.
%

clear
close all

% Prior circulation history file.

Inp0='../R4DVAR/wc13_tlm_001.nc';

% Posterior circulation history file.

Inp1='../R4DVAR/wc13_fwd_001.nc';

% Adjoint forcing file (dI/dx).

Inpa='../R4DVAR_impact/wc13_ads.nc';

% Observation file.

Obs='../Data/wc13_obs.nc';

% R4D-Var impact mod file.

Mod='../R4DVAR_impact/wc13_mod.nc';

% R4D-Var mod file.

RPMFile='../R4DVAR/wc13_mod.nc';

% Read transport weights.

varr=nc_read(Inpa,'v');

% Read prior velocity.

vb=nc_read(Inp0,'v');

% Read posterior velocity.

va=nc_read(Inp1,'v');

% Prior transport (Sv).

transb=nansum(nansum(nansum(nansum(varr.*vb,1),2),3),4);

% Posterior transport (Sv).

transa=nansum(nansum(nansum(nansum(varr.*va,1),2),3),4);

% Actual transport increment (Sv).

dtrans=transa-transb;

% Read observations.

obs  =nc_read(Obs,'obs_value');
type =nc_read(Obs,'obs_type');
label=nc_read(Obs,'obs_provenance');

% Read observation impacts.

sen  =nc_read(Mod,'ObsImpact_total');      % total
icsen=nc_read(Mod,'ObsImpact_IC');         % initial conditions
fcsen=nc_read(Mod,'ObsImpact_FC');         % surface forcing
bcsen=nc_read(Mod,'ObsImpact_BC');         % open boundary conditions

% Read observation scale (bounded observations, obs_scale=1).

scale=nc_read(Mod,'obs_scale');

% Read NL model values in observation space.

RPM=nc_read(RPMFile,'RPmodel_initial');

% Compute the innovation vector.

innov=(obs-RPM).*scale;

% Sort by observation platform using label.

ind1=find(label==1);  % SSH
ind2=find(label==2);  % SST
ind3=find(label==3);  % T XBT
ind4=find(label==4);  % T CTD
ind5=find(label==5);  % S CTD
ind6=find(label==6);  % T Argo
ind7=find(label==7);  % S Argo

% Compute total impacts.

totimp=sum(sen.*innov,1);
icimp=sum(icsen.*innov,1);
fcimp=sum(fcsen.*innov,1);
bcimp=sum(bcsen.*innov,1);

timp1=sum(sen(ind1).*innov(ind1),1);
timp2=sum(sen(ind2).*innov(ind2),1);
timp3=sum(sen(ind3).*innov(ind3),1);
timp4=sum(sen(ind4).*innov(ind4),1);
timp5=sum(sen(ind5).*innov(ind5),1);
timp6=sum(sen(ind6).*innov(ind6),1);
timp7=sum(sen(ind7).*innov(ind7),1);

% Check.

timp=timp1+timp2+timp3+timp4+timp5+timp6+timp7;

% Plot

fonts=10;
yt=0.08;

figure

subplot(3,1,1)
dn=[size(obs,1) size(ind1,1) size(ind2,1) size(ind3,1) size(ind4,1) size(ind5,1) ...
    size(ind6,1) size(ind7,1)];
bar(dn)
MyLabel={'Nobs','SSH','SST','T XBT','T CTD','S CTD','T Argo','S Argo'};
set(gca,'XTickLabel',MyLabel,'FontSize',fonts);
ylabel('\Delta I')

subplot(3,1,2)
d1=[dtrans totimp icimp fcimp bcimp];
bar(d1)
colormap([1 0 0]);

%text(1,yt,'\Delta I','FontSize',fonts,'HorizontalAlignment','center')
%text(2,yt,'\delta I','FontSize',fonts,'HorizontalAlignment','center')
%text(3,yt,'IC','FontSize',fonts,'HorizontalAlignment','center')
%text(4,yt,'FC','FontSize',fonts,'HorizontalAlignment','center')
%text(5,yt,'BC','FontSize',fonts,'HorizontalAlignment','center')

MyLabel={'RP dI','TL dI','IC','FC','BC'};
set(gca,'XTickLabel',MyLabel,'FontSize',fonts);
ylabel('\Delta I')

subplot(3,1,3)
d2=[totimp timp1 timp2 timp3 timp4 timp5 timp6 timp7];
bar(d2)
colormap([1 0 0]);

fonts=10;

%text(1,yt,'\Delta I','FontSize',fonts,'HorizontalAlignment','center')
%text(2,yt,'SSH','FontSize',fonts,'HorizontalAlignment','center')
%text(3,yt,'SST','FontSize',fonts,'HorizontalAlignment','center')
%text(4,yt,'T XBT','FontSize',fonts,'HorizontalAlignment','center')
%text(5,yt,'T CTD','FontSize',fonts,'HorizontalAlignment','center')
%text(6,yt,'S CTD','FontSize',fonts,'HorizontalAlignment','center')
%text(7,yt,'T Argo','FontSize',fonts,'HorizontalAlignment','center')
%text(8,yt,'S Argo','FontSize',fonts,'HorizontalAlignment','center')

MyLabel={'TL dI','SSH','SST','T XBT','T CTD','S CTD','T Argo','S Argo'};
set(gca,'XTickLabel',MyLabel,'FontSize',fonts);
ylabel('\Delta I')

print -dpng -r300 plot_r4dvar_impact.png

