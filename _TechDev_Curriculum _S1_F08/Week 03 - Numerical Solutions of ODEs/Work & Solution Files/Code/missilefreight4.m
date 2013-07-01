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
vi = 0;

% Loop control variables
hit = false;
last = 'X';

% Hit Threshold
Th = 1000;

% Thrust Time Initial Step Size
step = 100;

% Thrust Value and Initial Thrust Time
thrust = 33.3;
tThrust = 200;

% Placeholders for optimal answers
minT = 10000000000;
minAngle = 0;
             
%OPTIMUM SOLUTION SEARCH
% For all integer angles between 20 and 40         
for angle = 20:40
    % If LA has not been hit
    while ~hit
        
        % Calculate initial x and y velocities from angle
        theta = angle*pi/180;
        vyi = vi; % 0
        vxi = vi; % 0

        % Store them in working variables
        y=yi;
        x=xi;
        vx=vxi;
        vy=vyi;
        
        % R-K Step size
        h=.02;
        
        % Calculate number of steps at h intervals to meet thrust time
        nThrust = ceil(tThrust/h);
       
        % Run R-K under Thrust conditions
        for i=1:nThrust
            [x,y,vx,vy]=findNextStepFourThrust(h,x,y,vy,vx,thrust,theta);
            % If we hit the ground under thrust, STOP!
            if y<sqrt(-x^2+Re^2)-Re
                break;
            end
        end
        
        % Loop R-K until missile hits the ground (y=circle eqn)
        while y>=sqrt(-x^2+Re^2)-Re && x<Re
            [x,y,vx,vy]=findNextStepThree(h,x,y,vy,vx);
        end
        
        % If result is a hit
        dist = xLA-x
        if xLA-Th<x && x<xLA+Th
            % If thrust time is lower than stored, store it and angle
            if tThrust<minT
                minT=tThrust
                minAngle = angle
            end
            
            % Set hit so we can move to the next angle
            hit = true;
            
            % Reset last for overshoot/undershoot
            last = 'H';
            
            step = 100;
            
        % If result is undershoot 
        elseif xLA-Th>=x
            % If last result was overshoot, we skipped over the city
            if last == 'O'
                step = step/2; % Reduce step size
            end
            
            % Set last to undershoot
            last = 'U';
            
            % Increase velocity
            tThrust = tThrust+step;

        % If result is overshoot
        else
            % If last result went to orbit, drastically reduce thrust time
            if x>Re
                tThrust = tThrust/2;
            else

                % If last result was underhoot, we skipped over the city
                if last == 'U'
                    step = step/2; % Reduce step size
                end
            
                % Decrease velocity
                tThrust = tThrust-step;
            end
            
            % Set last to overshoot
            last = 'O';                       
        end
    end
    
    % Reset hit
    hit = false;
end  
        
%NOW WE'RE GOING TO PLOT OPTIMAL SOLUTION!

% Get initial velocities from stored optimal theta and V
theta = minAngle*pi/180;
vyi = 0;
vxi = 0;

% Put it in working variables
y=yi;
x=xi;
vx=vxi;
vy=vyi;

% R-K step size
h=.02;

       
        % Calculate number of steps at h intervals to meet thrust time
        nThrust = ceil(minT/h);
        
        % Initialize some arrays to store flight data
        yf = [];
        xf = [];
        vyf = [];
        vxf = [];

        % Run R-K under Thrust conditions
        for i=1:nThrust
            [x,y,vx,vy]=findNextStepFourThrust(h,x,y,vy,vx,thrust,theta);
            % If we hit the ground under thrust, STOP!
            if y<sqrt(-x^2+Re^2)-Re
                break;
            end
            yf=[yf y];
            xf=[xf x];
            vyf=[vyf vy];
            vxf=[vxf vx];
        end
        
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
worldy = sqrt(6378100^2-worldx.^2)-6378100;

% Plot trajectory, Ground, and LA
plot([xi xf],[yi yf],worldx,worldy,3719800,5181040-6378100,'X');