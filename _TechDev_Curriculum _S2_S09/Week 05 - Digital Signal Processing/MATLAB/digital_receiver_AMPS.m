% Digital Receiver Simulation
% Team Finck BIG!

%% Create the analog signal that will be processed. 

clear all;
close all;
clc;

% Determine number of bits to recreate a signal, states, define a signal to
% noise (SNR ratio), and our oversampling rate in MHz.

num_bits  =    512;
states    =      4;
SNR       =     30;
oversamp  =    200;     % Simulates sampling frequency of 30kHz.

% Create a random bit stream to recreate our signal using the pskmod.

bits    = randint(1,num_bits,[0,states-1]);
mod_sig = pskmod(bits,states);

% Recreate the analog signal through the resampling command.

analog_sig = resample(mod_sig,oversamp,1);

% Determine the frequency content of the analog signal.

fd_ana_sig = fft(analog_sig);

% Build the normalized frequency labels for the analog signal,
% then multiply by 40 to get it between -20 - 20 MHz.

freqs = (((0:length(fd_ana_sig)-1)/length(fd_ana_sig))-.5) * 40;

% Inject noise into the signal to simulate the transmission channel.

noisy_sig    = awgn(analog_sig,SNR);
fd_noisy_sig = fft(noisy_sig);

% Build time array that will be used to perform frequency shift operations.

tstep       = (1/oversamp);
time_array  = 0 :tstep :num_bits - tstep;

% Build in frequency shifts to 'emulate' a possible input signal.
% Our signal of interest if centered around 16 MHz.

freq_shift1 = 16 * (oversamp/40);
freq_shift2 = -3 * (oversamp/40);
freq_shift3 = 10 * (oversamp/40);
freq_shift4 = -9 * (oversamp/40);

our_waveform = noisy_sig.*exp(j*2*pi*freq_shift1*time_array)...
             + .1*noisy_sig.*exp(j*2*pi*freq_shift2*time_array)...
             + .2*noisy_sig.*exp(j*2*pi*freq_shift3*time_array)...
             + .3*noisy_sig.*exp(j*2*pi*freq_shift4*time_array);
         
% Plot the input signal in the frequency domain.
         
fd_our_waveform = fft(our_waveform);

figure;
hold on;
plot(freqs,20*log10(abs(fftshift(fd_our_waveform))),'r');
legend('Output of the A/D Converter')
title('Input Signal in Frequency Domain');
grid on;

%% This is where our assignment begins to process the signal.

% Any processing will be shown in the frequency domain.
% The signal, since created, has followed the following RF path:

%   Passed through a Comm Channel                    --->
%   Digital to Analog converesion                    --->
%   Gaussian Noise added from Tramission Channel     ---> 
%   Add any other signals that may be in the channel 


% Pass our signal through a Direct Digital Synthesis, Variable Frequency
% Oscillator (DDS-VFO) and shift it down by 16 MHz.

% immediately downshift
% DDS-VFO

downshifted_sig     = our_waveform.*exp(-j*2*pi*freq_shift1*time_array);
fd_downshifted_sig  = fft(downshifted_sig);

% Build an FIR filter to solve this issue ---> help firpmord

% Passband ripple (dB)
rp = 1;
% Stopband level  (dB)
rs = 60;          
% Sampling frequency
fs = oversamp;      
% Cutoff frequencies, defined to encompass the BW of our SOI.
f = [.5,1.5];
% Desired amplitudes
a = [1,0];        
% Compute deviations
dev = [(10^(rp/20)-1)/(10^(rp/20)+1),10^(-rs/20)]; 
[n,fo,ao,w] = firpmord(f,a,dev,fs);

% Filter variables are determined here:

figure;
my_filter = firpm(n,fo,ao,w);
freqz(my_filter,1,1024,fs);
title('Lowpass Filter Designed to Specifications');

% filter 
filtered_wave = filter(my_filter,1,downshifted_sig);
fd_filtered_wave = fft(filtered_wave);

% Show our newly centered signal centered at 0 MHz

figure;clf;
hold on;
plot(freqs,20*log10(abs(fftshift(fd_downshifted_sig))));
plot(freqs,20*log10(abs(fftshift(fd_filtered_wave))),'r');
legend('Noisy AMPS signal after DDS-VFO','Filtered AMPS Signal');
grid on;
