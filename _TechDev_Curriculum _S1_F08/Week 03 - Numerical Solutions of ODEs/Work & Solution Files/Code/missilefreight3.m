% Clear working environment
clear all;
close all;

% Position of NY
yi = 0;
xi = 0; 

% Radius of the Earth 
Re = 6378100;
  
% Position of LA  
xLA = 3719800;
yLA = 5181040-Re;  

% Guess initial velocity
vi = 6200;

% Loop control variables
hit = false;
last = 'X';

% Hit Threshold
Th = 100;

% Velocity initial step size
step = 1000;

% Placeholders for optimal answers
minV = 10000000000;
minAngle = 0;
  
%OPTIMUM SOLUTION SEARCH
% For all integer angles between 30 and 40  
for angle = 30:40
    % If LA has not been hit
    while ~hit
        
        % Calculate initial x and y velocities from angle
        theta = angle*pi/180;
        vyi = vi*sin(theta);
        vxi = vi*cos(theta);

        % Store them in working variables
        y=yi;
        x=xi;
        vx=vxi;
        vy=vyi;
        
        % R-K Step size
        h=.02;

        % Loop R-K until missile hits the ground (y=circle eqn)
        while y>=sqrt(-x^2+Re^2)-Re && x<Re
            [x,y,vx,vy]=findNextStepThree(h,x,y,vy,vx);
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
            
            % Reset initial step
            step = 1000;
        
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
x=xi;
vx=vxi;
vy=vyi;

% R-K step size
h=.02;

% Initialize some arrays to store flight data
yf = [];
xf = [];
vyf = [];
vxf = [];

% While the missile is in the air (y>Circle equation)
while y>=sqrt(-x^2+Re^2)-Re && x<Re
    % Loop R-K, Store flight info
    [x,y,vx,vy]=findNextStepThree(h,x,y,vy,vx);
    yf=[yf y];
    xf=[xf x];
    vyf=[vyf vy];
    vxf=[vxf vx];
end

% Find an equation for the ground
worldx = 0:10:4000000;
worldy = sqrt(Re^2-worldx.^2)-Re;

% Plot trajectory, Ground, and LA
plot([xi xf],[yi yf],worldx,worldy,xLA,yLA,'X');