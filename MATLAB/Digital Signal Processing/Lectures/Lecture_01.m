function m01_ted
% EE503, Lecture 1.

close all;
figure
set(gcf, 'Position', [320 30 600 660]);

% WARNING: Time index ko may not be defined consistently throughout this script.


fprintf('Numerical computation software, like MATLAB, can only\n');
fprintf('  handle finite-duration sequences (that fit in memory!).\n\n');
fprintf('\nPaused -----\n'); pause


fprintf('---------- SEQUENCES ----------\n');
fprintf('\nPaused -----\n'); pause

fprintf('Denote sequences as a MATLAB vector.  Keep track of time zero.\n');
fprintf('x = [2 4 6 3] is a vector.  Let ko = 2.\n');
fprintf('   REMEMBER - The first element is index 1 in MATLAB.\n');
x = [2 4 6 3], ko = 2;
Time = ( 1:length(x) ) - ko;  % Create time axis.
stem(Time, x), xlabel('Index k'); ylabel('Sequence x(k)'); box('off');
fprintf('\nPaused -----\n'); pause

fprintf('One way to form an impulse is to set a vector to zero,\n');
fprintf('  then set the appropriate point to zero.\n');
fprintf('An impulse at element 10 could be formed as:\n');
fprintf('  x = zeros(1, 20); x(10) = 1; ko = 10;\n');
d = zeros(1, 20); d(10) = 1; ko = 10;
fprintf('    NOTE that this sequence is indexed from 1.\n');
Time = ( 1:length(d) ) - ko;  % Create time axis.
stem(Time, d), xlabel('Index k'); ylabel('Sequence d(k)'); box('off');
fprintf('\nPaused -----\n'); pause

fprintf('Sinusoidal sequences use the sin() and cos() functions.\n');
fprintf('  t = 0:0.01:10  %% Time in seconds (NOT a discrete index).\n');
t = 0:0.01:10;  % Time in seconds (NOT a discrete index).
fprintf('  s = 5 * sin(2*pi*2*t)\n');
s = 5 * sin(2*pi*2*t); ko = 1;
fprintf('\nNOTE 1:  Must zoom plot to "see" the sinusoid.\n');
fprintf('NOTE 2: Function is periodic.  Period = 50.\n');
Time = ( 1:length(s) ) - ko;  % Create time axis.
stem(Time, s), xlabel('Index k'); ylabel('Sequence s(k)'); box('off');
fprintf('\nPaused -----\n'); pause

fprintf('Sequences can be complex-valued:\n');
fprintf('  t = 0:0.01:10  %% Time in seconds (NOT a discrete index).\n');
fprintf('  x2 = 5 * exp(j*2*pi*2*t)\n');
t = 0:0.01:10;  % Time in seconds (NOT a discrete index).
x2 = 5 * exp(j*2*pi*2*t); ko = 1;
Time = ( 1:length(s) ) - ko;  % Create time axis.
subplot(2,1,1)
stem(Time, real(x2)), xlabel('Index k (Showing Samples 0-100)');
ylabel('Sequence s(k)'); box('off'); title('Real Part');
axis([0 100 -5 5]); 
subplot(2,1,2)
stem(Time, imag(x2)), xlabel('Index k (Showing Samples 0-100)');
ylabel('Sequence s(k)'); box('off'); title('Imaginary Part');
axis([0 100 -5 5]);
fprintf('\nPaused -----\n'); pause


fprintf('---------- SEQUENCE OPERATIONS ----------\n');
fprintf('\nPaused -----\n'); pause
clear all

fprintf('Vectors must of same dimensions to perform element-wise \n');
fprintf('  addition, subtraction, multiplication and division.\n');
fprintf('  t = 0:0.01:10  %% Time in seconds (NOT a discrete index).\n');
t = 0:0.01:10;  % Time in seconds (NOT a discrete index).
fprintf('  x1 = 5 * sin(2*pi*2*t)\n');
x1 = 5 * sin(2*pi*2*t); ko = 1;
Time = ( 1:length(x1) ) - ko;  % Create time axis.
fprintf('  x2 = 5 * cos(2*pi*2*t)\n');
x2 = 5 * cos(2*pi*2*t); ko = 1;
clf
subplot(3,2,1)
stem(Time, x1)
ylabel('Sequence'); box('off'); title('x1');
axis([0 100 -5 5]); 
subplot(3,2,2)
stem(Time, x2)
ylabel('Sequence'); box('off'); title('x2');
axis([0 100 -5 5]); 
subplot(3,2,3)
stem(Time, x1+x2)
ylabel('Sequence'); box('off'); title('x1 + x2');
axis([0 100 -10 10]); 
subplot(3,2,4)
stem(Time, x1-x2)
ylabel('Sequence'); box('off'); title('x1 - x2');
axis([0 100 -10 10]); 
subplot(3,2,5)
stem(Time, 3*x1), xlabel('Index k (Showing Samples 0-100)');
ylabel('Sequence'); box('off'); title('3 * x1');
axis([0 100 -15 15]); 
subplot(3,2,6)
stem(Time, x1 .* x2), xlabel('Index k (Showing Samples 0-100)');
ylabel('Sequence'); box('off'); title('x1 .* x2');
axis([0 100 -25 25]); 
fprintf('\nPaused -----\n'); pause

fprintf('Time Shifting:  By using "ko", time shifting is accomplished\n');
fprintf('  by changing ko.\n');
fprintf('x = [2 4 6 3] is a vector.  Plot it for a few time shifts.\n');
x = [2 4 6 3]
clf
subplot(3,1,1)
ko = 1;
Time = ( 1:length(x) ) - ko;  % Create time axis.
stem(Time, x), ylabel('Sequence x(k)'); box('off');
title('ko = 1 (First vector element is at time zero.)');
subplot(3,1,2)
ko = 2;
Time = ( 1:length(x) ) - ko;  % Create time axis.
stem(Time, x), ylabel('Sequence x(k)'); box('off');
title('ko = 2 (Second vector element is at time zero.)');
subplot(3,1,3)
ko = 0;
Time = ( 1:length(x) ) - ko;  % Create time axis.
stem(Time, x), xlabel('Index k'); ylabel('Sequence x(k)'); box('off');
title('ko = 0 (Sample BEFORE first vector element is at time zero.)');
fprintf('\nPaused -----\n'); pause


fprintf('---------- ISSUES ----------\n\n');
fprintf('- Most analytic sequences are indexed from zero,\n');
fprintf('  but MATLAB is indexed from one.\n\n');
fprintf('- Must always maintain range of sequence vector(s).\n\n');
clear all


return;
