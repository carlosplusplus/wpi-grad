% Azimuth Parrtern %
function f=Azimuth(m,n,lamda,dx,theta,phi,G);
% m = 4  number of antenna's in x direction, 4 was the initial input in the
% example
% n = 36 number of antenna's in the y direction, 36 was the initial input
% in the example
Wtel = ones(1,m);
bu = zeros(1,n);
WndBu = 10.^(-0.05.*bu);
k = 2*pi/lamda; % wave number
% dx is the spacing between elements
% theta is range of plotted values
% phi is the steering angle
% G is the gain on the input


for l = 1:n
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta) + phi));
end

Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(2);
    plot(theta*180/pi,real(Au_log),'g');
    xlabel('Azimuth Angle, in degrees; blue = kd(psi) - psi, red = psi-psi')
    ylabel('Antenna Gain, in dB');