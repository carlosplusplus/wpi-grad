% Created by Christopher C. Rappa
clear all; clc;
%% Universal Constants
RAS = 3957E3;           % (m) NY to LA is 3957 surface kilometers
RE = 6378.1E3;          % (m) Spherical radius of the earth
theta = RAS/RE;         % (rad) Angle measure NY to LA from COE(center of earth) s = r (theta) 
RA = 2*RE*sin(theta/2); % (m) NY to LA direct linear miles
g = 9.8;                % (m/s^2) Acceleration of gravity at sea level

%% Problem 1 
h = 0.1;      % Interval for Runge-Kutta method
Px0 = 0;      % (m) Initial position for x
Py0 = 0;      % (m) Initial position for y
E0 = pi/4;    % (rad) Initial launch angle (relative to local ground)

Vx0 = sqrt(g*RAS/2);    % (m/s) Vx - initial velocity
Vy0 = Vx0*tan(E0);      % (m/s) Vy - initial velocity

[Px, Py, Vx, Vy, t] = RK_Integration(h, RAS, -1, Px0, Py0, Vx0, Vy0, 1, 0);

plot(Px,Py,'k')         % Plot the missle trajectory 

xlabel ('Distance (m)'), ylabel('Altitude (m)');
title({'Problem 1 - Ideal Missle Trajectory'; ...
       'Flat Earth with Constant Gravity'});
xlim([0 RAS]), ylim([0 max(Py)*1.1]); %CR

%% Problem 2 - Curved Earth Constant Gravity
figure;
h = 0.1;      % (s) time interval for Runge-Kutta method
Px0 = 0;      % (m) Initial position for x
Py0 = RE;     % (m) Initial position for y

PyF = (2*RE^2 - RA^2)/(2*RE); % (m) Final position for x
PxF = sqrt(RE^2 - PyF^2);     % (m) Final position for y

plot(PxF, PyF,'x')

N = 20;
E0 = linspace(pi/16,pi/4,N);

V0 = 6000;
fit = [6000]; 

for num = 1:2 
V0versusE0 = polyval(fit,E0);
hold on;
for j = 1:N % (rad) Initial launch angle (relative to local ground)   
    V0 = V0versusE0(j);
    %V0 = 0.9*V0;
    errorX = PxF;
    % P = 0.002 Minimum Oscillatory P value
    P = 0.0012; % Ziegler-Nichols Method tuned Porportional gain
    while (abs(errorX) > 200)
        [Px, Py, Vx, Vy, t] = RK_Integration(h, PxF, PyF, Px0, Py0, ...
                                             V0*cos(E0(j)), V0*sin(E0(j)), 2, 0);
        PxR = Px(size(t,2));
        % Adaptive Porportion Controller
        if abs(PxF - PxR) >= abs(errorX) %Adaptive control to minimize error oscillation
            P = 0.5*P;
        end
        errorX = (PxF - PxR);
        % Feedback error for V0 correction
        V0 = V0 + P * errorX;
    end
    % Plot the Initial velocity (V0) for current launch angle (E0)
    plot(Px,Py,'Color',[rand rand rand]) % Random color for each new angle set
    V0final(j) = V0;
end

plot(Px,sqrt(RE^2 - Px.^2),'g')
xlabel ('Distance (m)'), ylabel('Altitude (m)');
title({'Problem 2 - Possible Missle Trajectories';...
       'Curved Earth with Constant Gravity'}); 
hold off; %CR
figure
fit = polyfit(E0,V0final,8);
V0versusE0  = polyval(fit,E0);
end

% Find minimum of fit curve
exponent = (size(fit,2)-1):-1:0;
polydiff = fit(1:(size(fit,2)-1)).*((size(fit,2)-1):-1:1);
diffexponent = (size(polydiff,2)-1):-1:0;
E0min =roots(polydiff);
E0min = E0min(imag(E0min)==0);
E0min = E0min(pi/16<E0min); E0min = E0min(E0min<pi/4);
V0min = polyval(fit,E0min);
hold on;
plot(E0min, V0min,'x');
text(E0min, V0min, strcat('     \leftarrow\fontname{times}E_0_{min} at E_0 = ', num2str(E0min), ' rad'),...
                          'HorizontalAlignment','left'),...
