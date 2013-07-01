% SPEC_RESOLUTION: Matlab script to check resolving power of FFT and
% tapered windows prior to FFT

%% Important parameters
Fs = 1000;      % Sample rate
F1 = 113;       % Freq of first tone
F2 = F1 + 2;  % Freq of second tone

%% Create signals
Ts = 1./Fs;     % Sample period
t = [0:1023] *Ts;   % Time samples
sig = sin(2*pi*F1*t) + 0.1*sin(2*pi*F2*t);

%% Window and FFT
% w = hamming(1024).';
% sig = sig .* w;

%% FFT and plot
spec = abs( fft( sig ));
f = [0:1023]*Fs./1024;
plot( f, spec )


