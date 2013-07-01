% Carlos Lazo
% ECE 503 Final Project
% MATLAB Simulation of EMG Signal Filtering Techniques

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function emg_freq_null() will apply a DFT frequency- %
% nulling technique to the EMG signal with the 60Hz power- %
% line interference.                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;      % Remove this line when ready.

% The following are inputs to the function:
%   EMG_sigN    = EMG signal with interference that is being filtered

[EMG_sigC, EMG_sigN] = emg_sim(3,10);                           % Function INPUT

% The following are outputs to the function:
%   EMG_sigF    = EMG signal that has been filtered

% Define all static variables:

Fn          = 60;               % Frequency of power line interference
Fs          = 2048;             % Sampling Frequency of EMG, in Hz                           
Fb          =  5;               % Define the overall bandwidth of the filter
                                % which will be 2*Fb
                                    
N           = length(EMG_sigN); % Length of DFT of noisy EMG signal

% !!!!!!!!!!!!!!!!!!!!!!!! %
% ! Function Declaration ! %
% !!!!!!!!!!!!!!!!!!!!!!!! %

% Compute the N-length DFT of the noisy EMG signal:

X_k         = fft(EMG_sigN, N);

% Compute the indeces at where the 60Hz signal is located.
% Add +1 to the index since 0Hz is included in the signal.

k1          = ((Fn * N) / Fs) + 1;
k2          = N - k1 + 2;

% Compute the nulling-range based off the given bandwidth.

R           = ((Fb * N) / Fs) + 1;

% Null the frequencies around both positive and negative 
% locations of the DFT.

X_k ( (k1 - R) : (k1 + R) ) = 0;
X_k ( (k2 - R) : (k2 + R) ) = 0;

% Take the inverse DFT to get the filtered signal.

EMG_sigF    = ifft(X_k);

% For debug purposes:

figure;
plot(abs(fft(EMG_sigN, N)));
figure;
plot(abs(X_k));

RMS_C = sqrt (mean (EMG_sigC .^ 2));
RMS_F = sqrt (mean (EMG_sigF .^ 2));

DIFF = ((abs(RMS_C - RMS_F)) / RMS_C) * 100