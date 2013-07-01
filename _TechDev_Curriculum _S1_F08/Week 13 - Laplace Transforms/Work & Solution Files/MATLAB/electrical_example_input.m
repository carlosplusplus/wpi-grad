% Housekeeping
close all
clear all

% Plotting Variables
FontSize=12;
FontWeight='bold';
LineWidth=3;

% We have a device that can be modeled as a pure inductance.
L=0.21; % Device Inductance (H)

% It is connected in a circuit to a capcitor and resistor.
Rs=20; % Resistance (ohm)
Cs=33e-6; % Capacitance (F)

% From this data, we can derive system characteristics.
taus=2*L/Rs; % Electrical Time Constant (s)
wns=sqrt(1/(L*Cs)); % Undamped Natural Circular Frequency (rad/s)
fns=wns/2*pi; % Undamped Natural Frequency (Hz)
wds=sqrt(wns^2-Rs^2/(4*L^2)); % Damped Natural Circular Frequency (rad/s)
fds=wds/(2*pi); % Damped Natural Frequency (Hz)

% To compute our hand calculation, we need to create a vector of time
% steps. We need to make the time resolution small enough to capture the
% vibration frequency. Shannon's sampling theorem says that we should
% sample twice as fast as the fastest frequency. However, to make the curve
% look smooth, we will sample 10 times as fast. We will make the total time
% long enough to capture 2 cycles.
tr=1/(10*fds); % Time Resolution (s)
tm=2/fds; % Total Time (s)
t=[0:tr:tm]; % Vector of Time Steps in "tr" increments, up to "tm".

%%% HAND CALCULATION %%%
% Now we can compute the time response of the system to a step input and a
% ramp input.
% First the step input.
x2sh=1-exp(-t/taus).*((taus*wds)^-1*sin(wds*t)+cos(wds*t));
    % Step Response (V)
% Next the ramp input.
x2rh=t+Rs*Cs*(exp(-t/taus).*(cos(wds*t)+ ...
    ((1-taus/(Rs*Cs))/(taus*wds))*sin(wds*t))-1); % Ramp Response (V)
%%% HAND CALCULATION %%%

%%% MATLAB TRANSFER FUNCTION %%%
% Now we create a transfer function that describes the system using MATLAB.
% We will use the MATLAB function TF to create the transfer functions.
nums=1; % Transfer Function Numerator
dens=[L*Cs Rs*Cs 1]; % Transfer Function Denominator
Ts=tf(nums,dens); % Transfer Function
% Bode Diagram Vectors
[mags,phases,ws]=bode(Ts);

% Next we simulate the response to a step and ramp input.
% There is a special function to simulate a transfer function response to a
% step input. It is called STEP. We use it in conjunction with the time
% vector "t" that we created earlier.
x2sm=step(Ts,t);
% There is no function specifically for ramp, so we use the general
% function LSIM to simulate the response to a ramp. LSIM requires a time
% vector and the corresponding input values. Since our input is x1=1*t
% (ramp), both the input values and the time vector are "t". (We could use
% LSIM to simulate a step. In that case, the input vector would be all
% ones.)
x2rm=lsim(Ts,t,t);
%%% MATLAB TRANSFER FUNCTION %%%

%%% SIMULINK TRANSFER FUNCTION %%%
% Now we run the Simulink models st.mdl and rt.mdl which represent the step
% and ramp responses, respectively. We use the function called SIM, which 
% runs the corresponding Simulink model.
% Hidden Variables:
% Simulation>Configuration Parameters>Stop Time = tm
% Simulation>Configuration Parameters>Max step size = tr
% The output of the step model is "x2st".
% The output of the ramp model is "x2rt".
sim('st')
sim('rt')
%%% SIMULINK TRANSFER FUNCTION %%%

%%% SIMULINK CHARGE SIMULATION %%%
% Now we run the Simulink models that simulate the charges moving through
% the system. sf.mdl and rf.mdl simulate the step and ramp responses,
% respectively.
% Hidden Variables:
% Simulation>Configuration Parameters>Stop Time = tm
% Simulation>Configuration Parameters>Max step size = tr
sim('sf')
sim('rf')
%%% SIMULINK CHARGE SIMULATION %%%

