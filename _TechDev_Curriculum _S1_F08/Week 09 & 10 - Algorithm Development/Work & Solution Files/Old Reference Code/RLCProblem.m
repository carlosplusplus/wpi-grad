% Created by Christopher Rappa 9/5/08
%% Plot the Voltage over 100ms
clear all; close all; clc;

R = 2; % 2 Ohms
L = 10e-3; % 10 mH
C = 1e-12; % 1pF
w0 = 1e7;

V = dsolve('D2V+(R/L)*DV+V/(L*C)=0'); V = subs(V); V = simplify(V);
% Solution = C1*exp(100*t*(-1+3*i*1111111111^(1/2)))+C2*exp(-100*t*(1+3*i*1111111111^(1/2)))
% Simplified = C1*exp((-100+i*1E7)t))+C2*exp((-100-i*1E7)t)))

C1 = 9; C2 = 90E-6;
b = R/(2*L);

% Drawn to show non-aliased oscillation
N = 1000;
T = 0.000001;
t = linspace(0,T,N);
V = exp(-b*t).*(C1*cos(w0*t)+C2*sin(w0*t));
Venv = C1*exp(-b*t);

hold on;
plot(t,V);
plot(t,Venv,'--r');hold off;
xlabel('time (s)'), ylabel('V(t)'), title('V(t)=e^{-bt}(C_1cos(\omegat)+C_2sin(\omegat)');
legend('V(t)','Decay Envelope');

% Drawn to show decay envelope
figure;
T = 0.05;
t = linspace(0,T,N);
V = exp(-b*t).*(C1*cos(w0*t)+C2*sin(w0*t));
Venv = C1*exp(-b*t);

hold on;
plot(t,V);
plot(t,Venv,'--r');hold off;
xlabel('time (s)'), ylabel('V(t)'), title('V(t)=e^{-bt}(C_1cos(\omegat)+C_2sin(\omegat)');
legend('V(t)','Decay Envelope');%CR



%% Plot Pulse Power
figure;
P = exp(-200*t);
half = P; half(:) = max(P)/2;
hold on;
plot(t,P);
plot(t,half,'--r'); hold off;
xlabel('time (s)'), ylabel('P(t)'), title('P(t)=e^{-200t}');
%imax = find(round((max(P)/2)*10000) == round(P*10000));

imax = 70;
text(t(imax+20),P(imax),'\leftarrow\fontname{times}P_{half-power} at t = 3.466 ms',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','top','FontSize',10)
text(t(imax+2),P(imax),'\bullet',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle','FontSize',10)

legend('Power','1/2 Power Threshold'); %CR

%% Bandwidth Solver
G_half = solve('(w0)^2/((w0^2 - x^2)^2 + R^2/L^2*x^2)^(1/2)=25000','x');
G_halfS = solve('(1e7)^2/(((1e7)^2 - x^2)^2 + 4/(0.01)^2*x^2)^(1/2)=25000','x');

% Solutions
%1/500/L*10^(1/2)*(25000*L^2*w0^2-12500*R^2+(L^4*w0^4-625000000*L^2*w0^2*R^2+156250000*R^4)^(1/2))^(1/2)
% Gain 1/2 Max (1) = 10000173.202580803074638418705792
%1/500/L*10^(1/2)*(25000*L^2*w0^2-12500*R^2-(L^4*w0^4-625000000*L^2*w0^2*R^2+156250000*R^4)^(1/2))^(1/2)
% Gain 1/2 Max (2) = 9999826.7924191969231365812923722

bandwidth = G_halfS(2)-G_halfS(4);
bandwidth = sym2poly(bandwidth)/(2*pi); %CR

%% Gain Plot and Annotation
figure;
range = 1000;
w = w0-range:1:w0+range;
f = w/(2*pi);
G = (w0)^2./(((w0^2 - w.^2).^2 + R^2/L^2*w.^2).^(1/2));

half = G; half(:) = max(G)/2;
hold on; 
h = plot(f,G,'k');
plot(f,half,'--r'); hold off;
xlabel('frequency (Hz)'), ylabel('G(f)'), title('Gain versus frequency');
xlim([(w0-range)/(2*pi) (w0+range)/(2*pi)]);

strl(1) = {'Bandwidth: 55 Hz'};
text(f(375),G(850),strl(1),'FontSize',10);
imax = find(max(G) == G);
text(f(imax)-5,G(imax),'\fontname{times}G_{MAX} when \omega = \omega0',...
    'HorizontalAlignment','right',...
    'VerticalAlignment','top','FontSize',10)

iband = find(max(G)/2 == round(G/100)*100); %Precision adjustment
text(f(iband(1)),G(iband(1)),'\fontname{times}G_{half} at f ~= 9999826 Hz\rightarrow',...
    'HorizontalAlignment','right',...
    'VerticalAlignment','top','FontSize',10)
text(f(iband(1)),G(iband(1)),'\bullet',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle','FontSize',10)

text(f(iband(2)),G(iband(2)),'\leftarrow\fontname{times}G_{half} at f ~= 10000173 Hz',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','top','FontSize',10)
text(f(iband(2)),G(iband(2)),'\bullet',...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle','FontSize',10)

legend('Gain','1/2 Power Threshold'); %CR
