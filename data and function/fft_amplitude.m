function [a,probes,t] = fft_amplitude(filename,slope,fs)
% Compute amplitude by using FFT. The analizyng is start from 12s to 22s.
% The outputs argument are the amplitude, the probes measurement and time.
probe_num = [5; 6; 7; 8];

run_test = load(filename);
M = length(probe_num);
Sz = size(run_test);
K = Sz(1);

dt = 1/fs;
t = linspace(0,dt*K,K);
indx = (1201:2200);

a = zeros(1,M);
probes = zeros(K,M);
for i = 5:8
    probes(:,i-4) = (run_test(:,i)/slope) + 0.0603; % 0.0603 is to make the plot start at y = 0
    probe = probes(:,i-4);
    Value = probe(indx);
    N = length(Value);
    df = fs/N;
    f = 0:df:fs;
    n = int64(N/2);
    xfft = fft(Value);
    abs_fft = 2*abs(xfft/N);
    a(1,i-4) = max(abs_fft(10:end));
    
    if i == 6
        plot(f(1:n),abs_fft(1:n),'LineWidth',1)
        axis_size = 15;
        fontSize1 = 20;
        fontSize2 = 14;
        set(gca,'fontsize',axis_size);
        xlabel('$f[\textrm{Hz}]$','interpreter','latex','FontSize', fontSize1);
        ylabel('$a[\textrm{m}]$','interpreter','latex','FontSize', fontSize1);
    end
end

end

