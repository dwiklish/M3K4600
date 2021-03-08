function [slope] = calibration(calneg4,calneg2,cal0,calpos2,calpos4)
% Calibration function to compute the slope of linear regression. 
% The imput argument must be matrix.
% The value is use to plot the line 

x = [-4 -2 0 2 4]/100;

% Compute the mean value in every position
mean_calineg4 = zeros(1);
mean_calineg2 = zeros(1);
mean_cali0 = zeros(1);
mean_calipos2 = zeros(1);
mean_calipos4 = zeros(1);

for i=1:4  
  mean_calineg4(i) = mean(calneg4(:,i+4));
  mean_calineg2(i) = mean(calneg2(:,i+4));
  mean_cali0(i) = mean(cal0(:,i+4));
  mean_calipos2(i) = mean(calpos2(:,i+4));
  mean_calipos4(i) = mean(calpos4(:,i+4));
end

cal_mean = zeros(4,5);
cal_mean(:,1) = mean_calineg4;
cal_mean(:,2) = mean_calineg2;
cal_mean(:,3) = mean_cali0;
cal_mean(:,4) = mean_calipos2;
cal_mean(:,5) = mean_calipos4;

probe = cal_mean;

p = polyfit(x,probe(1,:),1);
val = polyval(p,x);
slope = p(1);

figure(1)
plot(x,probe(1,:),'+','LineWidth',1)
hold on 
plot(x,probe(2,:),'.','LineWidth',1)
hold on
plot(x,probe(3,:),'o','LineWidth',1)
hold on
plot(x,probe(4,:),'*','LineWidth',1)
hold on
plot(x,val,'LineWidth',1)
axis_size = 15;
fontSize1 = 20;
fontSize2 = 14;
set(gca,'fontsize',axis_size);
xlabel('$x[\textrm{m}]$','interpreter','latex','FontSize', fontSize1);
ylabel('$\textrm{Voltage}[\textrm{V}]$','interpreter','latex','FontSize', fontSize1);
title('Gauges calibration','FontSize', fontSize2)
legend('Probe 1', 'Probe 2','Probe 3', 'Probe 4','linear','FontSize', fontSize2)
hold off
end

