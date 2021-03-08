function [err] = error_estimate(a_run1,a_run2,a_run3,a_run4,a_run5,a_run6)
%Function to compute the error estimate amplitude in every run by using root mean
%square error.
x = [0 0.4 0.8 1.2];

a = zeros(4,6);
a(:,1) = a_run1; a(:,2) = a_run2; a(:,3) = a_run3; 
a(:,4) = a_run4; a(:,5) = a_run5; a(:,6) = a_run6;

m = length(a);

% Linear regression and RMSE
p = zeros(6,1);
val = zeros(4,6);
err = zeros(1);
for i = 1:m
    p_ = polyfit(x,a(:,i),1);
    val(:,i) = polyval(p_,x);
    p(i) = p_(1);
    err(i) = sqrt(sum((a(:,i) - val(:,i)).^2)/m); %RMSE
end
   
figure(2)
axis_size = 15;
fontSize1 = 20;
fontSize2 = 14;
plot(x,a(:,1),'+','LineWidth',2.2)
hold on
plot(x,val(:,1),'LineWidth',1)
hold on
plot(x,a(:,2),'*','LineWidth',2.2)
hold on
plot(x,val(:,2),'LineWidth',1)
hold on
plot(x,a(:,3),'o','LineWidth',2.2)
hold on
plot(x,val(:,3),'LineWidth',1)

set(gca,'fontsize',axis_size);
xlabel('$x[\textrm{m}]$','interpreter','latex','FontSize', fontSize1);
ylabel('$\textrm{a}[\textrm{m}]$','interpreter','latex','FontSize', fontSize1);
title('Linear regression of the amplitude from different gauges',...
    'FontSize',fontSize2)
legend('$\textrm{run 1}$','$\textrm{fitting 1}$',...
    '$\textrm{run 2}$','$\textrm{fitting 2}$',...
    '$\textrm{run 3}$','$\textrm{fitting 3}$',...
    'interpreter','latex','FontSize', fontSize2)
hold off

end

