% Carlos Lazo
% ECE 503
% Homework #5
% Due: 2/22/10

%% 1) The DFT and IDFT

clear all; close all; clc;

% b. P&M 7.6

N = 64;
n = 0 : N-1;
k = n;

% Given the equation for w_n, find the DFT W_n:

w_n = 0.42 - (0.5) * cos ((2*pi*n) / (N-1)) + (0.08) * cos ((4*pi*n) / (N-1));

X_k = HW05_dft_idft (w_n, N, 0);

% Plot the magnitude and phase response of the system from k = 0..N-1.

figure

subplot(2,1,1);
stem(k, abs(X_k));
xlabel({'k'; ' '; ['Y(k) = ' num2str(abs(X_k))]; });
ylabel('Magnitude');
title('|X(k)|');

subplot(2,1,2);
stem(k, angle(X_k)*180/pi);
xlabel({'k'; ' '; ['Y(k) = ' num2str(angle(X_k)*180/pi)]; });
ylabel('Phase in Degrees');
title('Phase of X(k)');

%% 1) The DFT and IDFT

clear all; close all; clc;

% c. P&M 7.12: b) & c)

N = 6;
n = 0 : N-1;
k = n;

% Given the equation for wx_n, find the DFT X_n:

x_n = [0 1 2 3 4 0]

X_k = HW05_dft_idft (x_n, N, 0);

% Setup the DFTs according to the problem description:

Y_k = real(X_k);
V_k = imag(X_k);

% Take the IDFTs and print the sequences:

y_n = HW05_dft_idft (Y_k, N, 1)
v_n = HW05_dft_idft (V_k, N, 1)

% Plot the magnitude and phase response of the system from k = 0..N-1.

% Part b)

format short;

figure

stem(n, y_n);
xlabel({'n'; ' '; ['y(n) = ' num2str(y_n)]; });
ylabel('y(n)');
title('Plot of y(n) vs. n');

% Part c)

figure

subplot(2,1,1);

stem(n, real(v_n));
xlabel({'n'; ' '; ['Re[v(n)] = ' num2str(real(v_n))]; });
ylabel('Re[v(n)]');
title('Plot of Re[v(n)] vs. n');

subplot(2,1,2);

stem(k, imag(v_n));
xlabel({'n'; ' '; ['Im[v(n)] = ' num2str(imag(v_n))]; });
ylabel('Im[v(n)]');
title('Plot of Im[v(n)] vs. n');

%% 1) The DFT and IDFT

clear all; close all; clc;

% d. P&M 7.22

N = 10;
n = 0 : N-1;
k = n;

% Given the equation for x_n, find the DFT X_n:

x_n = cos ((2*pi*n) / 10);

X_k = HW05_dft_idft (x_n, N, 0);

% Plot the magnitude and phase response of the system from k = 0..N-1.

figure

subplot(2,1,1);
stem(k, abs(X_k));
xlabel({'k'; ' '; ['Y(k) = ' num2str(abs(X_k))]; });
ylabel('Magnitude');
title('|X(k)|');

subplot(2,1,2);
stem(k, angle(X_k)*180/pi);
xlabel({'k'; ' '; ['Y(k) = ' num2str(angle(X_k)*180/pi)]; });
ylabel('Phase in Degrees');
title('Phase of X(k)');

%% 2) DFT Properties

clear all; close all; clc;

% c. P&M 7.9

N = 4;
n = 0 : N-1;
k = n;

% Given the equation for x_n1 & x_n2, find the DFT X_n1 & X_n2:

x_n1 = [1 2 3 1];
x_n2 = [4 3 2 2];

X_k1 = HW05_dft_idft (x_n1, N, 0)
X_k2 = HW05_dft_idft (x_n2, N, 0)

% In the frequency domain, convolution become multiplication:

X_k3 = X_k1 .* X_k2

% Perform the IDFT and take the real components to find x_n3:

x_n3 = real(HW05_dft_idft (X_k3, N, 1))

% **************
% *** OUTPUT ***
% **************

