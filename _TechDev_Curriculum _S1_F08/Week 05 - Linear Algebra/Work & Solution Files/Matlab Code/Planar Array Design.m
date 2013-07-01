% Azimuth Parrtern %
% function f=Azimuth(m,n,lambda,phi);

close all;
clear all;

%% Define Initial Parameters %%

% These are the variables we can adjust:

v = 44.444;               % Velocity in m/s
h = 7620;                 % Initial height (m)

hpa_gain = 0;             % Amplifier gain in dB

dx = .0259;        % Spacing of elements in the x direction.
                   % Based on (L/2) < dx < L where L = lambda_l

ele_wt = .5;      % Weight per element (lbs)

% First run guesses: v = 44.444, h = 7620, hpa_gain = 0
%                    dx = .02, ele_wt = .5

% Define constant variables:

c = 3e8;                  % Speed of Light (m/s)
freq_l = 3.5e9;           % Lower frequency bound of antenna bandwidth
freq_u = 5.8e9;           % Upper frequency bound of antenna bandwidth
freq_m = (freq_l + freq_u)/2;   % Middle frequency of antenna bandwidth

lambda_l = c / freq_l;    % Wavelength at 3.50 GHz
lambda_u = c / freq_u;    % Wavelength at 5.80 GHz
lambda_m = c / freq_m;    % Wavelength at 4.65 GHz

%% Define parametric equations based on Initial Parameters %%

xi = v * 600; % Initial position away from the target radio.
              % UAV will reach this position in 10 minutes.
              
Ri = sqrt(h^2 + xi^2)  % Radial distance from the start point to target.

% Calculate the BeamWidth (BW) at boresight (t = 10 minutes)

Rbw = sqrt(h^2 + 9260^2);   % Calculate the radius at boresight to use 
                            % to determine the beamwidth. * 9260 = 5nmi.
                            
Bw = 2 * asin(9260 * (1/Rbw));  % Beamwidth at boresight.

% Calculate directivity of phased antenna array

D_l = (lambda_l)/Bw;   % Calculate directivity from highest frequency
D_u = (lambda_u)/Bw;   % Calculate directivity from lowest frequency

D = lambda_l / D_u;    % Max directivity = low freq / highest directivity

% Calculate the total power needed for transmission :
% dBW (Receiver) = dBW (Antenna Gain + HPA) - FreeSpacePathLoss
%       ==> Need 22dBW to be seen at the enemy receiver.

        % FSP = 20 * log((4*pi*Ri*freq_u)/c) ~~~ in dB
        %         ===> Ri = Furthest radial distance (at t = 0)
        
FSPL = 20 * log10((4*pi*Ri*freq_u)/c);
   
% Calculate required power given all specifications.
%   22 = dBW seen at receiver

Req_TPwr_dB = 22 + FSPL;                % Required dB at trasmitter.

Req_TPwr = 10^((Req_TPwr_dB)/10);       % Calculate req. pwr in Watts (W)

ant_gain = 22 - hpa_gain + FSPL;        % Antenna gain in dB

% Solve for dxdy using the antenna equation.

dx_dy = (ant_gain * ((lambda_u)^2))/(4*pi);

dy = dx_dy / dx;    % Solve for dy (spacing b/w elements in y direction.

nx = ceil(D / dx);          % # of elements in x direction based on directivity
ny = ceil(D / dy);          % # of elements in y direction based on directivity

tot_ele = nx * ny;           % Total # of elements in array.
tot_wt  = tot_ele * ele_wt;  % Total weight of the antenna array.


%% Graph #1 - Lowest Freq @ 0 deg

lambda = lambda_u;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = 0;     % steering angle
%G = 10000 + 30dB %input power

% phi is the steering angle

theta=pi/180:pi/3600:pi;

for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;

Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(1);
    plot(theta*180/pi,real(Au_log),'g');
    axis([0 180 -50 50])
    title('Antenna Gain vs. Angle - 3.50 GHz at 0 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees; blue = kd(psi) - psi, red = psi-psi')
    ylabel('Antenna Gain, in dB');
    
%% Graph #2 - Lowest Freq @ 45 deg

lambda = lambda_l;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(45);     % steering angle
%G = 10000 + 30dB %input power

% phi is the steering angle

theta=pi/180:pi/3600:pi;

for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;

Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(2);
    plot(theta*180/pi,real(Au_log),'g');
    axis([0 180 -50 50])
    title('Antenna Gain vs. Angle - 3.50 GHz at 45 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees; blue = kd(psi) - psi, red = psi-psi')
    ylabel('Antenna Gain, in dB');
    
%% Graph #3 - Middle Freq @ 0 deg

lambda = lambda_m;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(0);     % steering angle;
%G = 10000 + 30dB %input power

% phi is the steering angle

theta=pi/180:pi/3600:pi;

for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;

Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(3);
    plot(theta*180/pi,real(Au_log),'g');
    axis([0 180 -50 50])
    title('Antenna Gain vs. Angle - 4.65 GHz at 0 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees; blue = kd(psi) - psi, red = psi-psi')
    ylabel('Antenna Gain, in dB');
    
%% Graph #4 - Lower Freq @ 45 deg

lambda = lambda_m;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(45);
%G = 10000 + 30dB %input power

% phi is the steering angle

theta=pi/180:pi/3600:pi;

for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;

Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(4);
    plot(theta*180/pi,real(Au_log),'g');
    axis([0 180 -50 50])
    title('Antenna Gain vs. Angle - 4.65 GHz at 45 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees; blue = kd(psi) - psi, red = psi-psi')
    ylabel('Antenna Gain, in dB');

%% Graph #5 - Highest Freq @ 0 deg

lambda = lambda_u;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(0);     % steering angle
%G = 10000 + 30dB %input power

% phi is the steering angle

theta=pi/180:pi/3600:pi;

for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta + phi)));
end

G = 1;

Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(5);
    plot(theta*180/pi,real(Au_log),'g');
    axis([0 180 -50 50])
    title('Antenna Gain vs. Angle - 5.80 GHz at 0 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees; blue = kd(psi) - psi, red = psi-psi')
    ylabel('Antenna Gain, in dB');
    
%% Graph #6 - Highest Freq @ 45 deg

lambda = lambda_u;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(45);
%G = 10000 + 30dB %input power

% phi is the steering angle

theta=pi/180:pi/3600:pi;

for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;

Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(6);
    plot(theta*180/pi,real(Au_log),'g');
    axis([0 180 -50 50])
    title('Antenna Gain vs. Angle - 5.80 GHz at 45 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees; blue = kd(psi) - psi, red = psi-psi')
    ylabel('Antenna Gain, in dB');