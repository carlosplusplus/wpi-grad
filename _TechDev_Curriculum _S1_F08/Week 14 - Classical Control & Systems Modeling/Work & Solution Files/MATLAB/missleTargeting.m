% BAE Systems ELDP Program
% TDC 1 - Controls
% Deliverable Code
% Coded by Christopher C. Rappa
% 12/19/2008
clear all; close all; clc;

%% Calculate Zeta for sgrid 
%syms z; % Run Once then store in script
%z = solve('.20 = exp(-z*pi/(sqrt(1-z^2)))','z');
%z = subs(z);
z = 0.4559; % Dampening Ratio

%% Criteria
c.percentOvershoot = 20;% Maximum percent overshoot allowed
c.settleTime = 0.6;     % Maximum settle time allowed
c.settleTolerance = 2;  % Percent tolerance for settle time evaluation
c.ccThreshold = 1/2;    % az/el Threshold influence limit for cross coupling
c.minimizeCCnorST = 1;  % 1 = Minimize Cross-Coupling, 0 = minimize Settling Time

%% Missle Parameters
travelDistance = 14*1609.344;             % (m) Missile Travel Distance
velocity = 1750*0.44704;                  % (m/s) Missile Velocity
travelTime = travelDistance/velocity;     % (s) Missle total travel time
sampleAngleRotation = atan(c.ccThreshold);% (rad/sample) Angle traveled per sample
spinSamples = 2*pi/sampleAngleRotation;   % (sample/rotation) Number of samples 

%% Simulation Parameters
sim_time = 5;               % Run Time
N = 1000;                   % Number of Samples
t = linspace(0,sim_time,N); % Run Time Vector

%% Original System Description and Plots
% System Gains
gGE = .3;       % Guidance Electronics - V/arcsec
gSA = 30;       % Servo Amplifier - V/V
gGB = 1/302.7;  % Gear Ratio
gFin = 2412;    % Fin Adjustment
gSB = 3.26;     % Servomoto and Brake - arcsec/V

gain = gGE*gSA*gGB*gFin*gSB;                % Combined First Order Gain          
[num, den] = zp2tf([],[0 -1.6 -33.8],gain); % Plant num and den
plant = tf(num,den);                        % Generate plant transfer function
sys_cl = feedback(plant,1);                 % Generate system transfer function for CL

figure;                                    % Plot original system step response
step(sys_cl)
title('Original Step Response')
ylabel('Step Response (arcsec)');

figure;                                    % Plot original system root locus
rlocus(sys_cl)
sgrid(z,0)
title('Root Locus Without a Controller')

figure;                                    % Plot original system Bode plot
bode(sys_cl)
title('Bode Plot of Original System')

%% Add Porportional Controller to System - FAIL
% Iterate through potential Kp values and plot their step responses.
% Kp system does not meet the criteria
figure;
K = 5;
Kp = linspace(1,K,K);   % Porportional gain range
for i = 1:length(Kp)
    PIDcontrol = tf([0 Kp(i) 0],[1 0]); % Generate P controller transfer function
    sys = feedback(PIDcontrol*plant,1); % Generate system transfer function
    y = step(sys,t);                    % Calculate step response
    plot(t,y,'Color',[1-Kp(i)/K 1-Kp(i)/K 1-Kp(i)/K]);                          %
    hold on;
end
hold off
title('Original System Step Response with Varying Kp');
xlabel('time (s)');
ylabel('Step Response (arcsec)');
legend(['Kp = ',num2str(Kp(1))],['Kp = ',num2str(Kp(2))],['Kp = ',num2str(Kp(3))],...
       ['Kp = ',num2str(Kp(4))],['Kp = ',num2str(Kp(5))]);
   
%% Add PD Controller to System - PASS
% Iterate through potential Kp values and plot their step responses.
% Kp system does not meet the criteria
figure;
Kp = 2;    % Estimate appropriate porportional gain
K = 5;
Kd = linspace(2,6,K); %Differential gain range
for i = 1:length(Kd)-1
    PIDcontrol = tf([Kd(i) Kp 0],[1 0]);% Generate P controller transfer function
    sys = feedback(PIDcontrol*plant,1); % Generate system transfer function
    y = step(sys,t);                    % Calculate step response
    plot(t,y,'Color',[1-Kd(i)/K 1-Kd(i)/K 1-Kd(i)/K]);                          %
    hold on;
end
hold off
title('Original System Step Response with Varying Kd, Kp = 2');
xlabel('time (s)');
xlim([0 1]);
ylabel('Step Response (arcsec)');
legend(['Kd = ',num2str(Kd(1))],['Kd = ',num2str(Kd(2))],['Kd = ',num2str(Kd(3))],...
       ['Kd = ',num2str(Kd(4))]);

