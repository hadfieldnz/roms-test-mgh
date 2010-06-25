%
% This script plots the eigenvalues for each EOF of the analysis
% error covariance matrix, and the randomized race estimates
%

clear
close all

Inp='../R4DVAR/wc13_hss.nc';

Ritz=nc_read(Inp,'Ritz');
Ritz_error=nc_read(Inp,'Ritz_error');
ae_trace=nc_read(Inp,'ae_trace');

figure

subplot(3,1,1)
plot(Ritz,'r','LineWidth',2)
xlabel('EOF number (i)')
ylabel('\lambda_i')
title('Eigenvalues')

subplot(3,1,2)
plot(log10(Ritz_error),'b','LineWidth',2)
xlabel('EOF number (i)')
ylabel('log_{10}(\epsilon_i)')
title('Eigenvalue Error')

subplot(3,1,3)
plot(ae_trace(2:end),'k','LineWidth',2)
xlabel('Randomized Sample Number')
ylabel('Tr(E^a)')
title('Randomized Trace Estimates')

print -r300 -dpng plot_eof_eigenvalues.png


