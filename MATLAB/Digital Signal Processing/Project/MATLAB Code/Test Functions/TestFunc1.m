% Carlos Lazo
% ECE 503 Final Project
% MATLAB Simulation of EMG Signal Filtering Techniques

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function emg_sim() serves to simulate an EMG signal %
% that has been sampled at 2048Hz. This signal will then  %
% be used to help compare different filtering techniques. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;      % Remove this line when ready.

% The following are inputs to the function:
%   t_s         = length of EMG signal, in seconds
%   Rel_Mag     = relative magnitude of noise with respect to EMG

% The following are outputs to the function:
%   EMG_sigC    = EMG signal without interference (clean)
%   EMG_sigN    = EMG signal with 60Hz interference (noisy)

t_s         = 1;                                                % Function INPUT
Rel_Mag     = 10;                                               % Function INPUT

% Define all static variables:

Fc          = 150;              % Cutoff Freq of lowpass filter, in Hz
Fn          = 60;               % Frequency of power line interference
Fs          = 2048;             % Sampling Frequency of EMG, in Hz
N_filt      = 4;                % Order for lowpass filter

                                % The length of the vector should be:
                                % Length(EMG) = Sampling Frequency * Time + Transient
                                
n           = (Fs * t_s) + (N_filt - 1);

% !!!!!!!!!!!!!!!!!!!!!!!! %
% ! Function Declaration ! %
% !!!!!!!!!!!!!!!!!!!!!!!! %

% Seed the random number generator, and create a Gaussian
% random vector that will model the EMG signal.

randn ('state', sum (100*clock));

EMG_sig     = randn(1, n);

% Create a 4th-order Butterworth lowpass filter, and pass
% the EMG signal through it.  Cutoff frequency is at 150Hz.
% The resulting signal will be the "clean" EMG.

[b, a]      = butter(N_filt, (Fc)/(Fs/2), 'low');
EMG_sigC    = filter(b, a, EMG_sig);                            % Function OUTPUT

% Compute the RMS value of the "clean" EMG.

RMS         = sqrt (mean (EMG_sigC .^ 2));

% Create an appropriately-scaled signal to model the 60Hz
% power-line interference.

Noise_sig   = RMS * Rel_Mag * sin(2 * pi * (Fn / Fs) * (1:n) );

% Add the power line interference into the clean signal, and
% eliminate the startup transient from the lowpass filter.

EMG_sigN    = EMG_sigC + Noise_sig;

EMG_sigN    = EMG_sigN (N_filt : n);                             % Function OUTPUT

% For debug purposes:

figure;
plot(EMG_sig);
figure;
plot(EMG_sigC);
figure;
w = 2 * pi * [0:length(EMG_sigC)-1] / length(EMG_sigC);
plot(w,abs(fft(EMG_sigC)));
figure;
plot(Noise_sig);
figure;
plot(EMG_sigN);
figure;
w = 2 * pi * [0:length(EMG_sigN)-1] / length(EMG_sigN);
plot(w,abs(fft(EMG_sigN)));