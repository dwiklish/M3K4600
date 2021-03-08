addpath('/Users/kadekjensen/OneDrive - Universitetet i Oslo/Documents/UIO_kadek/Master/MEK 4600/Report 2/M3K4600/report_2/run1')
addpath('/Users/kadekjensen/OneDrive - Universitetet i Oslo/Documents/UIO_kadek/Master/MEK 4600/Report 2/M3K4600/report_2/run2')
addpath('/Users/kadekjensen/OneDrive - Universitetet i Oslo/Documents/UIO_kadek/Master/MEK 4600/Report 2/M3K4600/report_2/run3')
addpath('/Users/kadekjensen/OneDrive - Universitetet i Oslo/Documents/UIO_kadek/Master/MEK 4600/Report 2/M3K4600/report_2/run6')
addpath('/Users/kadekjensen/OneDrive - Universitetet i Oslo/Documents/UIO_kadek/Master/MEK 4600/Report 2/M3K4600/report_2/Gauge data repeat')
addpath('/Users/kadekjensen/OneDrive - Universitetet i Oslo/Documents/UIO_kadek/Master/MEK 4600/Report 2/M3K4600/report_2/data and function')
calneg4 = load('calibneg4.csv');
calneg2 = load('calibneg2.csv');
cal0 = load('calib0.csv');
calpos2 = load('calibpos2.csv');
calpos4 = load('calibpos4.csv');
run1 = 'test1_group2.csv';
run2 = 'test2_group2.csv';
run3 = 'test3_group2.csv';
run4 = 'test4_group2.csv';
run5 = 'test5_group2.csv';
run6 = 'test6_group2.csv';

% Repeat the experiment
repeat1_run1 = 'run1_repeat1_group2.csv';
repeat2_run1 = 'run1_repeat2_group2.csv';
repeat1_run2 = 'run2_repeat1_group2.csv';
repeat2_run2 = 'run2_repeat2_group2.csv';
repeat1_run3 = 'run3_repeat1_group2.csv';
repeat2_run3 = 'run3_repeat2_group2.csv';

fs = 100;
axis_size = 15;
fontSize1 = 20;
fontSize2 = 14;
width = 1.2;

% Compute the slope
[slope] = calibration(calneg4,calneg2,cal0,calpos2,calpos4);

% Commpute amplitude
figure(8)
[a1_1,probes,t] = fft_amplitude(run1,slope,fs);
hold on
[a1_2,probes,t] = fft_amplitude(repeat1_run1,slope,fs);
hold on
[a1_3,probes,t] = fft_amplitude(repeat2_run1,slope,fs);
title('Amplitude by using FFT run 1. f = 1.6Hz, A = 250 V','FontSize', fontSize2)
legend('repeat 1','repeat 2','repeat 3','FontSize', fontSize2)
hold off

figure(9)
[a2_1,probes,t] = fft_amplitude(run2,slope,fs);
hold on
[a2_2,probes,t] = fft_amplitude(repeat1_run2,slope,fs);
hold on
[a2_3,probes,t] = fft_amplitude(repeat2_run2,slope,fs);
title('Amplitude by using FFT run 2. f = 1.6Hz, A = 500 V','FontSize', fontSize2)
legend('repeat 1','repeat 2','repeat 3','FontSize', fontSize2)
hold off

figure(10)
[a3_1,probes,t] = fft_amplitude(run3,slope,fs);
hold on
[a3_2,probes,t] = fft_amplitude(repeat1_run3,slope,fs);
hold on
[a3_3,probes,t] = fft_amplitude(repeat2_run3,slope,fs);
title('Amplitude by using FFT run 3. f = 1.6Hz, A = 100 V','FontSize', fontSize2)
legend('repeat 1','repeat 2','repeat 3','FontSize', fontSize2)
hold off

% compute the mean amplitude and estimate error in run 1,2 and 3
figure(16)
[mean_amplitude_probe2_run1,error_a_probe2_run1] = estimate_error_amplitude(a1_1,a1_2,a1_3);
hold on
[mean_amplitude_probe2_run2,error_a_probe2_run2] = estimate_error_amplitude(a2_1,a2_2,a2_3);
hold on
[mean_amplitude_probe2_run3,error_a_probe2_run3] = estimate_error_amplitude(a3_1,a3_2,a3_3);
legend('A = 250 V','linear 1','A = 500 V','linear 1','A = 100 V','linear 3','FontSize', fontSize2)
hold off

% Compute amplitude
figure(6)
[a_run1,probes_run1,t1] = fft_amplitude(run1,slope,fs);
hold on

[a_run2,probes_run2,t2] = fft_amplitude(run2,slope,fs);
hold on

[a_run3,probes_run3,t3] = fft_amplitude(run3,slope,fs);
title('Amplitude by using FFT. f = 1.6Hz','FontSize', fontSize2)
legend('A = 250 V','A = 500 V','A = 100 V','FontSize', fontSize2)
hold off

figure(7)
[a_run4,probes_run4,t4] = fft_amplitude(run4,slope,fs);
hold on

[a_run5,probes_run5,t5] = fft_amplitude(run5,slope,fs);
hold on

[a_run6,probes_run6,t6] = fft_amplitude(run6,slope,fs);
title('Amplitude by using FFT. f = 2.1Hz','FontSize', fontSize2)
legend('A = 100 V','A = 250 V','A = 500 V','FontSize', fontSize2)
hold off


figure(11)
plot(t1,probes_run1(:,2),'r')
yline(a_run1(2),'c--','LineWidth',width)
hold on

