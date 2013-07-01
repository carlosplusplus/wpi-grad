% Carlos Lazo
% ECE 503 Final Project
% MATLAB Simulation of EMG Signal Filtering Techniques

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function emg_notch60() will apply a notch-filtering %
% technique to the EMG signal with the 60Hz power-line    % 
% interference.                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;      % Remove this line when ready.

% The following are inputs to the function:
%   EMG_sigN    = EMG signal with interference that is being filtered
%   N_Filt      = Order of the notch filter

N_Filt               = 5;                                       % Function INPUT

[EMG_sigC, EMG_sigN] = emg_sim(2,10);                           % Function INPUT

% The following are outputs to the function:
%   EMG_sigF    = EMG signal that has been filtered

% Define all static variables:

Fn              = 60;               % Frequency of power line interference
Fs              = 2048;             % Sampling Frequency of EMG, in Hz                           
Fb              =  5;               % Define the overall bandwidth of the filter
                                    % which will be 2*Fb
                                    
Fb_N            = Fb / (Fs/2);      % Normalize Fb in terms of Fs for filtering,
                                    % then define the normalized range at where
                                    % the stopband filter will effectively
                                    % notch out the frequency of interest (Fn)

W_n             = [(((Fn)/(Fs/2)) - Fb_N) (((Fn)/(Fs/2)) + Fb_N)];

% !!!!!!!!!!!!!!!!!!!!!!!! %
% ! Function Declaration ! %
% !!!!!!!!!!!!!!!!!!!!!!!! %

% Use an IIR stopband Butterworth filter to clean the signal using a
% zero-phase linear time-invariant (LTI) filter.  The output from the
% filter will have the magnitude squared.
                               
[b,a]       = butter(N_Filt, W_n, 'stop');

EMG_sigF    = filtfilt(b, a, EMG_sigN);                         % Function OUTPUT

% For debug purposes:

figure;
plot(EMG_sigF);

figure;
freqz(b,a);

RMS_C = sqrt (mean (EMG_sigC .^ 2));
RMS_F = sqrt (mean (EMG_sigF .^ 2));

DIFF = ((abs(RMS_C - RMS_F)) / RMS_C) * 100