% Plot the fit curve of the V0 and E0 
plot(E0,V0final);
hold off;
xlabel ('E_0 - Launch Angle (rad)'), ylabel('V_0 - Initial Velocity (m/s)');
title('Problem 2 - V_0 versus E_0'); 
xlim([pi/16 pi/4]); %CR

% Plot the Ideal trajectory
figure
V0 = polyval(fit, E0min);
[Px, Py, Vx, Vy, t] = RK_Integration(h, PxF, PyF, Px0, Py0, ...
                                     V0*cos(E0min), V0*sin(E0min), 2, 0);
errorX = (PxF - PxR);
hold on;
plot(Px,Py,'b');
plot(Px,sqrt(RE^2 - Px.^2),'g')
xlabel ('Distance (m)'), ylabel('Altitude (m)');
title({'Problem 2 - Ideal Missle Trajectory';...
       'Curved Earth with Constant Gravity';...
       strcat('Ideal Trajectory: V_0 = ', num2str(V0), ' m/s and ', ...
              'E_0 = ', num2str(E0min), ' rad'); ...
       strcat('Off by ',num2str(errorX), ' m')}); 
xlim([min(Px) max(Px)]), ylim([min(Py) max(Py)]); 
hold off; %CR

%% Problem 3 - Curved Earth with Varying Gravity
figure;
plot(PxF, PyF,'x')

V0 = 6000;
fit = [6000]; 

for num = 1:2 
V0versusE0 = polyval(fit,E0);
hold on;
for j = 1:N % (rad) Initial launch angle (relative to local ground)   
    V0 = V0versusE0(j);
    errorX = PxF;
    % P = 0.002 Minimum Oscillatory P value
    P = 0.0012; % Ziegler-Nichols Method tuned Porportional gain
    while (abs(errorX) > 200)
        [Px, Py, Vx, Vy, t] = RK_Integration(h, PxF, PyF, Px0, Py0, ...
                                             V0*cos(E0(j)), V0*sin(E0(j)), 3, 0);
        PxR = Px(size(t,2));
        % Adaptive Porportion Controller
        if abs(PxF - PxR) >= abs(errorX) %Adaptive control to minimize error oscillation
            P = 0.5*P;
        end
        errorX = (PxF - PxR);
        % Feedback error for V0 correction
        V0 = V0 + P * errorX;
    end
    % Plot the Initial velocity (V0) for current launch angle (E0)
    plot(Px,Py,'Color',[rand rand rand]) % Random color for each new angle set
    V0final(j) = V0;
end

plot(Px,sqrt(RE^2 - Px.^2),'g')
xlabel ('Distance (m)'), ylabel('Altitude (m)');
title({'Problem 3 - Possible Missle Trajectories';...
       'Curved Earth with Varying Gravity'}); 
hold off; %CR
figure
fit = polyfit(E0,V0final,8);
V0versusE0  = polyval(fit,E0);
end

% Find minimum of fit curve
exponent = (size(fit,2)-1):-1:0;
polydiff = fit(1:(size(fit,2)-1)).*((size(fit,2)-1):-1:1);
diffexponent = (size(polydiff,2)-1):-1:0;
E0min =roots(polydiff);
E0min = E0min(imag(E0min)==0);
E0min = E0min(pi/16<E0min); E0min = E0min(E0min<pi/4);
V0min = polyval(fit,E0min);
hold on;
plot(E0min, V0min,'x');
text(E0min, V0min, ['E_0_{min} at E_0 = ', num2str(E0min), ' rad \rightarrow       '],...
                   'HorizontalAlignment','right'),...
% Plot the fit curve of the V0 and E0 
plot(E0,V0final);
hold off;
xlabel ('E_0 - Launch Angle (rad)'), ylabel('V_0 - Initial Velocity (m/s)');
title('Problem 3 - V_0 versus E_0'); 
xlim([pi/16 pi/4]); %CR

% Plot the Ideal trajectory
figure
V0 = polyval(fit, E0min);
[Px, Py, Vx, Vy, t] = RK_Integration(h, PxF, PyF, Px0, Py0, ...
                                     V0*cos(E0min), V0*sin(E0min), 3, 0);
