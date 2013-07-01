function [y,x,vy,vx]=findNextStepOne(h,xi,yi,vyi,vxi)
% Takes step size, initial x and y positions, and initial x and y
% velocities.  Calculates new x and y positions and velocities

g = -9.81;      % Acceleration due to gravity - Constant

% Determine 1st set of K values
ky1 = h*vyi;
kx1 = h*vxi;
kvy1 = h*g;

% Determine 1st midpoint estimate values
ym1 = yi+0.5*ky1;
xm1 = xi+0.5*kx1;
vym1 = vyi+0.5*kvy1;

% Determine 2nd set of K values
ky2 = h*vym1;
kx2 = h*vxi;
kvy2 = h*g;

% Determine 2nd midpoint estimate values
ym2 = yi+0.5*ky2;
xm2 = xi+0.5*kx2;
vym2 = vyi+0.5*kvy2;

% Determine 3rd set of K values
ky3 = h*vym2;
kx3 = h*vxi;
kvy3 = h*g;

% Determine 3rd midpoint estimate values
ym3 = yi+0.5*ky3;
xm3 = xi+0.5*kx3;
vym3 = vyi+0.5*kvy3;

% Determine 4th set of K values
ky4 = h*vym3;
kx4 = h*vxi;
kvy4 = h*g;

% Determine 4th point estimate values
ym4 = yi+ky4;
xm4 = xi+kx4;
vym4 = vyi+kvy4;

% Solve for next point
y = yi+1/6*(ky1+2*ky2+2*ky3+ky4);
vy = vyi+1/6*(kvy1+2*kvy2+2*kvy3+kvy4);
x = xi+1/6*(kx1+2*kx2+2*kx3+kx4);
vx = vxi;