% X_k1 =
% 
%    7.0000            -2.0000 - 1.0000i   1.0000 + 0.0000i  -2.0000 + 1.0000i
% 
% 
% X_k2 =
% 
%   11.0000             2.0000 - 1.0000i   1.0000 - 0.0000i   2.0000 + 1.0000i
% 
% 
% X_k3 =
% 
%   77.0000            -5.0000 + 0.0000i   1.0000 - 0.0000i  -5.0000          
% 
% 
% x_n3 =
% 
%     17    19    22    19

%% 2) DFT Properties

clear all; close all; clc;

% e. P&M 7.14, Part a.

N = 5;
n = 0 : N-1;
k = n;

% Given the equation for x_n1 & x_n2, find the DFT X_n1 & X_n2:

x_n1 = [0 1 2 3 4];
x_n2 = [0 1 0 0 0];

X_k1 = HW05_dft_idft (x_n1, N, 0)
X_k2 = HW05_dft_idft (x_n2, N, 0)

% In the frequency domain, convolution become multiplication:

Y_k = X_k1 .* X_k2

% Perform the IDFT and take the real components to find x_n3:

y_n = real(HW05_dft_idft (Y_k, N, 1))

% **************
% *** OUTPUT ***
% **************

% X_k1 =
% 
%   10.0000            -2.5000 + 3.4410i  -2.5000 + 0.8123i  -2.5000 - 0.8123i  -2.5000 - 3.4410i
% 
% 
% X_k2 =
% 
%    1.0000             0.3090 - 0.9511i  -0.8090 - 0.5878i  -0.8090 + 0.5878i   0.3090 + 0.9511i
% 
% 
% Y_k =
% 
%   10.0000             2.5000 + 3.4410i   2.5000 + 0.8123i   2.5000 - 0.8123i   2.5000 - 3.4410i
% 
% 
% y_n =
% 
%     4.0000    0.0000    1.0000    2.0000    3.0000

%% 2) DFT Properties

clear all; close all; clc;

% e. P&M 7.14, Part b.

N = 5;
n = 0 : N-1;
k = n;

% Given the equation for x_n1 & x_n2, find the DFT X_n1 & X_n2:

x_n1 = [0 1 2 3 4];
x_n2 = [0 1 0 0 0];
s_n  = [1 0 0 0 0];

X_k1 = HW05_dft_idft (x_n1, N, 0)
X_k2 = HW05_dft_idft (x_n2, N, 0)
S_k  = HW05_dft_idft (s_n , N, 0)

% In the frequency domain, convolution become multiplication:

X_k3 = S_k ./ X_k1

% Perform the IDFT and take the real components to find x_n3:

x_n3 = real(HW05_dft_idft (X_k3, N, 1))

% **************
% *** OUTPUT ***
% **************

% X_k1 =
% 
%   10.0000            -2.5000 + 3.4410i  -2.5000 + 0.8123i  -2.5000 - 0.8123i  -2.5000 - 3.4410i
% 
% 
% X_k2 =
% 
%    1.0000             0.3090 - 0.9511i  -0.8090 - 0.5878i  -0.8090 + 0.5878i   0.3090 + 0.9511i
% 
% 
% S_k =
% 
%      1
% 
% 
% X_k3 =
% 
%    0.1000            -0.1382 - 0.1902i  -0.3618 - 0.1176i  -0.3618 + 0.1176i  -0.1382 + 0.1902i
% 
% 
% x_n3 =
% 
%    -0.1800    0.2200    0.0200    0.0200    0.0200

%% 3) More DFT Stuff with MATLAB

clear all; close all; clc;

% a. X(ejw) = (1-a2) / (1 - 2 a cos(w) + a2). 

syms k;

% Define all variables based on what we're looking for:

N1 = 5;
N2 = 40;
N3 = 1000;

n1 = 0:N1-1;
n2 = 0:N2-1;
n3 = 0:N3-1;

k1 = n1;
k2 = n2;
k3 = n3;

w1 = (2*pi*k)./N1;
w2 = (2*pi*k)./N2;
w3 = (2*pi*k)./N3;

a = 0.8;

% Define the DFT equations:

