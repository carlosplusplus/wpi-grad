function Hd = filterFinal
Fpass1 = 0.1619;          % First Passband Frequency
Fstop1 = 0.1719;          % First Stopband Frequency
Fstop2 = 0.5;             % Second Stopband Frequency
Fpass2 = 0.51;            % Second Passband Frequency
Dpass1 = 0.028774368332;  % First Passband Ripple
Dstop  = 0.001;           % Stopband Attenuation
Dpass2 = 0.028774368332;  % Second Passband Ripple
dens   = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass1 Fstop1 Fstop2 Fpass2], [1 0 1], ...
                          [Dpass1 Dstop Dpass2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);