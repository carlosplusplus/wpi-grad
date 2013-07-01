% Clear working environment
clear all;
close all;

% Position of NY
yi = 0;
xi = 0;

% Position of LA
yLA = 0;
xLA = 3971530;

% Guess for initial velocity
vi = 6000;

% Hit Threshold
Th = 100;

% Loop control variables
hit = false;
last = 'X';

% Velocity initial step size
step = 1000;

% Placeholders for optimal answers
minV = 1000000000;
minAngle = 0;

%OPTIMUM SOLUTION SEARCH
% For all integer angles between 40 and 50
for angle = 40:50
    % If LA has not been hit
    while ~hit
       
        % Calculate initial x and y velocities from angle
        theta = angle*pi/180; 
        vyi = vi*sin(theta);
        vxi = vi*cos(theta);

        % Store them in working variables
        y=yi;
        vy=vyi;
        x=xi;
        vx=vxi;

        % R-K step size
        h=.02;

        % Loop R-K until missile hits the ground (y=0)
        while y>=yLA
            [y,x,vy,vx]=findNextStepOne(h,x,y,vy,vx);
        end

        % If result is a hit
        if xLA-Th<x && x<xLA+Th
            % If initial velocity lower than stored, store it and angle
            if vi<minV
                minV=vi
                minAngle = angle
            end
            
            % Set hit so we can move to the next angle
            hit = true;
            
            % Reset last for overshoot/undershoot
            last = 'H';
            
        % If result is undershoot
        elseif xLA-Th>=x         
            % If last result was overshoot, we skipped over the city
            if last == 'O'
                step = step/5; % Reduce step size
            end
            
            % Set last to undershoot
            last = 'U';
            
            % Increase velocity
            vi = vi+step;
            
        % If result is overshoot
        else
            % If last result was underhoot, we skipped over the city
            if last == 'U'
                step = step/5; % Reduce step size
            end
            
            % Set last to overshoot
            last = 'O';
            
            % Decrease velocity
            vi = vi-step;            
        end
    end
    
    % Reset hit
    hit = false;
end

%NOW WE'RE GOING TO PLOT OPTIMAL SOLUTION!

% Get initial velocities from stored optimal theta and V
theta = minAngle*pi/180; 
vyi = minV*sin(theta);
vxi = minV*cos(theta);

% Put it in working variables
y=yi;
vy=vyi;
vx=vxi;
x=xi;

% R-K step size
h=.02;

% Initialize some arrays to store flight data
yf = [];
vyf = [];
xf = [];

% While the missile is in the air (y>0)
while y>=yLA
    % Loop R-K, Store flight info
    [y,x,vy,vx]=findNextStepOne(h,x,y,vy,vx);
    yf=[yf y];
    vyf=[vyf vy];
    xf=[xf x];
end
 
% Plot trajectory, Ground, and LA
plot(0:4499999,zeros(1,4500000),[xi xf],[yi yf],xLA,0,'X');