%
% Script to plot an EOF of the analysis error covariance matrix.
%

clear
close all

% Choose EOF number.

neof=1;

Inp='../R4DVAR/wc13_hss.nc';

Grd='../Data/wc13_grd.nc';

coast = load('../Data/wc13_cst.mat','-mat');

lonr=nc_read(Grd,'lon_rho');
latr=nc_read(Grd,'lat_rho');
lonu=nc_read(Grd,'lon_u');
latu=nc_read(Grd,'lat_u');
lonv=nc_read(Grd,'lon_v');
latv=nc_read(Grd,'lat_v');

maskr=nc_read(Grd,'mask_rho');
masku=nc_read(Grd,'mask_u');
maskv=nc_read(Grd,'mask_v');

zeta  =nc_read(Inp,'zeta',neof);
u     =nc_read(Inp,'u',neof);
v     =nc_read(Inp,'v',neof);
temp  =nc_read(Inp,'temp',neof);
salt  =nc_read(Inp,'salt',neof);
sustr =nc_read(Inp,'sustr',neof);
svstr =nc_read(Inp,'svstr',neof);
shflux=nc_read(Inp,'shflux',neof);

indr=find(maskr==0);
indu=find(masku==0);
indv=find(maskv==0);

zeta(indr)=NaN;
for k=1:size(temp,3)
  a(:,:)=temp(:,:,k);
  a(indr)=NaN;
  temp(:,:,k)=a(:,:);
  clear a;
  a(:,:)=salt(:,:,k);
  a(indr)=NaN;
  salt(:,:,k)=a(:,:);
  clear a;
  a(:,:)=u(:,:,k);
  a(indu)=NaN;
  u(:,:,k)=a(:,:);
  clear a;
  a(:,:)=v(:,:,k);
  a(indv)=NaN;
  v(:,:,k)=a(:,:);
  clear a;
end
for k=1:size(sustr,3)
  a(:,:)=sustr(:,:,k);
  a(indu)=NaN;
  sustr(:,:,k)=a(:,:);
  clear a;
  a(:,:)=svstr(:,:,k);
  a(indv)=NaN;
  svstr(:,:,k)=a(:,:);
  clear a;
  a(:,:)=shflux(:,:,k);
  a(indr)=NaN;
  shflux(:,:,k)=a(:,:);
  clear a;
end

figure

subplot(3,2,1)
pcolor(lonr,latr,zeta(:,:,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['\zeta, EOF ',num2str(neof,1)])

subplot(3,2,2)
pcolor(lonu,latu,u(:,:,30,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['u, EOF ',num2str(neof,1)])

subplot(3,2,3)
pcolor(lonv,latv,v(:,:,30,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['v, EOF ',num2str(neof,1)])

subplot(3,2,4)
pcolor(lonr,latr,temp(:,:,30,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['T, EOF ',num2str(neof,1)])

subplot(3,2,5)
pcolor(lonr,latr,salt(:,:,30,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['S, EOF ',num2str(neof,1)])

print -dpng -r300 plot_posterior_EOF_fields_page1.png

figure

subplot(3,2,1)
pcolor(lonu,latu,sustr(:,:,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['\tau_x, EOF ',num2str(neof,1)])

subplot(3,2,2)
pcolor(lonv,latv,svstr(:,:,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['\tau_y, EOF ',num2str(neof,1)])

subplot(3,2,3)
pcolor(lonr,latr,shflux(:,:,1)); shading flat; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title(['Q, EOF ',num2str(neof,1)])

print -dpng -r300 plot_posterior_EOF_fields_page2.png
