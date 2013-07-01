echo on
t=[0:0.01:1];   f=1.5;
y=sin(2*pi*f*t);           % 1.5 Hz Sine wave
pause;
plot(y);
pause;
plot(t,y);
pause
plot( fft(y) );
pause
plot( abs(fft(y)) );
pause

% How about a reasonable frequency axis?
freq = [0:length(y)-1] * 100 / length(y);     % Why is 100 the max frequency?
plot( freq, abs(fft(y)) );
pause;

% We usually like to see values ni dB:
plot( freq, 20*log10(abs(fft(y))) )
title( 'Power Spectrum');
xlabel( 'freq (Hz)' );      ylabel( 'Power (dB)' );
echo off
