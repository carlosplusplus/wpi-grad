% Clear working environment
clear all;
close all;

% Position of NY
xi = 0;
yi = 0;

% Radius of the Earth
Re = 6378100;

% Position of LA
xLA = 3719800;
yLA = 5181040-Re;

%% Missiles 1,2 in Missile World 2

% MISSILE 1
minAngle = 45;
minV = 6241.9;
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
yf1 = [];
xf1 = [];
vyf1 = [];
vxf1 = [];

% While the missile is in the air (y>Circle equation)
while y>=sqrt(-x^2+Re^2)-Re && x<Re
    % Loop R-K, Store flight info
    [x,y,vx,vy]=findNextStepTwo(h,x,y,vy,vx);
    yf1=[yf1 y];
    xf1=[xf1 x];
    vyf1=[vyf1 vy];
    vxf1=[vxf1 vx];
end
DIST1inWORLD2x = x-xLA
DIST1inWORLD2y = y-yLA

% MISSILE 2
minAngle = 30;
minV = 5840.4;
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
yf2 = [];
xf2 = [];
vyf2 = [];
vxf2 = [];

% While the missile is in the air (y>Circle equation)
while y>=sqrt(-x^2+Re^2)-Re && x<Re
    % Loop R-K, Store flight info
    [x,y,vx,vy]=findNextStepTwo(h,x,y,vy,vx);
    yf2=[yf2 y];
    xf2=[xf2 x];
    vyf2=[vyf2 vy];
    vxf2=[vxf2 vx];
end

DIST2inWORLD2x = x-xLA
DIST2inWORLD2y = y-yLA

% Find an equation for the ground
worldx = 0:10:4000000;
worldy = sqrt(6378100^2-worldx.^2)-6378100;

% Plot trajectory, Ground, and LA
plot([xi xf1],[yi yf1],[xi xf2],[yi yf2],worldx,worldy,3719800,5181040-6378100,'X');

%% MISSILES 1,2,3 in MISSILE WORLD 3

% MISSILE 1
minAngle = 45;
minV = 6241.9;

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
yf1 = [];
xf1 = [];
vyf1 = [];
vxf1 = [];

% While the missile is in the air (y>Circle equation)
while y>=sqrt(-x^2+Re^2)-Re && x<Re
    % Loop R-K, Store flight info
    [x,y,vx,vy]=findNextStepThree(h,x,y,vy,vx);
    yf1=[yf1 y];
    xf1=[xf1 x];
    vyf1=[vyf1 vy];
    vxf1=[vxf1 vx];
end

DIST1inWORLD3x = x-xLA
DIST1inWORLD3y = y-yLA

% MISSILE 2
minAngle = 30;
minV = 5840.4;

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
yf2 = [];
xf2 = [];
vyf2 = [];
vxf2 = [];

% While the missile is in the air (y>Circle equation)
while y>=sqrt(-x^2+Re^2)-Re && x<Re
    % Loop R-K, Store flight info
    [x,y,vx,vy]=findNextStepThree(h,x,y,vy,vx);
    yf2=[yf2 y];
    xf2=[xf2 x];
    vyf2=[vyf2 vy];
    vxf2=[vxf2 vx];
end

DIST2inWORLD3x = x-xLA
DIST2inWORLD3y = y-yLA

% MISSILE 3
minAngle = 36;
minV = 5414.5;

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
yf3 = [];
xf3 = [];
vyf3 = [];
vxf3 = [];

% While the missile is in the air (y>Circle equation)
while y>=sqrt(-x^2+Re^2)-Re && x<Re
    % Loop R-K, Store flight info
    [x,y,vx,vy]=findNextStepThree(h,x,y,vy,vx);
    yf3=[yf3 y];
    xf3=[xf3 x];
    vyf3=[vyf3 vy];
    vxf3=[vxf3 vx];
end

DIST3inWORLD3x = x-xLA
DIST3inWORLD3y = y-yLA

% Find an equation for the ground
worldx = 0:10:4000000;
worldy = sqrt(Re^2-worldx.^2)-Re;

% Plot trajectory, Ground, and LA
figure
plot([xi xf1],[yi yf1],[xi xf2],[yi yf2],[xi xf3],[yi yf3],worldx,worldy,xLA,yLA,'X');