close all;
clear all;
%% Define Initial Parameters %%

fprintf('-INPUTS------------------------\n');

% These are the variables we can adjust:
v = 160000/3600;    % Velocity in m/s - 160km/h
h = 7500;           % Initial height (m) - cruising altitude
ele_wt = .5+.3;        % Weight per element (lbs)
ele_pwr = 10+1.425;     % Power per element (W)

fprintf('Velocity: %f m/s\n',v);
fprintf('Altitude: %f m\n',h);
fprintf('Weight per Element: %f lbs\n',ele_wt);
fprintf('Power per Element: %f W\n',ele_pwr);

% Define constants:
c = 3e8;                        % Speed of Light (m/s)
freq_l = 3.5e9;                 % Lower frequency bound of antenna bandwidth
freq_u = 5.8e9;                 % Upper frequency bound of antenna bandwidth
freq_m = (freq_l + freq_u)/2;   % Middle frequency of antenna bandwidth

lambda_l = c / freq_l;    % Wavelength at low freq
lambda_u = c / freq_u;    % Wavelength at high freq
lambda_m = c / freq_m;    % Wavelength at mid freq

dx = lambda_u/2;        % Element Spacing (x)
dy = lambda_u/4;        % Element Spacing (y)

%% Define parametric equations based on Initial Parameters %%

fprintf('-OUTPUTS-----------------------\n');

xi = v * 600;             % X Position at time t=0 (600 seconds from target)              
Ri = sqrt(h^2 + xi^2);    % Radial distance from the start point to target
theta_Max = atan(xi/h);   % Maximum sweep angle
fprintf('Maximum Sweep Angle: %f degrees\n',theta_Max*180/pi);

% Calculate necessary Beamwidth (BW) at boresight (t = 10 minutes)
Bwx = 2* atan(1000/h);      % 1 km band
Bwy = 2* atan(9260/h);      % 5 nmi wide
fprintf('Beamwidth: %f x %f degrees\n',Bwx*180/pi,  Bwy*180/pi);

% Calculate dimensions of phased antenna array.
Dx = lambda_u / Bwx;          % Dx = dx*nx
Dy = lambda_u / Bwy;          % Dy = dy*ny
fprintf('Array Size: %f x %f meters\n',Dx,Dy);
fprintf('Element Spacing: %f x %f meters\n',dx,dy);

nx = ceil(Dx / dx);          % # of elements in x direction based on dimensions
ny = ceil(Dy / dy);          % # of elements in y direction based on dimensions
tot_ele = nx * ny;           % Total # of elements in array.
fprintf('Elements: %i x %i = %i\n',nx,ny,tot_ele);

tot_wt  = tot_ele * ele_wt;  % Total weight of the antenna array.
fprintf('Weight of Elements: %f lbs\n',tot_wt);

tot_pwr = tot_ele * ele_pwr; % Total power of antenna array.
fprintf('Power Consumption: %f W\n',tot_pwr);

% Calculate the total power needed for transmission :
% dBW (Receiver) = dBW (Antenna Gain + HPA) - FreeSpacePathLoss
%       ==> Need -85 = -55dBW to be seen at the enemy receiver.

        % FSP = 20 * log((4*pi*Ri*freq_u)/c) ~~~ in dB
        %         ===> Ri = Furthest radial distance (at t = 0)
        
FSPL = 20 * log10((4*pi*Ri*freq_u)/c);
   
% Calculate required power given all specifications.
%   -55 = dBW seen at receiver

Req_TPwr_dB = -55 + FSPL;                % Required dB at trasmitter.
fprintf('Required Tx Power: %f dBW\n',Req_TPwr_dB);

Req_TPwr = 10^((Req_TPwr_dB)/10);       % Calculate req. pwr in Watts (W)

ant_gain = 20*log10((4*pi*nx*dx*ny*dy)/(lambda_l^2));   % Gain of antenna array
fprintf('Gain of Antenna: %f dB\n',ant_gain);
hpa_gain = Req_TPwr_dB - ant_gain;        % Total Required Amp Gain
fprintf('Total Gain of HPA: %f dB\n',hpa_gain);
fprintf('Single HPA Gain: %f dB\n',hpa_gain/tot_ele);



%% Graph #1 - Lowest Freq @ 0 deg

lambda = lambda_u;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = 0;     % steering angle
%G = 10000 + 30dB %input power

