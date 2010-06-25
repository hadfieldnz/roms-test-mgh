%
% Script to plot the R4D-Var increments.
%

clear
close all

Cp=3985.0;
rho0=1025.0;

Inpb='../R4DVAR/wc13_fwd_000.nc';
Inpa='../R4DVAR/wc13_fwd_001.nc';
Inpr='../R4DVAR/wc13_irp.nc';

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

zetab=nc_read(Inpb,'zeta');
ub   =nc_read(Inpb,'u');
vb   =nc_read(Inpb,'v');
tempb=nc_read(Inpb,'temp');
saltb=nc_read(Inpb,'salt');

zetaa=nc_read(Inpa,'zeta');
ua   =nc_read(Inpa,'u');
va   =nc_read(Inpa,'v');
tempa=nc_read(Inpa,'temp');
salta=nc_read(Inpa,'salt');

difftx=nc_read(Inpr,'sustr',2);       % Need to read record 2
diffty=nc_read(Inpr,'svstr',2);       % record 1 is zero
diffqh=nc_read(Inpr,'shflux',2);      % we need to check this

diffz=zetaa-zetab;
diffu=ua-ub;
diffv=va-vb;
difft=tempa-tempb;
diffs=salta-saltb;

indr=find(maskr==0);
indu=find(masku==0);
indv=find(maskv==0);

diffz(indr)=NaN;
for k=1:size(difft,3)
  a(:,:)=difft(:,:,k);
  a(indr)=NaN;
  difft(:,:,k)=a(:,:);
  clear a;
  a(:,:)=diffs(:,:,k);
  a(indr)=NaN;
  diffs(:,:,k)=a(:,:);
  clear a;
  a(:,:)=diffu(:,:,k);
  a(indu)=NaN;
  diffu(:,:,k)=a(:,:);
  clear a;
  a(:,:)=diffv(:,:,k);
  a(indv)=NaN;
  diffv(:,:,k)=a(:,:);
  clear a;
end
for k=1:size(difftx,3)
  a(:,:)=difftx(:,:,k);
  a(indu)=NaN;
  difftx(:,:,k)=a(:,:);
  clear a;
  a(:,:)=diffty(:,:,k);
  a(indv)=NaN;
  diffty(:,:,k)=a(:,:);
  clear a;
  a(:,:)=diffqh(:,:,k);
  a(indr)=NaN;
  diffqh(:,:,k)=a(:,:);
  clear a;
end

figure

subplot(3,2,1)
pcolor(lonr,latr,diffz(:,:,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('\zeta increment')

subplot(3,2,2)
pcolor(lonu,latu,diffu(:,:,30,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('u increment')

subplot(3,2,3)
pcolor(lonv,latv,diffv(:,:,30,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('v increment')

subplot(3,2,4)
pcolor(lonr,latr,difft(:,:,30,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('T increment')
subplot(3,2,5)
pcolor(lonr,latr,diffs(:,:,30,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('S increment')

print -dpng -r300 plot_r4dvar_increments_page1.png

figure

subplot(3,2,1)
pcolor(lonu,latu,rho0.*difftx(:,:,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('\tau_x increment')

subplot(3,2,2)
pcolor(lonv,latv,rho0.*diffty(:,:,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('\tau_y increment')

subplot(3,2,3)
pcolor(lonr,latr,(rho0*Cp).*diffqh(:,:,1)); shading interp; colorbar
hold on
plot(coast.lon,coast.lat,'k')
title('Q increment')

print -dpng -r300 plot_r4dvar_increments_page2.png