% Now we plot the STEP results to verify that all models agree.
figure
subplot(2,1,1)
h=plot(t*1000,x2sh);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineStyle',':','Marker','o','MarkerSize',20,'LineWidth',LineWidth)
hold on
h=plot(t*1000,x2sm);
set(h,'LineStyle',':','Marker','x','MarkerSize',16,...
    'LineWidth',LineWidth,'Color',[0 .5 0])
h=plot(x2st.time*1000,x2st.signals.values);
set(h,'LineStyle',':','Marker','+','MarkerSize',12,...
    'LineWidth',LineWidth,'Color','r')
h=plot(x2sf.time*1000,x2sf.signals.values);
set(h,'LineStyle',':','Marker','*','MarkerSize',8,...
    'LineWidth',LineWidth,'Color','m')
hold off
title('System Response to Step Input')
xlabel('Time (ms)')
ylabel('x_2 (V)')
legend('Hand','MATLAB TF','Simulink TF','Simulink Charge',0)
grid on
subplot(2,1,2)
h=plot([0 0 tm]*1000,[0 1 1]);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
title('Step Input')
xlabel('Time (ms)')
ylabel('x_1 (V)')
grid on

% Now we plot the RAMP results to verify that all models agree.
figure
subplot(2,1,1)
h=plot(t*1000,x2rh);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineStyle',':','Marker','o','MarkerSize',20,'LineWidth',LineWidth)
hold on
h=plot(t*1000,x2rm);
set(h,'LineStyle',':','Marker','x','MarkerSize',16,...
    'LineWidth',LineWidth,'Color',[0 .5 0])
h=plot(x2rt.time*1000,x2rt.signals.values);
set(h,'LineStyle',':','Marker','+','MarkerSize',12,...
    'LineWidth',LineWidth,'Color','r')
h=plot(x2rf.time*1000,x2rf.signals.values);
set(h,'LineStyle',':','Marker','*','MarkerSize',8,...
    'LineWidth',LineWidth,'Color','m')
hold off
title('System Response to Ramp Input')
xlabel('Time (ms)')
ylabel('x_2 (V)')
legend('Hand','MATLAB TF','Simulink TF','Simulink Charge',0)
grid on
subplot(2,1,2)
h=plot([0 tm]*1000,[0 tm]);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
title('Ramp Input')
xlabel('Time (ms)')
ylabel('x_1 (V)')
grid on

% Now we subject the circuit to a sinusoidal input. This is meant to
% represent a DC voltage with a ripple.
Vdel=24; % Supply Voltage (V)
A1=0.1; % Noise Amplitude (V)
f1=60; % Noise Frequency (Hz)
w1=2*pi*f1; % Noise Circular Frequency (rad/s)

% Now we simulate the circuit response to this input voltage.
% We want the simulation time resolution to be small enough to capture the
% frequency of the input dynamics (f1) and the circuits natural frequency
% (fds). We need to sample twice as fast as the highest frequency, but we
% will sample 10 times as fast.
tr_noises=1/(10*max([f1 fds]));
% We want to simulate for 8*tau so the system reaches steady state, and we
% want to see 8 cycles, so we select an end time long enough to get 8
% cycles and 8 tau.
noisessimtime=max([8*taus 8/f1]); % Simulation End Time (s)
% Now we simulate the system response to the sinusoid.
% Hidden Variables:
% Simulation>Configuration Parameters>Stop Time = noisessimtime
% Simulation>Configuration Parameters>Max step size = tr_noises
% The initial condition of the "q" integrator is Vdel*C so the input and
% output voltages are initially the same. This is to clearly see the
% instability due to the input frequency (different from the instability
% due to a sudden step to 24 VDC).
sim('noises')

% Now we break the results out of the structure.
tnoises=xnoises.time; % Simulation Time Vector
x1noises=xnoises.signals.values(:,1); % Input Voltage (V)
x2noises=xnoises.signals.values(:,2); % Output Voltage (V)
inoises=xnoises.signals.values(:,3); % Loop Current (A)

% Calculate Power and Efficiency
prnoises=inoises.^2*Rs; % Resistor Power Loss (W)
pinoises=abs(x1noises.*inoises); % Input Power (W)
ponoises=pinoises-prnoises; % Output Power (W)
nnoises=ponoises./pinoises; % Efficiency
vrnoises=x2noises-Vdel; % Voltage Ripple (V)