theta=0:pi/180:pi;
for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;
Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(1);
    plot(theta*180/pi,real(Au_log),'g',...
        0:180,ones(1,length(theta))*max(real(Au_log)),'r:',...
        0:180,ones(1,length(theta))*max(real(Au_log))-13,'r:');
    title('Antenna Gain vs. Angle - 5.80 GHz at 0 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees')
    ylabel('Antenna Gain, in dB');
    
%% Graph #2 - Lowest Freq @ 45 deg

lambda = lambda_l;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(45);     % steering angle
%G = 10000 + 30dB %input power

theta=0:pi/180:pi;
for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;
Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(2);
    plot(theta*180/pi,real(Au_log),'g',...
        0:180,ones(1,length(theta))*max(real(Au_log)),'r:',...
        0:180,ones(1,length(theta))*max(real(Au_log))-13,'r:');
    title('Antenna Gain vs. Angle - 5.80 GHz at 45 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees')
    ylabel('Antenna Gain, in dB');
    
%% Graph #3 - Middle Freq @ 0 deg

lambda = lambda_m;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(0);     % steering angle;
%G = 10000 + 30dB %input power

theta=0:pi/180:pi;
for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;
Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(3);
    plot(theta*180/pi,real(Au_log),'g',...
        0:180,ones(1,length(theta))*max(real(Au_log)),'r:',...
        0:180,ones(1,length(theta))*max(real(Au_log))-13,'r:');
    title('Antenna Gain vs. Angle - 4.65 GHz at 0 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees')
    ylabel('Antenna Gain, in dB');
    
%% Graph #4 - Lower Freq @ 45 deg

lambda = lambda_m;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(45);
%G = 10000 + 30dB %input power

theta=0:pi/180:pi;
for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;
Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(4);
    plot(theta*180/pi,real(Au_log),'g',...
        0:180,ones(1,length(theta))*max(real(Au_log)),'r:',...
        0:180,ones(1,length(theta))*max(real(Au_log))-13,'r:');
    title('Antenna Gain vs. Angle - 4.65 GHz at 45 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees')
    ylabel('Antenna Gain, in dB');

%% Graph #5 - Highest Freq @ 0 deg

lambda = lambda_u;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(0);     % steering angle
%G = 10000 + 30dB %input power

theta=0:pi/180:pi;
for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;
Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(5);
    plot(theta*180/pi,real(Au_log),'g',...
        0:180,ones(1,length(theta))*max(real(Au_log)),'r:',...
        0:180,ones(1,length(theta))*max(real(Au_log))-13,'r:');
    title('Antenna Gain vs. Angle - 3.50 GHz at 0 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees')
    ylabel('Antenna Gain, in dB');
    
%% Graph #6 - Highest Freq @ 45 deg

lambda = lambda_u;

Wtel = ones(1,ny); % weights in elevation
bu = zeros(1,nx); % voltage in dB given to each element
WndBu = 10.^(-0.05.*bu); % voltage in watts
k = 2*pi/lambda; % wave number
phi = deg2rad(45);
%G = 10000 + 30dB %input power

theta=0:pi/180:pi;
for l = 1:nx
    Au(l,:) = sum(Wtel)*WndBu(l)*exp((j*k*l*dx).*(cos(theta+ phi)));
end

G = 1;
Au_log = 20*log10(abs(sum(Au)).*sqrt(G));

figure(6);
    plot(theta*180/pi,real(Au_log),'g',...
        0:180,ones(1,length(theta))*max(real(Au_log)),'r:',...
        0:180,ones(1,length(theta))*max(real(Au_log))-13,'r:');
    title('Antenna Gain vs. Angle - 3.50 GHz at 45 deg Steering Angle')
    xlabel('Azimuth Angle, in degrees')
    ylabel('Antenna Gain, in dB');
   
%% Antenna Gain vs Frequency %%

freqs = [3.5:.1:5.8]*10^9;
lambdas = c./freqs;
Gs = 20*log10(4*pi*nx*dx*ny*dy./lambdas.^2);

figure(7);
    plot(freqs,Gs);
    title('Antenna gain vs. Frequency');
    xlabel('Frequency (Hz)');
    ylabel('Gain (dB)');
    
%% Beamwidth vs Frequency %%

BWxs = (180/pi)*(lambdas./Dx);
BWys = (180/pi)*(lambdas./Dy);

figure(8);
    plot(freqs,BWxs,freqs,Bwx*180/pi*ones(1,length(freqs)),'r:',...
         freqs,BWys,freqs,Bwy*180/pi*ones(1,length(freqs)),'r:');
    title('Antenna Beamwidth vs. Frequency');
    xlabel('Frequency (Hz)');
    ylabel('Beamwidth (degrees)');
    
    
fprintf('\n');