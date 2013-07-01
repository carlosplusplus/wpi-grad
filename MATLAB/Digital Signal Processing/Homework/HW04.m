% Carlos Lazo
% ECE 503
% Homework 4


%% 1) Fourier Series

clear all; close all; clc;

% a. P&M 4.6 a) --- Find Fourier Series coefficients -

syms k;

% Since function has N = 6, develop function from n = 0..5

N = 6;
n = 0:(N-1);

% Develop the generic expression for each Fourier Series coefficient:

c_k = (4/N) * sum( sin((2*pi*(n-2))/N) .* exp((-2*j*pi*k*n)/N) );

% Substitute into the generic expression to figure out c_k values:

c_0 = subs(c_k, 'k', 0);
c_1 = subs(c_k, 'k', 1);
c_2 = subs(c_k, 'k', 2);
c_3 = subs(c_k, 'k', 3);
c_4 = subs(c_k, 'k', 4);
c_5 = subs(c_k, 'k', 5);

fprintf(['Coefficient for c_0 is:\n\t' num2str(c_0) '\n\n']);
fprintf(['Coefficient for c_1 is:\n\t' num2str(c_1) '\n\n']);
fprintf(['Coefficient for c_2 is:\n\t' num2str(c_2) '\n\n']);
fprintf(['Coefficient for c_3 is:\n\t' num2str(c_3) '\n\n']);
fprintf(['Coefficient for c_4 is:\n\t' num2str(c_4) '\n\n']);
fprintf(['Coefficient for c_5 is:\n\t' num2str(c_5) '\n\n']);

% **************
% *** OUTPUT ***
% **************
% 
% Coefficient for c_0 is:
% 	8.1643e-17
% 
% Coefficient for c_1 is:
% 	-1.7321+1i
% 
% Coefficient for c_2 is:
% 	2.9225e-16-4.0317e-17i
% 
% Coefficient for c_3 is:
% 	-8.1643e-17+1.4141e-16i
% 
% Coefficient for c_4 is:
% 	-6.5144e-16-2.3724e-16i
% 
% Coefficient for c_5 is:
% 	-1.7321-1i

%% 1) Fourier Series

clear all; close all; clc;

% a. P&M 4.6 b) --- Find Fourier Series coefficients -

syms k;

% Since function has N = 15, develop function from n = 0..14
% c_k1 has N = 3 and c_k2 has N = 5

N = 15;
n = 0:(N-1);

N1 = 3;
N2 = 5;

% Develop the generic expression for each Fourier Series coefficient:

c_k1 = (1/N) * sum( cos((2*pi*n)/N1) .* exp((-2*j*pi*k*n)/N) );
c_k2 = (1/N) * sum( sin((2*pi*n)/N2) .* exp((-2*j*pi*k*n)/N) );

% Form the c_k vector by doing the variable substitution and addition
% of both c_k expressions.  Save into a vector from n = 0..N-1

for ii = 0:(N-1)
    c_k(ii+1) = subs(c_k1, 'k', ii) + subs(c_k2, 'k', ii);
end

for ii = 0:(N-1)
    fprintf(['Coefficient for c_' num2str(ii) ' is:\n']);
    fprintf(['\t' num2str(c_k(ii+1)) '\n\n']);
end


% **************
% *** OUTPUT ***
% **************
% 
% Coefficient for c_0 is:
% 	-3.2613e-16
% 
% Coefficient for c_1 is:
% 	0-1.8215e-16i
% 
% Coefficient for c_2 is:
% 	-1.5613e-16-1.3878e-17i
% 
% Coefficient for c_3 is:
% 	1.1102e-16-0.5i
% 
% Coefficient for c_4 is:
% 	-2.3766e-16-2.7062e-16i
% 
% Coefficient for c_5 is:
% 	0.5-2.7409e-16i
% 
% Coefficient for c_6 is:
% 	1.8041e-16+6.9389e-18i
% 
% Coefficient for c_7 is:
% 	3.1225e-16-2.9751e-16i
% 
% Coefficient for c_8 is:
% 	-2.6368e-16+2.1944e-16i
% 
% Coefficient for c_9 is:
% 	-2.3245e-16-7.2858e-17i
% 
% Coefficient for c_10 is:
% 	0.5+5.2736e-16i
% 
% Coefficient for c_11 is:
% 	7.7629e-16-3.8858e-16i
% 
% Coefficient for c_12 is:
% 	-1.2178e-15+0.5i
% 
% Coefficient for c_13 is:
% 	4.7184e-16-3.4001e-16i
% 
% Coefficient for c_14 is:
% 	8.3961e-16+1.4364e-15i

%% 3) Frequency Response and System Functions

clear all; close all; clc;

% a. Problem 5.4, part j)

[H1,w1] = freqz([.25 .25 .25 .25], 1);

% Plot the magnitude and phase response of the system from 0 to pi.

figure

subplot(2,1,1);
plot(w1, abs(H1));
xlabel('Frequency in Radians (0 to \pi)');  ylabel('Magnitude');
title('|H[e\^(jw)]|');

subplot(2,1,2);
plot(w1, angle(H1)*180/pi);
xlabel('Frequency in Radians (0 to \pi)');  ylabel('Phase in Degrees');
title('Phase of H[e\^(jw)]');

% a. Problem 5.4, part k)

[H2,w2] = freqz([(1/8) (3/8) (3/8) (1/8)], 1);

% Plot the magnitude and phase response of the system from 0 to pi.

figure

subplot(2,1,1);
plot(w2, abs(H2));
xlabel('Frequency in Radians (0 to \pi)');  ylabel('Magnitude');
title('|H[e\^(jw)]|');

subplot(2,1,2);
plot(w2, angle(H2)*180/pi);
xlabel('Frequency in Radians (0 to \pi)');  ylabel('Phase in Degrees');
title('Phase of H[e\^(jw)]');