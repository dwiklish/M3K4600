function [mean_amplitude_probe2,error_a_probe2] = estimate_error_amplitude(a_repeat1,a_repeat2,a_repeat3)
%Function to compute the error estimate amplitude of probe 2 with three 
%repeating experiments by using root mean square error.
N = [1 2 3];

a = zeros(3,4);
a(1,:) = a_repeat1; a(2,:) = a_repeat2; a(3,:) = a_repeat3; 


M = size(a);
m = M(2);

% Linear regression and RMSE
p = zeros(3,1);
val = zeros(3,4);
err_estimate_a = zeros(1);
mean_amplitude = zeros(1);
for i = 1:m
    p_ = polyfit(N,a(:,i),1);
    val(:,i) = polyval(p_,N);
    p(i) = p_(1);
    err_estimate_a(i) = sqrt(sum((a(:,i) - val(:,i)).^2)/m); %RMSE
    mean_amplitude(i) = mean(a(:,i));
end

error_a_probe2 = err_estimate_a(2);
mean_amplitude_probe2 = mean_amplitude(2);
%figure(19)
axis_size = 15;
fontSize1 = 20;
fontSize2 = 14;
plot(N,a(:,2),'+','LineWidth',2.2)
hold on
plot(N,val(:,2),'LineWidth',1)
hold on
set(gca,'fontsize',axis_size);
xlabel('$x[\textrm{m}]$','interpreter','latex','FontSize', fontSize1);
ylabel('$\textrm{a}[\textrm{m}]$','interpreter','latex','FontSize', fontSize1);
title('Linear regression of the amplitude from the second gauge',...
    'FontSize',fontSize2)
%legend('$\textrm{repeat run 1}$','interpreter','latex','FontSize', fontSize2)
%hold off

end

