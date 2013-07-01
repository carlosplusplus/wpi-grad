% Carlos Lazo
% ECE 503
% Homework #10
% Due: 04/05/10

function out_v = HW10_upsample(in_v, I)

    % Start by creating a vector to use for zero-insertion:
    
    zero_v = zeros(1, I * length(in_v));
    
    % Insert values of the input vector into the zero vector:
    
    for i = 1 : length(in_v), zero_v((i*I)-(I-1)) = in_v(i); end
    
    % Create a 10th-order butterworth filter for this model.
    % Lowpass filter at pi/I.
    
    N = 10;
    
    [b, a] = butter(N, 1/I);
    
    % Since we want a non-causual zero-phase filter, use filtfilt.
    % Need to multiply filter by gain I.
    
    out_v = I * filtfilt(b, a, zero_v);
