%% TEAM MCCCXXXVII
%  Week 07 - Multiple Random Variables

clear all;
close all;

std_tdoa = 15000;       % TDOA Line Width
std_fdoa =  3000;       % FDOA Line Width
std_p = 10*(10^-9);     % Position Error
std_v = 0.01;           % Velocity Error
alpha = 0.005;          % Sweeping Rate
lambda = 30;            % Wavelength 

%% Part D: CAF Error Analysis

% Variance and standard deviation calculated for TDOA Error

var_T = 2*(std_p^2) + std_tdoa^2;
std_T = sqrt(var_T);

% Variance and standard deviation calculated for FDOA Error

var_F = 2*(std_v^2) + ((alpha^2 * std_p^2)/(lambda^2)) + std_fdoa^2;
std_F = sqrt(var_F);

mult = 3;   % Multiplicity value to increase plotting range increased range

% Set sample steps for each of the ranges

df = 250;
dt = 250;

% Create vector to store data points based on sampling steps

M = zeros(3000/df*mult,15000/dt*mult); 

count = 1;    % Counter variable to aid in matrix data placement

t = -7500*mult:dt:7499*mult;    % Create a vector to iterate over t values.

% Iterate over a range of FDOA values, ranging the 3000 kilometer distance

for f = -1500*mult:df:1500*mult
    
    % Compute the individual pdfs based on different values
    % and store into matrix M.
               
    pdf_f = (1/sqrt(2*pi*var_F))*exp(-.5*((f/std_F)^2));
    pdf_t = (1/sqrt(2*pi*var_T))*exp(-.5*((t./std_T).^2));
            
    M(count,:) = pdf_f * pdf_t;
    
    count = count + 1;
    
end

x = -7500*mult:dt:7499*mult;
y = -1500*mult:df:1500*mult;

% Create a plot for Part D.

figure
surf(x,y,M)
ylabel('Y distance (m)')
xlabel('X distance (m)')
zlabel('PDF(f,t)')
title('CAF Error Analysis')

%% Part E: Confidence Interval Analysis

% Variance and standard deviation calculated for TDOA Error

var_T = 2*(std_p^2) + std_tdoa^2;
std_T = sqrt(var_T);

% Variance and standard deviation calculated for FDOA Error

var_F = 2*(std_v^2) + ((alpha^2 * std_p^2)/(lambda^2)) + std_fdoa^2;
std_F = sqrt(var_F);

mult = 6;   % Multiplicity value to increase plotting range increased range

% Set sample steps for each of the ranges

df = 500;
dt = 500;

% Create vector to store data points based on sampling steps

M = zeros(3000/df*mult,15000/dt*mult);

count = 1;    % Counter variable to aid in matrix data placement

t = -7500*mult:dt:7499*mult;    % Create a vector to iterate over t values.

% Iterate over a range of FDOA values, ranging the 3000 kilometer distance

for f = -1500*mult:df:1500*mult
    
    % Compute the individual pdfs based on different values
    % and store into matrix M.
               
    pdf_f = (1/sqrt(2*pi*var_F))*exp(-.5*((f/std_F)^2));
    pdf_t = (1/sqrt(2*pi*var_T))*exp(-.5*((t./std_T).^2));
            
    M(count,:) = pdf_f * pdf_t;
    
    count = count + 1;
    
end

x = -7500*mult:dt:7499*mult;
y = -1500*mult:df:1500*mult;

% Create a matrix to fit an ellipse inside.

C = zeros(size(M));

for m = 1:size(M,1)
    for n = 1:size(M,2)
        
        % Which squares are inside the ellipse?  Lets mark them with 1's.
        % Axis come from 2 std devs, which represents the 95% confidence
        % interval.  This is building a contour map which will color
        % the resultant graph.
        
        if ((m*df-size(M,1)*df/2)^2/(2*std_F)^2 + (n*dt-size(M,2)*dt/2)^2/(2*std_T)^2)<1
           C(m,n) = 1; 
           
        end
    end
end

% Now, use our ellipse to color the hill and plot the confidence interval
% for Part E.

figure
surf(x,y,M,C)
ylabel('Y distance (m)')
xlabel('X distance (m)')
zlabel('PDF(f,t)')
title('95% Confidence Interval for Emitter Location Accuracy')

%% Part F: Helicopter Dynamics

% Tilt the frequency axis by 45 degrees. The variance would change be
% the square root of 2 to account for the new shift.

std_F = std_F * sqrt(2);
var_F = std_F ^ 2;

count = 1;    % Counter variable to aid in matrix data placement
mult = 2; % Multiplicity value to increase plotting range increased range

% Set sample steps for each of the ranges

df = 250;
dt = 250;

% Create vector to store data points based on sampling steps

M = zeros((((3000*sqrt(2)+15000)/df)*mult)+1,15000/dt*mult); 

% Develop an offset for variables since the graph is now being streched
% in the f dimension to account for the 45 degree shift.

t_offset = 0;
f_offset = 7500*mult;

f = -((3000*sqrt(2)+15000)/2)*mult:df:((3000*sqrt(2)+15000)/2)*mult;

for t = -7500*mult:dt:7499*mult;

    % To account for the angular change in frequency, shift the each pdf_f 
    % over by the current number of time steps * the dt change.
    % Take each pdf at f = f + count_f*df - f_offset- 1.
    
    pdf_f = (1/sqrt(2*pi*var_F))*exp(-.5*(((f+count*df-f_offset-1)./std_F).^2));
    
    pdf_t = (1/sqrt(2*pi*var_T))*exp(-.5*(((t+t_offset)/std_T)^2));
    
    M(:,count) = pdf_f * pdf_t;
    
    count = count + 1;
    
end

% Plot the newly shifted pdf for Part F.

x = (-7500)*mult:dt:(7499)*mult;
y = -((3000*sqrt(2)+15000)/2)*mult:df:((3000*sqrt(2)+15000)/2)*mult;

figure
surf(x,y,M)
ylabel('Y distance (m)')
xlabel('X distance (m)')
zlabel('PDF(f,t)')
title('Helicopter Dynamics - 45 Degree Shift')
