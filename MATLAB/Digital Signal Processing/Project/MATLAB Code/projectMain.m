% Carlos Lazo
% ECE 503 Final Project
% MATLAB Analysis of EMG Signal Filtering Techniques


%% 2. Verification of Required Software - emg_sim()

clear all; close all; clc;

% This block of code will generate all graphs required for the 
% second section of the Report.

% Define all static variables.

Fs          = 2048;
t_s         = .1;
Rel_Mag     = 10;

% Generate clean and noisy signals.

[EMG_sigC, EMG_sigN] = emg_sim (t_s, Rel_Mag);

% Setup plotting vectors and compute the DFTs of both sequences:

t = (1:floor(Fs*t_s)) / Fs;

X_kC = fft(EMG_sigC);
fC = ((0 : length(X_kC) - 1) * Fs / length(X_kC));

X_kN = fft(EMG_sigN);
fN = ((0 : length(X_kN) - 1) * Fs / length(X_kN));

% First, plot the clean signal and its DFT magnitude:

figure('Name', 'emg_sim() Output');

subplot(2,1,1);
plot (t, EMG_sigC);
xlabel('Time (in sec)');
ylabel('Magnitude (Relative Units)');
title ('Clean Signal (no interference) from emg sim() Output');
grid on;

subplot(2,1,2);
plot(fC, abs(X_kC));
xlabel('Frequency (in Hz)');
ylabel('|X(k)| (Relative Units)');
title ('DFT Magnitude of Clean (no inteference) Signal');
grid on;

lim = [0 Fs min(abs(X_kC)) max(abs(X_kC))];
axis(lim);

% Second, plot the clean signal and its DFT magnitude:

figure('Name', 'emg_sim() Output');

subplot(2,1,1);
plot (t, EMG_sigN);
xlabel('Time (in sec)');
ylabel('Magnitude (Relative Units)');
title ('Noisy Signal (with 60Hz interference) from emg sim() Output');
grid on;

subplot(2,1,2);
plot(fN, abs(X_kN));
xlabel('Frequency (in Hz)');
ylabel('|X(k)| (Relative Units)');
title ('DFT Magnitude of Noisy (with 60Hz interference) Signal');
grid on;

lim = [0 Fs min(abs(X_kN)) max(abs(X_kN))];
axis(lim);

%% 2. Verification of Required Software - emg_notch()

clear all; close all; clc;

% For the emg_notch60() analysis, copy the code that is used to make
% the filter from emg_notch60() to show the frequency responses:

Fn              = 60;               % Frequency of power line interference
Fs              = 2048;             % Sampling Frequency of EMG, in Hz                           
Fb              =  5;               % Define the overall bandwidth of the filter
                                    % which will be 2*Fb
                                    
Fb_N            = Fb / (Fs/2);      % Normalize Fb in terms of Fs for filtering,
                                    % then define the normalized range at where
                                    % the stopband filter will effectively
                                    % notch out the frequency of interest (Fn)

W_n             = [(((Fn)/(Fs/2)) - Fb_N) (((Fn)/(Fs/2)) + Fb_N)];

N_FiltL         = 2;
N_FiltH         = 10;

% Develop lower and higher order Butterworth filters and plot
% the magnitude responses:
                               
[bL,aL]       = butter(N_FiltL/2, W_n, 'stop');
[bH,aH]       = butter(N_FiltH/2, W_n, 'stop');

figure('Name', 'emg notch60() Filter Design');
freqz(bL,aL);
title('2nd order stop-band Butterworth filter using emg notch60()');
grid on;

figure('Name', 'emg notch60() Filter Design');
freqz(bH,aH);
title('10th order stop-band Butterworth filter using emg notch60()');
grid on;

% Define static variables:

Fs          = 2048;
t_s         = 1;
Rel_Mag     = 10;

% Generate clean and noisy signals,
% then filter the signal through emg_notch60():

[EMG_sigC, EMG_sigN] = emg_sim (t_s, Rel_Mag);

EMG_sigF = emg_notch60(EMG_sigN, N_FiltH);

% Setup plotting vectors and compute the DFTs of both sequences:

t = (1:floor(Fs*t_s)) / Fs;

X_kN = fft(EMG_sigN);
fN = ((0 : length(X_kN) - 1) * Fs / length(X_kN));

X_kF = fft(EMG_sigF);
fF = ((0 : length(X_kF) - 1) * Fs / length(X_kF));

% First, plot the DFT magnitude of the noisy signal:

figure('Name', 'emg notch60 Verification');

plot(fN, abs(X_kN));
xlabel('Frequency (in Hz)');
ylabel('|X(k)| (Relative Units)');
title ('DFT Magnitude of Noisy (with 60Hz interference) Signal');
grid on;

lim = [0 Fs min(abs(X_kN)) max(abs(X_kN))];
axis(lim);

% First, plot the DFT magnitude of the noisy signal after filtering:

