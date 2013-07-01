% Created by Christopher C. Rappa % 10/4/2008
clear all; clc; close all;
%% Constants 
v = 299792458;                  % (m/s) The speed of light in a vacuum
f_low = 3.5e9;                  % (Hz) Low Frequency
f_high = 5.8e9;                 % (Hz) High Frequency
MQ9speed = 160000/3600;         % (m/s) Cruising Speed of MQ 9
MQ9elev = 7500;                 % (m) Cruising Altitude of MQ 9
offSight = 5*6076*12*.0254;     % (m) Distance target will be off of flight path
jamTime = 20*60;                % (s) Jam time
lambda_min = v/f_high;          % (m) smallest wavelength
lambda_max = v/f_low;           % (m) largest wavelength
antWeight = 0.5;                % (lbs) Antenna Weight
hpaWeight = 0.1;                % (lbs) HPA Weight
weightLimit = 150;              % (lbs) Total Weight Limit
AlWeightPerMeter = 34.4445133;  % (lbs/m^2) Weight of 1/4" Aluminum
maxPower = 10000;               % (W) Maximum Power Available to system
JSR = 5;                        % (dB) Jam to signal ratio
targetPower = 50;               % (W) Target Power
recRadius = 5000;               % (m) Receiver Radius
linearLoss = 3;                 % (dB) Linear loss due to antenna
hpaGain = 27;                   % (dB) Gain of a single HPA
hpaPowerLoss = 15*0.143;        % (W) HPA Power max
hpaPeakPower = 0.25;            % (W) HPA Peak Power %CR

%% Gain and Loss - Link Budget Equation
LoS = sqrt(MQ9elev^2+(MQ9speed*jamTime/2)^2);               % (m) Line of sight distance between earth and plane
jamRadiusPmin = 20*log10(lambda_min/(4*pi*recRadius));      % (dB) Receiver Jam power for target transmission 
radioPower = 10*log10(50) + jamRadiusPmin + JSR;            % (dBW) Power to radio
FSPL = 20*log10(lambda_min/(4*pi*LoS)) + linearLoss;        % (dB) Free Space Path Loss - including linear antenna loss
deliveryPower = radioPower - FSPL;                          % (dBW) Final Deliverable Power to the Area
ampE = hpaPeakPower/hpaPowerLoss;                           % HPA efficiency %CR

%% Spacing and count
lambda = lambda_min;                            % (m) maximum wavelength              
phi = pi/2-atan2(MQ9elev,(MQ9speed*jamTime/2)); % (rad) Maximum look angle to target
Bay = 2*atan2(offSight,MQ9elev);                % (rad) Beadwidth needed to maintain target
dymax = lambda;                                 % (m) Maximum spacing for y
ny = ceil(lambda/(dymax*Bay));                  % (m) Number of Elements needed to produce necessary width
dy = lambda/(ny*Bay);                           % (m) calculated spacing 
dxmax = lambda/(1+sin(phi));                    % (m) Minimize grating lobes for x
dx = dxmax;                                     % (m) Maximize Spacing in x %CR

%% nx Calculation
syms nx
nxWmax = solve('(antWeight + hpaWeight + AlWeightPerMeter*dx*dy)*(nx*ny) = weightLimit',nx);
nxWmax = floor(subs(nxWmax)); %#ok<NOPTS>   % Maximum elements allowed because of Weight
nx = 100;                                   % Chosen nx %CR

%% Calculate Total Power Consumption
freqRange = linspace(f_low,f_high,500);
antGainRange = 10*log10(4*pi*dx*nx*dy*ny./((v./freqRange).^2)); % Calculate minimum gain of antenna array
minAntGain = min(antGainRange);         % (dB) Worst Case Antenna Gain
txPowerdB = deliveryPower - minAntGain; % (dBW) Transmit Power
txPower = 10^(txPowerdB/10);            % (W) Total Transmit Power
txPowerPerAmp = txPower/(nx*ny);        % (W) Transmit power per amp
primePower = txPowerPerAmp/ampE;        % (W) Prime Power per amplifier
totalPower = primePower*nx*ny;          % (W or kVA) Total Power Consumed by system %CR

%% Produce the Output Graphs
f = [f_low (f_low+f_high)/2 f_high]; % (Hz) Frequencies of system to be plotted
phi = [0 pi/4];
theta = linspace(0,pi,500);
for freq = 1:length(f)          % Loop Through Frequencies
    lambda = v/f(freq);         % (m) wavelength of the system
    k = 2*pi/lambda;            % (rad/m) wave number
    G = 4*pi*dx*dy/(lambda^2);
    Ag = 10.^(-0.05*G);
    for ill = 1:2
        dphi = phi(ill);
        for i = 0:nx-1           % Loop Through Linear Arrays
            El(i+1,:) = Ag*exp(j*k*i*dx*cos(theta-dphi)); %#ok<AGROW>
        end
        El_log = 20*log10(abs(sum(El)).*sqrt(G));
        figure;
        plot(theta*180/pi, El_log, 'k');
        ylabel('Power Output of Antenna Array (dBW)');
        xlabel(['\theta (0-180', char(176), ')']);
        title({['Elevation Antenna Pattern for ', num2str(f(freq)/1e9), ' GHz']; ...
            ('Uniform Illumination'); ...
            ['Steering Angle (\phi) of ', num2str(phi(ill)*180/pi), char(176)]});
    end
    figure;
    Az_log = 20*log10(real(Ag*exp(j*k*dy*cos(theta))).*sqrt(G));
    plot(theta*180/pi, Az_log, 'k');
    ylabel('Power Output of Antenna Array (dBW)'); 
    xlabel(['\theta (0-180', char(176), ')']);
    title(['Azimuthal Antenna Pattern for ', num2str(f(freq)/1e9), ' GHz']);
end %CR

%% Plot other Features
figure;
plot(freqRange,antGainRange);
ylabel('Gain (dB)');
xlabel('Frequency (Hz)');
title('Antenna Gain versus Frequency');
xlim([f_low f_high]);
beamWidthX = (v./freqRange)/(nx*dx);
beamWidthY = (v./freqRange)/(ny*dy);
figure;
plot(freqRange,beamWidthX);
ylabel('Beamwidth (rad)');
xlabel('Frequency (Hz)');
title('Beamwidth versus Frequency - Elevation Angle');
xlim([f_low f_high]);
figure;
plot(freqRange,beamWidthY);
ylabel('Beamwidth (rad)');
xlabel('Frequency (Hz)');
title('Beamwidth versus Frequency - Azimuthal Angle'); %CR
xlim([f_low f_high]);

W = (nx*ny)*(hpaWeight + antWeight + 0.026) + (AlWeightPerMeter)*(nx*dx+2*0.026)*(ny*dy+2*0.0135);