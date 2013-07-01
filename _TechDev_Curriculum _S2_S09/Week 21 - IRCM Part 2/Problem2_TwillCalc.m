% ELDP IRCM - Week 2 Assignment
% Team Plan B
% Date: 6/9/09
% Coded by: Carlos Lazo

clear all; close all; clc;

% Using the geometry of the problem and the derived expression as seen
% in the Visio diagram, we first compute the BRDF angles of our system.
% We assume that the BRDF seen in each y row of our system is the same.

BRDF      = zeros(100,100);
Intensity = zeros(100,100);
Power     = zeros(100,100);

% Iterate across y-values in the 100x100 pixel matrix and compute all
% required BRDF angles.

% Compute the adjacent side of the triangle in question.

adjSide = cos(15 * (pi/180)) * 7;

for y = 1:100
    
    % For each step, we are further down in the pixel matrix.
    
    delta_y = 1.2 * (y / 100);
    
    % Compute the opposing side of the triangle in question.
    
    oppSide = (sin(15 *(pi/180)) * 7) + .6 - delta_y;
    
    % Compute the BRDF angle at that y displacement.
    
    theta = (atan(oppSide/adjSide)*(180/pi)) - 10;
    
    % Given the BRDF in the HW, assign the BRDF accordingly.
    
    BRDF(y,:) = (3.562e-11) * (theta ^ 5) - (8.717e-9)  * (theta ^ 4) + ...
                (7.670e-7)  * (theta ^ 3) - (2.910e-5)  * (theta ^ 2) + ...
                (3.523e-4)  * (theta)     + (6.603e-3);
    
end  

% Now that we have the BRDF angles, compute the Intensity of the pixel map
% given the equation in the assignment.

std_dev = 3E-3;
dist    = 400;

for x = 1:100
    for y = 1:100
        
        % Much like when computing BRDF, we must scale the distance that we
        % are away from the center of the pixel map.
        
        radius = sqrt((1.2 * (50 - x) / 100) ^ 2 + (1.2 * (50 - y) / 100)^2);
        
        % Now compute the Intensity matrix given the equation:
        
        Intensity(x,y) = exp((-(radius/dist) ^ 2) / (std_dev ^ 2));
    end
end

% Finally, compute the Power Matrix.

for x = 1:100
    for y = 1:100
        Power(x,y) = BRDF(x,y) * Intensity(x,y);
    end
end

imagesc(Power);

power_sum = sum(sum(Power));
centroid_x = 0;
centroid_y = 0;
for x = 1:100
    for y = 1:100
        centroid_x = centroid_x + x * Power(x,y) / power_sum;
        centroid_y = centroid_y + y * Power(x,y) / power_sum;
    end
end

[centroid_x, centroid_y]

centroid_error = sqrt((50-centroid_x)^2 + (50-centroid_y)^2)