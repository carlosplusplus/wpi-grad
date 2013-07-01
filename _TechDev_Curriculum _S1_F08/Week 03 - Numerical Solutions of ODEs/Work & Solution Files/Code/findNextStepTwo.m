function [x,y,vx,vy]=findNextStepTwo(h,xi,yi,vyi,vxi)
% Takes step size, initial x and y positions, and initial x and y
% velocities.  Calculates new x and y positions and velocities

g = -9.81;      % Acceleration due to gravity
re = 6378100;   %radius of the earth;

% Initial Gravity Vectors
phii = atan(xi/(re+yi));
gyi = g*cos(phii);
gxi = g*sin(phii);

% Determine 1st set of K values
ky1 = h*vyi;
kx1 = h*vxi;
kvy1 = h*gyi;
kvx1 = h*gxi;

% Determine 1st midpoint estimate values
ym1 = yi+0.5*ky1;
xm1 = xi+0.5*kx1;
vym1 = vyi+0.5*kvy1;
vxm1 = vxi+0.5*kvx1;

% New Gravity Vectors
phi1 = atan(xm1/(re+ym1));
gym1 = g*cos(phi1);
gxm1 = g*sin(phi1);

% Determine 2nd set of K values
ky2 = h*vym1;
kx2 = h*vxm1;
kvy2 = h*gym1;
kvx2 = h*gxm1;

% Determine 2nd midpoint estimate values
ym2 = yi+0.5*ky2;
xm2 = xi+0.5*kx2;
vym2 = vyi+0.5*kvy2;
vxm2 = vxi+0.5*kvx2;

% 3rd Gravity Vectors
phi2 = atan(xm2/(re+ym2));
gym2 = g*cos(phi2);
gxm2 = g*sin(phi2);

% Determine 3rd set of K values
ky3 = h*vym2;
kx3 = h*vxm2;
kvy3 = h*gym2;
kvx3 = h*gxm2;

% Determine 3rd midpoint estimate values
ym3 = yi+0.5*ky3;
xm3 = xi+0.5*kx3;
vym3 = vyi+0.5*kvy3;
vxm3 = vxi+0.5*kvx3;

% 4th Gravity Vectors
phi3 = atan(xm3/(re+ym3));
gym3 = g*cos(phi3);
gxm3 = g*sin(phi3);

% Determine 4th set of K values
ky4 = h*vym3;
kx4 = h*vxm3;
kvy4 = h*gym3;
kvx4 = h*gxm3;

% Determine 4th point estimate values
ym4 = yi+ky4;
xm4 = xi+kx4;
vym4 = vyi+kvy4;
vxm4 = vxi+kvx4;

% Last gravity vectors
phi4 = atan(xm4/(re+ym4));
gym4 = g*cos(phi4);
gxm4 = g*sin(phi4);

% Solve for next point
y = yi+1/6*(ky1+2*ky2+2*ky3+ky4);
x = xi+1/6*(kx1+2*kx2+2*kx3+kx4);
vy = vyi+1/6*(kvy1+2*kvy2+2*kvy3+kvy4);
vx = vxi+1/6*(kvx1+2*kvx2+2*kvx3+kvx4);