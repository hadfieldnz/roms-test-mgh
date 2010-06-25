%
% Script to plot the I4DVAR cost function.
%

clear
close all

Inp='../R4DVAR/wc13_mod.nc';
Obs='../Data/wc13_obs.nc';

Jo=nc_read(Inp,'Jobs');
Jb=nc_read(Inp,'Jb');
J=nc_read(Inp,'Jact');
obs_value=nc_read(Obs,'obs_value');

Jmin=size(obs_value,1)/2;
iter=size(Jo,1);

Jo=Jo/2;
Jb=Jb/2;
J=J/2;

plot(log10(J),'k','LineWidth',2)
hold on
plot(log10(Jo),'b','LineWidth',2)
plot(log10(Jb),'r','LineWidth',2)
axis([1 iter 0 max(log10(J))]);

line([1 iter],[log10(Jmin) log10(Jmin)],'LineStyle','--','Color',[0 0 0])

legend('J','J_o','J_b','J_{min}','Location','Southeast')

title('R4D-Var Cost Function')
ylabel('log_{10}(J)')
xlabel('Iteration number')

print -dpng -r300 plot_r4dvar_cost.png
