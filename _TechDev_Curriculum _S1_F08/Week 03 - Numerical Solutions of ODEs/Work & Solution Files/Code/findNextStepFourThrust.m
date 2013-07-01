function [x,y,vx,vy]=findNextStepFourThrust(h,xi,yi,vyi,vxi,Th,theta)
% Takes step size, initial x and y positions, initial x and y
% velocities, and thrust magnitude and angle.  Calculates new x and y
% positions and velocities

m = 5.9736*10^24;       % Mass of the Earth
G = -6.67428*10^-11;    % Gravitational Constant
re = 6378100;           % Radius of Earth

% Initial Gravity Magnitude and Acceleration Vectors
phii = atan(xi/(re+yi));
ri = sqrt((yi+re)^2+xi^2);
gi = m*G/ri^2;
gyi = gi*cos(phii)+Th*sin(theta);
gxi = gi*sin(phii)+Th*cos(theta);

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

% Next Gravity Magnitude and Acceleration Vectors
phi1 = atan(xm1/(re+ym1));
r1 = sqrt((ym1+re)^2+xm1^2);
g1 = m*G/r1^2;
gym1 = g1*cos(phi1)+Th*sin(theta);
gxm1 = g1*sin(phi1)+Th*cos(theta);

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

% Next Gravity Magnitude and Acceleration Vectors
phi2 = atan(xm2/(re+ym2));
r2 = sqrt((ym2+re)^2+xm2^2);
g2 = m*G/r2^2;
gym2 = g2*cos(phi2)+Th*sin(theta);
gxm2 = g2*sin(phi2)+Th*cos(theta);

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

% 4th Gravity Magnitude and Acceleration Vectors
phi3 = atan(xm3/(re+ym3));
r3 = sqrt((ym3+re)^2+xm3^2);
g3 = m*G/r3^2;
gym3 = g3*cos(phi3)+Th*sin(theta);
gxm3 = g3*sin(phi3)+Th*cos(theta);

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

% Last Gravity Magnitude and Acceleration Vectors
phi4 = atan(xm4/(re+ym4));
r4 = sqrt((ym4+re)^2+xm4^2);
g4 = m*G/r4^2;
gym4 = g4*cos(phi4)+Th*sin(theta);
gxm4 = g4*sin(phi4)+Th*cos(theta);

% Solve for next point
y = yi+1/6*(ky1+2*ky2+2*ky3+ky4);
x = xi+1/6*(kx1+2*kx2+2*kx3+kx4);
vy = vyi+1/6*(kvy1+2*kvy2+2*kvy3+kvy4);
vx = vxi+1/6*(kvx1+2*kvx2+2*kvx3+kvx4);