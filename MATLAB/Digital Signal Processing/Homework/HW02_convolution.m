% Carlos Lazo
% ECE 503
% Homework #2
% Due: 2/1/10

function [y Ty] = HW02_convolution (x,Tx,h,Th)

close all;

% Compute the # of elements in each of the vectors.

nx = length(x);
nh = length(h);

% The length of the output will be nx + nh - 1 in size.

ny = nx + nh - 1;

% Create new vectors with padded 0's for computational purposes.
% This will force both vectors to be of equal length.

X = [x, zeros(1,nh)];
H = [h, zeros(1,nx)];

% Now perform the convolution loop, going from 1 to ny:

for ii = 1 : ny
    
    % Set each element in the output initially to 0.
    y(ii) = 0;
    
    % Iterate across the first signal.
    for jj = 1 : (nx)
        
        % Define kk, which will determine the existance of signal H.
        kk = ii - jj + 1;
        
        % Assuming that the index is valid location for the current step,
        % compute the convolution sum at that specific step.
        
        if (kk > 0)
            y(ii) = y(ii) + X(jj) * H(kk);
        end
    end
end

% Define the time-step of the new output variable,
% and adjust the time vector by the signal k offsets. 

k = 0 : length(y) - 1;
k = k - (Tx + Th - 2);

figure;

% Define the new signal origin in terms of the original signal times.

Ty = Tx + Th - 1;

%Plot the convolution result, and post all information to the plot.

stem (k, y);
xlabel({'k'; ' '; ['y(k) = ' num2str(y)]; ['k = 0 located @ MATLAB array index: ' num2str(Ty)]; });
ylabel('y(k)');
title({'Convolution of x * h '; ['Tx = ' num2str(Tx) ', Th = ' num2str(Th)]});