plot(t2,probes_run2(:,2),'b')
yline(a_run2(2),'k--','LineWidth',width)
hold on

plot(t3,probes_run3(:,2),'g')
yline(a_run3(2),'m--','LineWidth',width)
set(gca,'fontsize',axis_size);
xlabel('$t[\textrm{s}]$','interpreter','latex','FontSize', fontSize1);
ylabel('$\textrm{a}[\textrm{m}]$','interpreter','latex','FontSize',...
    fontSize1);
title('Amplitude as function of time for probe 2. f = 1.6 Hz',...
    'FontSize',fontSize2)
legend('$A = 250 \textrm{ V}$','$a = 0.0066\textrm{ m}$',...
    '$A = 500 \textrm{ V}$','$a = 0.0133\textrm{ m}$',...
    '$A = 100 \textrm{ V}$','$a = 0.0023\textrm{ m}$',...
    'interpreter','latex','FontSize', fontSize2)
hold off


figure(12)
plot(t4,probes_run4(:,2),'g')
yline(a_run4(2),'c--','LineWidth',width)
hold on

plot(t5,probes_run5(:,2),'r')
yline(a_run5(2),'k--','LineWidth',width)
hold on

plot(t6,probes_run6(:,2),'b')
yline(a_run6(2),'m--','LineWidth',width)
set(gca,'fontsize',axis_size);
xlabel('$t[\textrm{s}]$','interpreter','latex','FontSize', fontSize1);
ylabel('$\textrm{A}[\textrm{m}]$','interpreter','latex','FontSize', fontSize1);
title('Amplitude as function of time for probe 2. f = 2.1 Hz',...
    'FontSize',fontSize2)
legend('$A = 100 \textrm{ V}$','$a = 0.0024\textrm{ m}$',...
    '$A = 250 \textrm{ V}$','$a = 0.0068\textrm{ m}$',...
    '$A = 500 \textrm{ V}$','$a = 0.0112\textrm{ m}$',...
    'interpreter','latex','FontSize', fontSize2)
hold off

%error estimate amplitude
[err] = error_estimate(a_run1,a_run2,a_run3,a_run4,a_run5,a_run6)

% RUN 1
% Compute important parameters from probe number 2 run1
f = 1.6;
h = 0.333;
a1 = mean_amplitude_probe2_run1;
g = 9.81;
[omega1,k1,lambda1,kh1,ak1] = Constant(a1,f,h);

%coordinate = 'coord.bmp';
imgcoord = 'coord.bmp';
coordinate = load('coordinate.txt');

% If you don't have the coordinate txt file please uncomment the line below.
%filename = 'coordinate.txt';
%[pixel] = coord_reference(coordinate,filename);


% Image and mask from run 1
image1 = 'run11_1.bmp';
image2 = 'run11_2.bmp';
Mask = load('maskrun111.txt');

% If you don't have the mask txt file please uncomment the line below.
%maskname1 = 'maskrun1.txt';
%[Mask] = Mask1(image1,image2,maskname1);

rng = 60;
subw = 128;
overlape = 0.75;
[relative_error1] = PIVfunction(image1,image2,imgcoord,Mask,coordinate,a1,k1,omega1,rng,subw,overlape)

% RUN 2

% Compute important parameters from probe number 2 run 2
f = 1.6;
h = 0.333;
a2 = mean_amplitude_probe2_run2;
g = 9.81;
[omega2,k2,lambda2,kh2,ak2] = Constant(a2,f,h);



% Image and mask from run 2
image1 = 'run22_1.bmp';
image2 = 'run22_2.bmp';
Mask = load('maskrun22.txt');

% If you don't have the mask txt file please uncomment the line below.
%maskname2 = 'maskrun2.txt';
%[Mask] = Mask1(image1,image2,maskname2);

rng = 60;
subw = 168;
overlape = 0.75;
%[relative_error2] = PIVfunction(image1,image2,imgcoord,Mask,coordinate,a2,k2,omega2,rng,subw,overlape)


% RUN 3

% Compute important parameters from probe number 2 run 3
f = 1.6;
h = 0.333;
a3 = mean_amplitude_probe2_run3;
g = 9.81;
[omega3,k3,lambda3,kh3,ak3] = Constant(a3,f,h);



% Image and mask from run 3
image1 = 'run33_1.bmp';
image2 = 'run33_2.bmp';
Mask = load('maskrun33.txt');

% If you don't have the mask txt file please uncomment the line below.
%maskname3 = 'maskrun3.txt';
%[Mask] = Mask1(image1,image2,maskname3);

rng = 60;
subw = 128;
overlape = 0.75;
%[relative_error3] = PIVfunction(image1,image2,imgcoord,Mask,coordinate,a3,k3,omega3,rng,subw,overlape)


% RUN 6


% Compute important parameters from probe number 2 run 6
%f = 2.1;
%h = 0.333;
%a6 = a_run6(2);
%g = 9.81;
%[omega6,k6,lambda6,kh6,ak6] = Constant(a6,f,h);



% Image and mask from run 6
%image1 = 'run6_1.bmp';
%image2 = 'run6_2.bmp';
%Mask = load('maskrun6.txt');

% If you don't have the mask txt file please uncomment the line below.
%maskname2 = 'maskrun2.txt';
%[mask] = Mask1(image1,image2,maskname2);

%rng = 64;
%subw = 256;
%overlape = 0.75;
%[absolute_error6] = PIVfunction(image1,image2,imgcoord,Mask,coordinate,a6,k6,omega6,rng,subw,overlape)