figure('Name', 'emg notch60 Verification');

plot(fF, abs(X_kF));
xlabel('Frequency (in Hz)');
ylabel('|X(k)| (Relative Units)');
title ('DFT Magnitude of Filtered (without 60Hz interference) Signal');
grid on;

lim = [0 Fs min(abs(X_kF)) max(abs(X_kF))];
axis(lim);

%% 2. Verification of Required Software - emg_freq_null()

% Define static variables:

Fs          = 2048;
t_s         =  1;
Rel_Mag     = 10;

% Generate clean and noisy signals,
% then filter the signal through emg_freq_null():

[EMG_sigC, EMG_sigN] = emg_sim (t_s, Rel_Mag);

EMG_sigF = emg_freq_null(EMG_sigN);

% Setup plotting vectors and compute the DFTs of both sequences:

t = (1:floor(Fs*t_s)) / Fs;

X_kN = fft(EMG_sigN);
fN = ((0 : length(X_kN) - 1) * Fs / length(X_kN));

X_kF = fft(EMG_sigF);
fF = ((0 : length(X_kF) - 1) * Fs / length(X_kF));

% First, plot the DFT magnitude of the noisy signal:

figure('Name', 'emg freq null Verification');

plot(fN, abs(X_kN));
xlabel('Frequency (in Hz)');
ylabel('|X(k)| (Relative Units)');
title ('DFT Magnitude of Noisy (with 60Hz interference) Signal');
grid on;

lim = [0 Fs min(abs(X_kN)) max(abs(X_kN))];
axis(lim);

% First, plot the DFT magnitude of the noisy signal after filtering:

figure('Name', 'emg freq null Verification');

plot(fF, abs(X_kF));
xlabel('Frequency (in Hz)');
ylabel('|X(k)| (Relative Units)');
title ('DFT Magnitude of Filtered (without 60Hz interference) Signal');
grid on;

lim = [0 Fs min(abs(X_kF)) max(abs(X_kF))];
axis(lim);

%% 3. Analysis: Notch Filter and its Start-Up Transient

clear all; close all; clc;

% Determine granularity for this simulation:

t_g                  = .1;   % Iterate every 100ms
N_g                  =  2;   % Increment by filter orders of 2
max_r                = 10;   % Max # of repetitions for each t_s sample

Rel_Mag              =  5;   % Signal to Noise Ratio (SNR)

% Ranging from t_s = 100ms - 5sec and from N = 2 to 10,
% develop a contour map of comparisons between the original signal
% and the filtered signal at the varying different combinations of
% time and filter order.

i = 1;
j = 1;

perc_diff = zeros(i,j);
rep_vals  = zeros(1,max_r);

for t_s = .1 : t_g : 5
    
    for N_filt = 2 : N_g : 10
        
        for r = 1 : max_r
        
            [EMG_sigC, EMG_sigN] = emg_sim (t_s, Rel_Mag);
        
            EMG_sigF = emg_notch60(EMG_sigN, N_filt);
            
            rep_vals(r) = emg_compare(EMG_sigC, EMG_sigF);
            
        end
            
        perc_diff(i,j) = mean(rep_vals);
        
        i = i + 1;
        
    end
    
    i = 1;
    j = j + 1;
end

% Generate a surface plot of the values:

figure('Name', 'Notch Filter with Startup Transient Analysis');
surf(perc_diff);
set(gca,'XTickLabel',(0 : 1 : 5));
set(gca,'YTickLabel',(2 : N_g : 10));
colorbar;

xlabel ('Time (in seconds)');
ylabel ('Filter Order');
zlabel ('Percent Difference (Out of 100%)');
title  ('Percent Difference across Notch Filter with Startup Transient');

[C,I]       = min(perc_diff(:));

% Find the smallest percent different between the original
% signal and the filtered signal, and find the corresponding
% time value and filter order.

R = mod(I,5);

if (R == 0)
    R = 5;
end
    
C = ceil(I/5);

minVal_ts   = C * t_g;
minVal_N    = R * N_g;
minVal      = perc_diff(R,C);

avgDiff     = mean(perc_diff(:));

%% 4. Analysis: Notch Filter WITHOUT its Start-Up Transient

clear all; close all; clc;

% Determine granularity for this simulation:

Fs                   = 2048; % Sampling frequency, in Hz
t_s                  =  3;   % Analyze a signal of 3 seconds
N_g                  =  2;   % Increment by filter orders of 2
max_r                = 10;   % Max # of repetitions for each filter iteration

Rel_Mag              =  5;   % Signal to Noise Ratio (SNR)

% Ranging from N = 2 to 10 and through truncating the transients,
% develop a plot of comparisons between the original signal
% and the filtered signal at the varying different combinations of
% filter order.

i = 1;