errorX = (PxF - PxR);
hold on;
plot(Px,Py,'b');
plot(Px,sqrt(RE^2 - Px.^2),'g')
xlabel ('Distance (m)'), ylabel('Altitude (m)');
title({'Problem 3 - Ideal Missle Trajectory';...
       'Curved Earth with Varying Gravity';...
       ['Ideal Trajectory: V_0 = ', num2str(V0), ' m/s and ', ...
       'E_0 = ', num2str(E0min), ' rad']; ...
       ['Off by ',num2str(errorX), ' m']}); 
xlim([min(Px) max(Px)]), ylim([min(Py) max(Py)]); 
hold off; %CR

%% Problem 4 - Initial Thrust, Curved Earth with Varying Gravity
figure;
plot(PxF, PyF,'x')

N = 10;
E0 = linspace(pi/4,pi/8,N);
t =  222.7012;
fit = [t];
range = 1000;
for num = 1:2 
tvsE0 = polyval(fit,E0);
hold on;
for j = 1:N % (rad) Initial launch angle (relative to local ground)   
    t = tvsE0(j);
    errorX = PxF;
    % P = 0.002 Minimum Oscillatory P value
    P = 0.000017; % Ziegler-Nichols Method tuned Porportional gain
    while (abs(errorX) > range)
        [Px, Py, Vx, Vy, tF] = RK_Integration(.1, PxF, PyF, Px0, Py0, 0, 0, E0(j), t);
        PxR = Px(size(tF,2));
        
        % Adaptive Porportion Controller
         if abs(PxF - PxR) >= abs(errorX) %Adaptive control to minimize error oscillation
             P = 0.99*P;
         end
        
        errorX = (PxF - PxR);
        t = t + P * errorX;
    end
    % Plot the Initial velocity (V0) for current launch angle (E0)
    plot(Px,Py,'Color',[rand rand rand]) % Random color for each new angle set
    tfinal(j) = t;
    %range = 200;
end

plot(Px,sqrt(RE^2 - Px.^2),'g')
xlabel ('Distance (m)'), ylabel('Altitude (m)');
title({'Problem 4 - Possible Missle Trajectories';...
       'Thrust Added - Curved Earth with Varying Gravity'}); 
hold off; %CR
figure
fit = polyfit(E0,tfinal,8);
tvsE0  = polyval(fit,E0);
end

% Find minimum of fit curve
exponent = (size(fit,2)-1):-1:0;
polydiff = fit(1:(size(fit,2)-1)).*((size(fit,2)-1):-1:1);
diffexponent = (size(polydiff,2)-1):-1:0;
E0min =roots(polydiff);
E0min = E0min(imag(E0min)==0);
E0min = E0min(pi/8<E0min); E0min = E0min(E0min<pi/4);
tmin = polyval(fit,E0min);
hold on;
plot(E0min, tmin,'x');
text(E0min, tmin, ['E_0_{min} at E_0 = ', num2str(E0min), ...
                  ' rad \rightarrow                '],...
                  'HorizontalAlignment','right')
% Plot the fit curve of the t0 and E0 
plot(E0,tfinal);
hold off;
xlabel ('E_0 - Launch Angle (rad)'), ylabel('t_0 - time of thrust (s)');
title('Problem 4 - t_0 versus E_0'); 
xlim([pi/8 pi/4]); %CR

% Plot the Ideal trajectory
figure
[Px, Py, Vx, Vy, tF] = RK_Integration(h, PxF, PyF, Px0, Py0, 0, 0, E0min, tmin);
PxR = Px(size(tF,2));
errorX = (PxF - PxR);
hold on;
plot(Px,Py,'b');
plot(Px,sqrt(RE^2 - Px.^2),'g')
xlabel ('Distance (m)'), ylabel('Altitude (m)');
title({'Problem 4 - Ideal Missle Trajectory';...
       'Thrust Added - Curved Earth with Varying Gravity';...
       ['Ideal Trajectory: t_0 = ', num2str(tmin), ' m/s and ', ...
       'E_0 = ', num2str(E0min), ' rad']; ...
       ['Off by ',num2str(errorX), ' m']}); 
xlim([min(Px) max(Px)]), ylim([min(Py) max(Py)]); 
hold off; %CR