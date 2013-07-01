% PLOT_SPEC: Matlab function to check resolving power of FFT and
% tapered windows prior to FFT. (Try running plot_spec( 1024, 100, 0.01, 'hamming' ) )

function plot_spec( sample_size, freq_diff_Hz, tone2_amplitude, window_type )

% Important parameters
Fs = 1000;      % Sample rate
F1 = 113;       % Freq of first tone
F2 = F1 + freq_diff_Hz;  % Freq of second tone

% Create signals
Ts = 1./Fs;     % Sample period
t = [0:sample_size-1] *Ts;   % Time samples
sig = sin(2*pi*F1*t) + tone2_amplitude*sin(2*pi*F2*t);

% Window and FFT
switch( window_type )
    case {'rectangular', 'boxcar'}
        w = ones(1, sample_size);
    case 'hamming'
        w = hamming( sample_size ).';
    otherwise
        error( ['Unknown window type: ', window_type] )
end;
sig = sig .* w;

% FFT and plot
spec = abs( fft( sig ));
f = [0:sample_size-1]*Fs./sample_size;
plot( f, 20*log10(spec) );
return;
