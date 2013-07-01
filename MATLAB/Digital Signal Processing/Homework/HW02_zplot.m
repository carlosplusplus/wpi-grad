% Carlos Lazo
% ECE 503
% Homework #2
% Due: 2/1/10

function [X_z] = HW02_zplot (a)

close all;

% Define the area for which to plot the magnitude
% and create the surface which maps both the real
% and imaginary parts of the z plane.

z_plane = -5 : .1 : 5;

for ii = 1 : length(z_plane)
    for jj = 1 : length(z_plane)
        z(ii,jj) = z_plane(ii) + j*z_plane(jj);
    end
end

% The known Z-transform of x(k) = a^k * u(k)
% is Z(x) = 1 / 1 - a*z^(-1));

X_z = 1./(1-a*z.^(-1));

% Plot the magnitude of the Z-transform.

figure;

mesh(z_plane, z_plane, abs(X_z));
title('x(k) = a^k * u(k) <===> X(z) = 1 / [1 - a*(z^-1)], |z|>a for a = 0.5');
xlabel('Re(Z)');
ylabel('Im(Z)');
zlabel('|Z-Transform|');