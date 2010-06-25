%
% Script to plot the chosen array mode.
%

clear
close all

Inpa='../ARRAY_MODES/wc13_tlm_003.nc';

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

zetaa  =nc_read(Inpa,'zeta');
ua     =nc_read(Inpa,'u');
va     =nc_read(Inpa,'v');
tempa  =nc_read(Inpa,'temp');
salta  =nc_read(Inpa,'salt');
sustra =nc_read(Inpa,'sustr');
svstra =nc_read(Inpa,'svstr');
shfluxa=nc_read(Inpa,'shflux');

indr=find(maskr==0);
indu=find(masku==0);
indv=find(maskv==0);

for l=1:size(tempa,4)
  a(:,:)=zetaa(:,:,l);
  a(indr)=NaN;
  zetaa(:,:,l)=a(:,:);
  clear a;
  for k=1:size(tempa,3)
    a(:,:)=tempa(:,:,k,l);
    a(indr)=NaN;
    tempa(:,:,k)=a(:,:);
    clear a;
    a(:,:)=salta(:,:,k,l);
    a(indr)=NaN;
    salta(:,:,k,l)=a(:,:);
    clear a;
    a(:,:)=ua(:,:,k,l);
    a(indu)=NaN;
    ua(:,:,k,l)=a(:,:);
    clear a;
    a(:,:)=va(:,:,k,l);
    a(indv)=NaN;
    va(:,:,k,l)=a(:,:);
    clear a;
  end
end

figure

for iplt=1:5
subplot(3,2,iplt)
 pcolor(lonr,latr,zetaa(:,:,iplt)); shading flat; colorbar
 hold on
 plot(coast.lon,coast.lat,'k')
 title(['\zeta time=',num2str(iplt-1,1),' days'])
end

print -dpng -r300 plot_array_modes.png

