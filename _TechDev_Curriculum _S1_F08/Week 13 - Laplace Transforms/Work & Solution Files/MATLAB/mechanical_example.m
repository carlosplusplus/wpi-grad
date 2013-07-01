%% ------------------------------------------------------
clear all;
close all;
clc;

N = 10;
P = 2;

M = 12.5 * 0.45359237;  % kg
k = 2709.57;            % N/m
B = 1.23948;            % Ns/m

nums = [B k];
dens = [M B k];

a = B/(2*M);
wns = sqrt(k/M);        % Undamped Natural Frequency (rad/s)
fns = wns/(2*pi);       % Undamped Natural Frequency (Hz)
wds = sqrt(wns^2-a^2);  % Damped Natural Circular Frequency (rad/s)
fds = wds/(2*pi);       % Damped Natural Frequency (Hz)

tr = 1/(N*fds);         % Time Resolution (s)
tm = P/fds;             % Total Time (s)
t = 0:tr:tm;

% Done by hand
x2sh = 1 - exp(-a*t).*cos(wds*t) - a/wds*exp(-a*t).*sin(wds*t);
x2rh = t - 1/wds*exp(-a*t).*sin(wds*t);

% Transfer Function
Ts = tf(nums,dens);
[mags,phases,ws] = bode(Ts);

x2sm = step(Ts,t);
x2rm = lsim(Ts,t,t);

% Simulink Transfer Function
sim('st')
sim('rt')

% Simulink Physics Model
sim('sf')
sim('rf')

%%
acc = 1.24564;    % Truck Acceleration (m/s^2)
Ad = 0.0254;    % Dune Amplitude (m)
lambda = 4.99;  % Wavelength of Dune (m)
%P = 2*P;

d_max = 34.722; % Maximum velocity
t1 = d_max / acc; % Intersection time

fmax = d_max / lambda; % Maximum frequency

tr_noises = 1/(N*max([fmax fds]));

tau = 1/a;              % Time Constant (s)

noisessimtime = 2*max([P*tau P/fmax]);

tSim = 0:tr_noises:noisessimtime;

dx1 = [];

for i = 1:length(tSim)
    if tSim(i) < t1
        dx1(i) = 2*acc*pi*Ad/lambda*tSim(i)*cos(pi*acc*tSim(i)^2/lambda); %#ok<AGROW>
    else
        dx1(i) = 2*d_max*pi*Ad/lambda*cos(2*pi*(d_max*tSim(i) - 1/2*d_max*t1) /lambda); %#ok<AGROW>
    end
end

dx1s.time = tSim';
dx1s.signals.values = dx1';
dx1s.signals.dimensions = 1;

sim('noises')

%% --------------------------------------------------------------------
% Plotting Variables
FontSize=12;
FontWeight='bold';
LineWidth=2;

% Plot the STEP results to verify that all models agree.
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
ylabel('x_2 (t)')
legend('Hand','MATLAB TF','Simulink TF','Simulink Position',0)
grid on
subplot(2,1,2)
h=plot([0 0 tm]*1000,[0 1 1]);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
title('Step Input')
xlabel('Time (ms)')
ylabel('x_1 (t)')
grid on

% Plot the RAMP results to verify that all models agree.
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
ylabel('x_2 (t)')
legend('Hand','MATLAB TF','Simulink TF','Simulink Position',0)
grid on
subplot(2,1,2)
h=plot([0 tm]*1000,[0 tm]);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
title('Ramp Input')
xlabel('Time (ms)')
ylabel('x_1 (t)')
grid on

%%
% Now we break the results out of the structure.
tnoises = xnoises.time; % Simulation Time Vector
x1noises = xnoises.signals.values(:,1); % x1 (m)
x2noises = xnoises.signals.values(:,2); % x2 (m)
inoises = xnoises.signals.values(:,3); % Acceleration (m/s^2)

% Calculate Power and Efficiency
fnoises = inoises * M;
dnoises = x1noises - x2noises;

% Plot Original Displacements
figure
h=plot(tnoises,x2noises);
set(h,'LineWidth',LineWidth)
set(h,'Color',[0 .5 0])
hold on
h=plot(tnoises,x1noises);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
hold off
legend('Output','Input',0)
xlabel('Time (s)')
ylabel('Position (m)')
title('Original Displacements')
xlim([0 30]);
grid on

% Plot Original Force
figure
h=plot(tnoises,fnoises);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (s)')
ylabel('Force (N)')
title('Original Force')
xlim([0 30]);
grid on

% Plot Original Relative Displacement
figure
h=plot(tnoises,dnoises);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (s)')
ylabel('x_1 - x_2')
title('Original Relative Displacement')
xlim([0 30]);
grid on

%% ---------------------------
% New Values
%B = 24.45162;   % Ns/m
B = 52.2786;       % Ns/m
%k = 175126.835; % N/m 
k = 113832;      % N/m 

num = [B k];
den = [M B k];

a = B/(2*M);
wn = sqrt(k/M);        % Undamped Natural Frequency (rad/s)
fn = wns/(2*pi);       % Undamped Natural Frequency (Hz)
wd = sqrt(wns^2-a^2);  % Damped Natural Circular Frequency (rad/s)
fd = wds/(2*pi);       % Damped Natural Frequency (Hz)

noisesimtime = noisessimtime;
tr_noise = tr_noises;

% Done by hand
% Transfer Function
T = tf(num,den);
[magi,phasei,wi]=bode(T);

tSim = 0:tr_noise:noisesimtime;

sim('noise')

tnoise = xnoise.time; % Simulation Time Vector
x1noise = xnoise.signals.values(:,1); % x1 (m)
x2noise = xnoise.signals.values(:,2); % x2 (m)
inoise = xnoise.signals.values(:,3); % Acceleration (m/s^2)

% Calculate Power and Efficiency
fnoise = inoise * M;
dnoise = x1noise - x2noise;

% Plot New Displacements
figure
h=plot(tnoise,x2noise);
set(h,'LineWidth',LineWidth)
set(h,'Color',[0 .5 0])
hold on
h=plot(tnoise,x1noise);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
hold off
legend('Output','Input',0)
xlabel('Time (s)')
ylabel('Position (m)')
title('New Displacements')
xlim([0 30]);
grid on

% Plot New Force
figure
h=plot(tnoise,fnoise);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (s)')
ylabel('Force (N)')
title('New Force')
xlim([0 30]);
grid on

% Plot New Relative Displacement
figure
h=plot(tnoise,dnoise);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
xlabel('Time (s)')
ylabel('x_1 - x_2')
title('New Relative Displacement')
xlim([0 30]);
grid on

%%
% Plot Original Displacements
figure
h=plot(tnoises,x1noises);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
hold on
h=plot(tnoises,x2noises);
set(h,'LineWidth',LineWidth)
set(h,'Color',[0 .5 0])
h=plot(tnoise,x2noise,'--r');
set(h,'LineWidth',LineWidth)
%set(h,'Color',[0 .5 0])
hold off
legend('Input','Output Original','Output New',0)
xlabel('Time (s)')
ylabel('Position (m)')
title('All Displacements')
xlim([0 30]);
grid on

% Plot  Force
figure
hold on
h=plot(tnoises,fnoises);
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
set(h,'LineWidth',LineWidth)
h=plot(tnoise,fnoise,'--r');
set(get(h,'Parent'),'FontSize',FontSize,'FontWeight',FontWeight)
%set(h,'LineWidth',LineWidth)
legend('Original Force','New Force')
xlabel('Time (s)')
ylabel('Force (N)')
title('Original and New Force')
xlim([0 30]);
hold off
grid on

%%
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


