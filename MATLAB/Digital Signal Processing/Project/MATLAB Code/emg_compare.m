% Carlos Lazo
% ECE 503 Final Project
% MATLAB Analysis of EMG Signal Filtering Techniques

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function emg_compare() serves to output a scalar representation %
% of how close the filtered, noisy signal is to the actual clean      %
% EMG generated at the beginning of the simulation.                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following are inputs to the function:
%   EMG_sigC    = EMG signal without interference (clean)
%   EMG_sigF    = EMG signal with 60Hz interference removed (filtered)


% The following are outputs to the function:
%   Rel_Mag     = relative magnitude of noise with respect to EMG

function perc_diff = emg_compare(EMG_sigC, EMG_sigF)

% Define all static variables:

RMS_C       = sqrt (mean (EMG_sigC .^ 2));
RMS_F       = sqrt (mean (EMG_sigF .^ 2));

% !!!!!!!!!!!!!!!!!!!!!!!! %
% ! Function Declaration ! %
% !!!!!!!!!!!!!!!!!!!!!!!! %

% With both of the RMS values of the signals computed,
% figure out the percent difference between the original
% and filtered versions:

perc_diff = abs((RMS_C - RMS_F) / RMS_C) * 100;