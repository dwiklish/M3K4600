function [omega,k,lambda,kh,ak] = Constant(a,f,h)
% Function to compute the angular frequency, wavenumber, wavelength,kh, and
% ak. The imput argument are amplitude, frequency, and water depth.

omega = 2*pi*f;
g = 9.81;

k0 = 0.00001;
k1 = omega^2/(g*tanh(k0*h));

while abs(k1-k0) > 0.00001;
    k0 = k1;
    k1 = omega^2/(g*tanh(k0*h));
end

k = k1;
lambda = 2*pi/k;
kh = k*h;
ak = a*k;
end