%% Find Optimal PD Controller Gains
% Using manual tuning, I found a range Kp and Kd values for a PD
% controller that will give us the passing criteria. This block examines
% the mesh of this range to find the optimal gains that will yield wither
% the minimum settle time or the minimum cross coupling for our threshold.
m = 50;      % Matrix size [50x50]
KpLow = 1;   % Porportional gain lower limit   
KpHigh = 15; % Porportional gain upper limit
KdLow = 0.5; % Differential gain lower limit
KdHigh = 8;  % Differential gain upper limit
% Tune gains and return tolerance
[Kp,Kd,tolerance] = tunePDController(plant,t,m,KpLow,KpHigh,KdLow,KdHigh,c);

%% Increase precision of the gain values.
% This block takes the previously found gain values and increases the precision
% of this decision. Using the upper and lower resolution limits of the gain 
% ranges, we iterate through all gain combinations to find the new minimum 
% cross coupling in our system. 
KpLow = Kp - tolerance;  % Porportional gain lower limit 
KpHigh = Kp + tolerance; % Porportional gain upper limit
KdLow = Kd - tolerance;  % Differential gain lower limit
KdHigh = Kd + tolerance; % Differential gain upper limit
% Tune Gains to increased precision values for ideal values
[Kp,Kd,tolerance] = tunePDController(plant,t,m,KpLow,KpHigh,KdLow,KdHigh,c); 

%% Controller System Characterization with Passing Criteria
PIDcontrol = tf([Kd Kp 0],[1 0]);   % Generate controller transfer function
sys = feedback(PIDcontrol*plant,1); % Generate system transfer function
y = step(sys,t);                    % Calculate step response
[os, ts, tr] = stepspecs(t,y,1,2);  % Get step response specs for examination
[cc,w] = crossCoupling(t,y,ts,c.ccThreshold); % Calculate cross coupling figures 
f = 1/ts;                           % System pulse frequency
numSamples = travelTime/ts;         % Number of samples until impact
rotations = numSamples/spinSamples; % Number of rotations until impact 

figure;                             % Plot controlled system step response
plot(t,y)
xlim([0 1]);                        % Rescale to 1 second
title('Tuned PD Controller - Step Response')
xlabel('Time (s)');
ylabel('Step Response (arcsec)');

figure;                             % Plot controlled system root locus.
rlocus(sys)
sgrid(z,0)
title('Root Locus with Tuned PD Controller')

figure;                             % Plot controlled system Bode plot
bode(sys)
title('Bode Plot of Controlled System with PD Controller')

%% Missile Drive
% This block simulates the environmental adjustment from the controller to
% show the typical tracking and missle correction for the controller. 
% This simulation includes a unit step response with decaying steps
% representing the system pulse samples
tFinal = ts*(spinSamples+6);        
tSim = linspace(0,tFinal,(N-1));
tck = 1; tTrack = 0;
for i = 1:(N-1)
    input(i) = 1-(1/spinSamples)*floor(tSim(i)/ts);
    if(i > 1)
        if (input(i) ~= input(i-1))
            tTrack(length(tTrack)+1) = tSim(i);
            tck(length(tck)+1) = input(i);
        end
    end
end
tck(tck<0) = 0;     % Zero values below zero to end after total correction
input(input<0) = 0;

yOut = lsim(sys,input,tSim,1);      % Controlled system response to input
iOut = lsim(sys_cl,input,tSim,1);   % Original system response to input

%% Missle Tracking for Circular Path
% This block is self explanatory. It plots the input of our system and
% casts this to a circle to show how we could expect the dot to move based
% in our control system.
% Cast Output to Circular Graph
circle = sin(w*tSim)+j*cos(w*tSim);
controlOutput = yOut'.*circle;
controlInput =  input.*circle;
iControlOutput = iOut'.*circle;
figure;
hold on;
plot(tck.*(sin(w*tTrack)+j*cos(w*tTrack)),'--rs','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',4)
plot(controlInput,'r');
plot(controlOutput,'b')
plot(iControlOutput,'g')
plot(circle,'--k')
plot((2*tSim/max(tSim)-1),0*tSim,'--k'); 
plot(j*(2*tSim/max(tSim)-1),'--k');
axis square; box on;
xlim([-1.2 1.2]); ylim([-1.2 1.2]);
xlabel('Azimuth'); ylabel('Elevation')
title('Response with Simulated Input')
l = legend('Actual Dot Movement','Sampled Input','Control Output','Original System');
set(l,'Location','NorthEastOutside');
hold off; %CCR