% Plot Original Voltages
figure
h=plot(tnoises*1000,x1noises);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
hold on
h=plot(tnoises*1000,x2noises);
set(h,'LineWidth',LineWidth)
set(h,'Color',[0 .5 0])
hold off
legend('Input','Output',0)
xlabel('Time (ms)')
ylabel('Voltage (V)')
title('Original Circuit Voltages')
grid on

% Plot Original Current
figure
h=plot(tnoises*1000,inoises*1000);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (ms)')
ylabel('Current (mA)')
title('Original Current')
grid on

% Plot Original Efficiency
figure
h=plot(tnoises*1000,nnoises);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (ms)')
ylabel('Efficiency')
title('Original Efficiency')
grid on

% Original circuit appears to amplify ripple. Violates 24.2V max output
% requirement.
% Select New Resistor and Capacitor
R=916; % Resistance (Ohm)
C=1e-6; % Capacitance (F)

% New System Characteristics
wn=sqrt(1/(L*C)); % Undamped Natural Frequency (rad/s)
fn=wn/(2*pi); % Undamped Natural Frequency (Hz)
wd=sqrt(wn^2-R^2/(4*L^2)); % Damped Natural Frequency (rad/s)
fd=wd/(2*pi); % Damped Natural Frequency (Hz)
tau=2*L/R; % Electrical Time Constant (s)
noisesimtime=max([8*tau 8/f1]); % Simulation End Time (s)
fm=1/tau; % Electrical Characteristic Frequency (Hz)
tr_noise=1/(10*max([f1 fm fd fn])); % Time Resolution (s)

% Simulate New System
% Hidden Variables:
% Simulation>Configuration Parameters>Stop Time = noisesimtime
% Simulation>Configuration Parameters>Max step size = tr_noise
% The initial condition of the "q" integrator is Vdel*C so the input and
% output voltages are initially the same. This is to clearly see the
% instability due to the input frequency (different from the instability
% due to a sudden step to 24 VDC).
sim('noise')

% Break Results out of structure
tnoise=xnoise.time; % Simulation Time Vector
x1noise=xnoise.signals.values(:,1); % Input Voltage (V)
x2noise=xnoise.signals.values(:,2); % Output Voltage (V)
inoise=xnoise.signals.values(:,3); % Loop Current (A)

% Calculate Power and Efficiency
prnoise=inoise.^2*R; % Resistor Power Loss (W)
pinoise=abs(x1noise.*inoise); % Input Power (W)
ponoise=pinoise-prnoise; % Output Power (W)
nnoise=ponoise./pinoise; % Efficiency
vrnoise=x2noise-Vdel; % Voltage Ripple (V)

% Plot New Voltages
figure
h=plot(tnoise*1000,x1noise);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
hold on
h=plot(tnoise*1000,x2noise);
set(h,'LineWidth',LineWidth)
set(h,'Color',[0 .5 0])
hold off
legend('Input','Output',0)
xlabel('Time (ms)')
ylabel('Voltage (V)')
title('New Circuit Voltages')
grid on

% Plot New Current
figure
h=plot(tnoise*1000,inoise*1000);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (ms)')
ylabel('Current (mA)')
title('New Current')
grid on

% Plot New Efficiency
figure
h=plot(tnoise*1000,nnoise);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (ms)')
ylabel('Efficiency')
title('New Efficiency')
grid on

% Create New Transfer Function
T=tf(1,[L*C R*C 1]);
% Bode Diagram Information
[magi,phasei,wi]=bode(T);

% Plot Bode Diagram
figure
subplot(2,1,1)
h=semilogx(ws/(2*pi),20*log10(mags(:)));
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
hold on
h=semilogx(wi/(2*pi),20*log10(magi(:)));
set(h,'LineWidth',LineWidth)
set(h,'Color',[0 .5 0])
hold off
ylabel('Magnitude (dB)')
title('Bode Diagram')
legend('Original','New')
grid on
subplot(2,1,2)
h=semilogx(ws/(2*pi),phases(:));
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
hold on
h=semilogx(wi/(2*pi),phasei(:));
set(h,'LineWidth',LineWidth)
set(h,'Color',[0 .5 0])
hold off
xlabel('Frequency (Hz)')
ylabel('Phase (deg)')
grid on