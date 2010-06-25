%
% Script to plot the I4DVAR cost function.
%

clear
close all

Inp='../I4DVAR/wc13_mod.nc';
Obs='../Data/wc13_obs.nc';

Jo=nc_read(Inp,'TLcost_function');
Jb=nc_read(Inp,'back_function');
JNL=nc_read(Inp,'NLcost_function');
obs_value=nc_read(Obs,'obs_value');

Jmin=size(obs_value,1)/2;
iter=size(Jo,1);

J=Jo+Jb;

figure;

plot(log10(J),'k','LineWidth',2)
hold on
plot(log10(Jo),'b','LineWidth',2)
plot(log10(Jb),'r','LineWidth',2)
line([1 iter],[log10(Jmin) log10(Jmin)],'LineStyle','--','Color',[0 0 0],'LineWidth',2)
plot(iter,log10(JNL(1,end)+Jb(end)),'rx','LineWidth',2,'MarkerSize',10)

axis([1 iter 0 max(log10(J))]);

ylabel('log_{10}(J)')
xlabel('Iteration number')

legend('J','J_o','J_b','J_{min}','J_{NL}','Location','Southeast')

title('I4D-Var Cost Function')

print -dpng -r300 plot_i4dvar_cost.png
