% Carlos Lazo
% ECE 503
% Homework #9
% Due: 3/29/10

%% 2) MATLAB Programming and Filter Comparison

clear all; close all; clc;

% a. LPFIR Design

M       = 20;
cutoff  = pi/2;

b = HW09_lpfir(M,cutoff);

[H, w] = freqz(b, 1, 1024);

figure;
subplot(2,1,1);

plot(w,abs(H));
xlabel('Frequency in radians');
ylabel('Magnitude');
title('Lowpass Filter');
grid on;

subplot(2,1,2);

plot(w,angle(H));
xlabel('Frequency in radians');
ylabel('Phase');
title('Lowpass Filter');
grid on;

%% 2) MATLAB Programming and Filter Comparison

clear all; close all; clc;

% b. FIRPM Function Development

N1 =  5;
N2 =  7;
N3 =  9;
N4 = 11;

b1 = firpm(N1-1, [0 .5 .75 1], [0 0 1 1]);
b2 = firpm(N2-1, [0 .5 .75 1], [0 0 1 1]);
b3 = firpm(N3-1, [0 .5 .75 1], [0 0 1 1]);
b4 = firpm(N4-1, [0 .5 .75 1], [0 0 1 1]);

[H1, w1] = freqz(b1, 1, 1024);
[H2, w2] = freqz(b2, 1, 1024);
[H3, w3] = freqz(b3, 1, 1024);
[H4, w4] = freqz(b4, 1, 1024);

figure;
subplot(2,2,1);

plot(w1,abs(H1));
xlabel('Frequency in radians');
ylabel('Magnitude');
title('Highpass Filter #1');
grid on;

subplot(2,2,2);

plot(w2,abs(H2));
xlabel('Frequency in radians');
ylabel('Magnitude');
title('Highpass Filter #2');
grid on;

subplot(2,2,3);

plot(w3,abs(H3));
xlabel('Frequency in radians');
ylabel('Magnitude');
title('Highpass Filter #3');
grid on;

subplot(2,2,4);

plot(w4,abs(H4));
xlabel('Frequency in radians');
ylabel('Magnitude');
title('Highpass Filter #4');
grid on;