X_K1 = (1 - a^2) ./ (1 - 2*a*cos(w1) + a^2);
X_K2 = (1 - a^2) ./ (1 - 2*a*cos(w2) + a^2);
X_K3 = (1 - a^2) ./ (1 - 2*a*cos(w3) + a^2);

x_n1 = HW05_dft_idft (X_K1, N1, 1);
x_n2 = HW05_dft_idft (X_K2, N2, 1);
x_n3 = HW05_dft_idft (X_K3, N3, 1);

% Plot all figures:

X_K1 = subs(X_K1, 'k', k1);

figure;

stem(n1, x_n1);
xlabel('n');
ylabel('x(n)');
title('x(n), N = 5');

figure;

stem(n2, x_n2);
xlabel('n');
ylabel('x(n)');
title('x(n), N = 40');

figure;

stem(n3, x_n3);
xlabel('n');
ylabel('x(n)');
title('x(n), N = 1000');

%% More DFT Stuff with MATLAB

clear all; close all; clc;

% b. P&M 7.30, part a)

% Define all variables and their equations:

f1 = (1/18);
f2 = (5/128);
fc = (50/128);

n = 0:255;

x_n = cos(2*pi*f1*n) + cos(2*pi*f2*n);
x_c = cos(2*pi*fc*n);
x_am = x_n .* x_c;

subplot(3,1,1);
stem(n,x_n);
xlabel('n');
ylabel('x(n)');

subplot(3,1,2);
stem(n,x_c);
xlabel('n');
ylabel('xc(n)');

subplot(3,1,3);
stem(n,x_am);
xlabel('xam(n)');
ylabel('n');

%% More DFT Stuff with MATLAB

clear all; close all; clc;

% b. P&M 7.30, part b)

% Define all variables and their equations:

f1 = (1/18);
f2 = (5/128);
fc = (50/128);

n = 0:127;

x_n = cos(2*pi*f1*n) + cos(2*pi*f2*n);
x_c = cos(2*pi*fc*n);
x_am = x_n .* x_c;

N = 128;

X_k = HW05_dft_idft (x_am, N, 0);

figure

subplot(2,1,1);
stem(n, abs(X_k));
xlabel('k');
ylabel('Magnitude');
title('|X(k)|');

subplot(2,1,2);
stem(n, angle(X_k)*180/pi);
xlabel('k');
ylabel('Phase in Degrees');
title('Phase of X(k)');

%% More DFT Stuff with MATLAB

clear all; close all; clc;

% b. P&M 7.30, part c)

% Define all variables and their equations:

f1 = (1/18);
f2 = (5/128);
fc = (50/128);

n = 0:99;

x_n = cos(2*pi*f1*n) + cos(2*pi*f2*n);
x_c = cos(2*pi*fc*n);
x_am = x_n .* x_c;

x_am = [x_am zeros(1,28)]

N = 128;

X_k = HW05_dft_idft (x_am, N, 0);

figure

subplot(2,1,1);
stem(N, abs(X_k));
xlabel('k');
ylabel('Magnitude');
title('|X(k)|');

subplot(2,1,2);
stem(N, angle(X_k)*180/pi);
xlabel('k');
ylabel('Phase in Degrees');
title('Phase of X(k)');

%% More DFT Stuff with MATLAB

clear all; close all; clc;

% b. P&M 7.30, part d)

% Define all variables and their equations:

f1 = (1/18);
f2 = (5/128);
fc = (50/128);

n = 0:179;

x_n = cos(2*pi*f1*n) + cos(2*pi*f2*n);
x_c = cos(2*pi*fc*n);
x_am = x_n .* x_c;
x_am = [x_am zeros(1,(256-180))]


N = 256;

X_k = HW05_dft_idft (x_am, N, 0);

figure

subplot(2,1,1);
stem(N, abs(X_k));
xlabel('k');
ylabel('Magnitude');
title('|X(k)|');

subplot(2,1,2);
stem(N, angle(X_k)*180/pi);
xlabel('k');
ylabel('Phase in Degrees');
title('Phase of X(k)');