perc_diff = zeros(i);
rep_vals  = zeros(1,max_r);

    
for N_filt = 2 : N_g : 10
        
    for r = 1 : max_r
        
        [EMG_sigC, EMG_sigN] = emg_sim (t_s, Rel_Mag);
        
        % Truncate teh signal down to 2 seconds by discarding
        % .5 seconds at the head and tail, respectively.
        
        EMG_sigN = EMG_sigN( (1 + (Fs/2)) : ( (Fs * t_s) - (Fs/2)));
        
        EMG_sigF = emg_notch60(EMG_sigN, N_filt);
            
        rep_vals(r) = emg_compare(EMG_sigC, EMG_sigF);
            
    end
            
    perc_diff(i) = mean(rep_vals);
        
    i = i + 1;
        
end

figure('Name', 'Notch Filter WITHOUT Startup Transient Analysis');

stem ( (2 : N_g : 10), perc_diff);
xlabel ('Filter Order');
ylabel ('Percent Difference (Out of 100%)');
title  ('Percent Difference across Notch Filter WITHOUT Startup Transient');

axis ([0 11 0 10]);
grid on;

[C,I]       = min(perc_diff);

minVal_N    = I * N_g;
minVal      = perc_diff(I);
avgDiff     = mean(perc_diff);

%% 5. Analysis: Frequency Nulling

clear all; close all; clc;

% Determine granularity for this simulation:

t_g                  = .1;   % Iterate every 100ms
max_r                = 10;   % Max # of repetitions for each filter iteration

Rel_Mag              =  5;   % Signal to Noise Ratio (SNR)

% Ranging the signal duration from t_s = .1 to 5 seconds,
% develop a plot of comparisons between the original signal
% and the filtered signal at the varying different combinations of
% filter order when using frequency nulling.

i = 1;

perc_diff = zeros(i);
rep_vals  = zeros(1,max_r);
    
for t_s = .1 : t_g : 5
        
    for r = 1 : max_r
        
        [EMG_sigC, EMG_sigN] = emg_sim (t_s, Rel_Mag);
        
        EMG_sigF = emg_freq_null(EMG_sigN);
            
        rep_vals(r) = emg_compare(EMG_sigC, EMG_sigF);
            
    end
            
    perc_diff(i) = mean(rep_vals);
        
    i = i + 1;
        
end

figure('Name', 'Frequency Nulling Analysis');

stem ( (.1 : t_g : 5), perc_diff);
xlabel ('Signal Duration (seconds)');
ylabel ('Percent Difference (Out of 100%)');
title  ('Percent Difference using Frequency Nulling');

%axis ([0 6 0 20]);
grid on;

[C,I]       = min(perc_diff);

minVal_ts   = I * t_g;
minVal      = perc_diff(I);
avgDiff     = mean(perc_diff);

%% 6. Analysis: Relative Signal to Noise (SNR) Magnitude

clear all; close all; clc;

% Determine granularity for this simulation:

r_g                  = .5;   % Increment the SNR by .5 each iteration
t_g                  = .1;   % Iterate every 100ms
N_fix                =  6;   % Fix the filter order to be N = 6
max_r                = 10;   % Max # of repetitions for each t_s sample

% Ranging from t_s = 100ms - 5sec and from N = 2 to 10,
% develop a contour map of comparisons between the original signal
% and the filtered signal at the varying different combinations of
% time and filter order.

i = 1;
j = 1;

perc_diff = zeros(i,j);
rep_vals  = zeros(1,max_r);

for t_s = .1 : t_g : 5
    
    for Rel_Mag = 2 : r_g : 10
        
        for r = 1 : max_r
        
            [EMG_sigC, EMG_sigN] = emg_sim (t_s, Rel_Mag);
        
            EMG_sigF = emg_notch60(EMG_sigN, N_fix);
            
            rep_vals(r) = emg_compare(EMG_sigC, EMG_sigF);
            
        end
            
        perc_diff(i,j) = mean(rep_vals);
        
        i = i + 1;
        
    end
    
    i = 1;
    j = j + 1;
end

% Generate a surface plot of the values:

figure('Name', 'Relative Signal to Noise (SNR) Magnitude Analysis');
surf(perc_diff);
set(gca,'XTickLabel',(0 : 1 : 5));
set(gca,'YTickLabel',(2 : 2 : 10));
colorbar;

xlabel ('Time (in seconds)');
ylabel ('Relative Magnitude (SNR)');
zlabel ('Percent Difference (Out of 100%)');
title  ('Percent Difference across Notch Filter with Startup Transient, Varying SNR');

[C,I]       = min(perc_diff(:));

% Find the smallest percent different between the original
% signal and the filtered signal, and find the corresponding
% time value and filter order.

R = mod(I,17);

if (R == 0)
    R = 17;
end
    
C = ceil(I/17);

minVal_ts   = C * t_g;
minVal_r    = 1.5 + R * r_g;
minVal      = perc_diff(R,C);

avgDiff     = mean(perc_diff(:));
