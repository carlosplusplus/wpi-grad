% Created by Christopher C. Rappa 10/18/2008
clc; clear all; close all;
%% Constants
R = 2;          % (R) Resistor value of RLC circuit
L = 10e-3;      % (H) Inductor value of RLC circuit
b = R/(2*L);    % (R/H) Dampening factor of source circuit    
T = 0.003466;   % (s) Software patch cut-off time
tauLim = 10*T;  % (s) Upper limit of time difference
fLim = 500;     % (f) Upper limit of frequency difference
N = 25;         % Matrix size for computation (NxN)

%% A Cross Ambiguity Function
tauSpace = linspace(0,tauLim,N);    % Create vector of all tau values
fSpace = linspace(0,fLim,N);        % Create vector of all frequency values

for j = 1:N                         % Compute the CAF
    tau = tauSpace(j);
    for k = 1:N
        f = fSpace(k);
        integral = @(t) exp(-b*t).*conj(exp(-b*(t+tau))).*exp(-i.*2.*pi*f*t);
        A(j,k) = abs(quad(integral,0,T)).^2; %#ok<AGROW>
    end
end

%surf(fSpace,tauSpace,A,'FaceColor',[1 0.65 0], 'EdgeColor', 'none')
%camlight left; lighting phong;
figure;
mesh(fSpace,tauSpace,A,'EdgeColor', 'k')
axis([0 fLim 0 tauLim 0 max(max(A))])
view(145,30)
xlabel('f - Differential Doppler Frequency (Hz)')
ylabel('\tau - Differential Time Delay (s)')
zlabel('Relative Correlation')
title('Cross Ambiguity Function for \tau and f') %CR

%% D CAF Error Analysis
r = 101;        % (km) Likely single-sided intersection areas
TDOAsigma = 15; % (km) TDOA Line Width
FDOAsigma = 3;  % (km) FDOA Line Width

area = linspace(-(r-1)/2,(r-1)/2,r);
size = [r,r];

Ba = customgauss(size, 1E12, FDOAsigma, 0);
Bb = customgauss(size, 1E12, TDOAsigma, pi/2);
figure;
mesh(area,area,(Ba.*Bb))
view(-27,42)
axis([-(r-1)/2 (r-1)/2 -(r-1)/2 (r-1)/2 0 max(max(Ba.*Bb))])
xlabel('FDOA Location Probability (km)')
ylabel('TDOA Location Probability (km)')
zlabel('Relative Probability')
title({'TDOA-FDOA Location Error Joint Probability',...
       'Rotational Skew \pi/2'})
figure;
hold on;
line(1.96*FDOAsigma*ones(r)/2, area,'Color','b'); 
line(-1.96*FDOAsigma*ones(r)/2,area,'Color','b');
line(area,1.96*TDOAsigma*ones(r)/2, 'Color','r'); 
line(area,-1.96*TDOAsigma*ones(r)/2,'Color','r');
contour(area,area,(Ba.*Bb))
annotation('textbox',[0.15 0.8 0.5 0.1],...
    'String',{'FDOA 95% - 5.88 km'},'EdgeColor','none', 'Color','b');
annotation('textbox',[0.15 0.75 0.5 0.1],...
    'String',{'TDOA 95% - 29.4 km'},'EdgeColor','none', 'Color','r');
hold off;
xlabel('FDOA Location Probability (km)')
ylabel('TDOA Location Probability (km)')
zlabel('Relative Probability')
title({'TDOA-FDOA Location Error Joint Probability',...
       'Rotational Skew \pi/2'}) %CR

%% F Helicopter Dynamics
Ba = customgauss(size, 1E9, FDOAsigma, 0);
Bb = customgauss(size, 1E9, TDOAsigma, pi/4);
figure;
mesh(area,area,(Ba.*Bb))
view(-27,42)
axis([-(r-1)/2 (r-1)/2 -(r-1)/2 (r-1)/2 0 max(max(Ba.*Bb))])
xlabel('FDOA Location Probability (km)')
ylabel('TDOA Location Probability (km)')
zlabel('Relative Probability')
title({'TDOA-FDOA Location Error Joint Probability',...
       'Rotational Skew \pi/4'})
figure;
hold on;
line(1.96*FDOAsigma*ones(r)/2, area,'Color','b'); 
line(-1.96*FDOAsigma*ones(r)/2,area,'Color','b');
line(area,1.96*TDOAsigma*ones(r)/sin(pi/4)/2, 'Color','r'); 
line(area,-1.96*TDOAsigma*ones(r)/sin(pi/4)/2,'Color','r');
contour(area,area,(Ba.*Bb))
annotation('textbox',[0.15 0.8 0.5 0.1],...
    'String',{'FDOA 95% - 5.88 km'},'EdgeColor','none', 'Color','b');
annotation('textbox',[0.15 0.75 0.5 0.1],...
    'String',{'New TDOA 95% - 41.6 km'},'EdgeColor','none', 'Color','r');
hold off;
xlabel('FDOA Location Probability (km)')
ylabel('TDOA Location Probability (km)')
zlabel('Relative Probability')
title({'TDOA-FDOA Location Error Joint Probability',...
       'Rotational Skew \pi/4'}) %CR