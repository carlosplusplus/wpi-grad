function m02_ted
% EE503, Lecture 2.

close all;
figure
set(gcf, 'Position', [320 30 600 660]);


fprintf('---------- CONVOLUTION ----------\n');
fprintf('\nPaused -----\n'); pause

fprintf('MATLAB has a convolution function [conv()], but it assumes\n');
fprintf('  that each sequence is causal.\n\n');
fprintf('x = [1 2 3 4], h = [1 -1 1]\n');
x = [1 2 3 4]; h = [1 -1 1];
subplot(2,2,1)
stem( 0:length(x)-1, x), ylabel('Sequence'), title('x'), box('off');
subplot(2,2,2)
stem( 0:length(h)-1, h), ylabel('Sequence'), title('h'), box('off');
subplot(2,2,3)
x_h = conv(x, h);
stem( 0:length(x_h)-1, x_h), ylabel('Sequence'), title('conv(x, h)')
xlabel('k'); box('off');
subplot(2,2,4)
h_x = conv(h, x);
stem( 0:length(h_x)-1, h_x), ylabel('Sequence'), title('conv(h, x)')
xlabel('k'); box('off');
fprintf('\nNote 1: Output sequence length is: length(x) + length(h) - 1.\n');
fprintf('Note 2: Order of convolution does not matter.\n');
fprintf('\nPaused -----\n'); pause, clear all

fprintf('For sequences that don''t start at the first index, we can\n');
fprintf('  keep track of the signal origin.\n');
fprintf('Let Tx, Th denote the element number of the "time = 0" sample,\n');
fprintf('  where Tx = 1 denotes the first element (MATLAB indexing).\n');
fprintf('With this definition, the convolved sequence has its\n');
fprintf('  signal origin at "Tx + Th - 1".\n\n');
fprintf('x = [1 2 3 4], h = [1 -1 1]\n');
x = [1 2 3 4]; h = [1 -1 1];
subplot(2,2,1)
stem( 0:length(x)-1, x), ylabel('Sequence'), title('x, Tx=1'), box('off');
subplot(2,2,2)
stem( 0:length(h)-1, h), ylabel('Sequence'), title('h, Th=1'), box('off');
subplot(2,2,3)
Tx = 1; Th = 2; x_h = conv(x, h);
k = 0:length(x_h)-1;  k = k - (Tx + Th - 2);
stem(k, x_h), ylabel('Sequence')
title('conv(x, h), Tx=1, Th=2')
xlabel('k'); box('off');
subplot(2,2,4)
Tx = 3; Th = 2; x_h = conv(x, h);
k = 0:length(x_h)-1;  k = k - (Tx + Th - 2);
stem(k, x_h), ylabel('Sequence')
title('conv(x, h), Tx=3, Th=2')
xlabel('k'); box('off');
fprintf('\nPaused -----\n'); pause, clear all

fprintf('Padding vectors with zeros should not change the result,\n');
fprintf('  but can make the stem plots look nicer.\n\n');
fprintf('x = [0 0 1 2 3 4 0 0], Tx = 3, h = [0 0 1 -1 1 0 0], Th = 3\n');
x = [0 0 1 2 3 4 0 0]; h = [0 0 1 -1 1 0 0];
Tx = 3; Th = 3; x_h = conv(x, h);
k = 0:length(x_h)-1;  k = k - (Tx + Th - 2);
clf, stem(k, x_h), ylabel('Sequence')
title('conv(x, h), Tx=3, Th=3')
xlabel('k'); box('off');
fprintf('\nPaused -----\n'); pause, clear all

fprintf('Now, let''s show that the order of linear systems\n');
fprintf('  does not matter:\n\n');
fprintf('x = [2 4 6 8], h1 = [-1 1], h2 = [3 6 -9]\n');
x = [2 4 3 5]; h1 = [-1 1]; h2 = [3 6 -2];
subplot(2,1,1)
y1 = conv( conv(x, h1), h2);
stem( 0:length(y1)-1, y1), ylabel('Sequence')
title('y1 = conv( conv(x, h1), h2)'); xlabel('k'); box('off');
subplot(2,1,2)
y2 = conv( conv(x, h2), h1);
stem( 0:length(y2)-1, y2), ylabel('Sequence')
title('y2 = conv( conv(x, h2), h1)'); xlabel('k'); box('off');
fprintf('\nPaused -----\n'); pause, clear all

fprintf('Here is a 3-point moving average filter, applied to a\n');
fprintf('  unit step.\n\n');
fprintf('x = ones(1,10), h = [1 1 1]/3\n');
x = ones(1,10); h = [1 1 1]/3;
y = conv(x, h);
clf; stem( 0:length(y)-1, y), ylabel('Sequence'), title('y = conv(x, h)')
xlabel('k'); box('off');
fprintf('\nNote: The first and last two outputs are not "averages" of\n');
fprintf('      the last three samples!!\n');
fprintf('\nPaused -----\n'); pause, clear all


fprintf('---------- EMPERICAL DETERMINATION OF IMPULSE RESPONSE ----------\n');
fprintf('\nPaused -----\n'); pause, clear all

fprintf('One way to emperically determine the impulse response of a\n');
fprintf('  system is to excite the system with a unit impulse.\n\n');
fprintf('Let''s derive the beginning of the impulse response for\n');
fprintf('  the (assumed causal) system:\n');
fprintf('  y(k) = y(k-1) - 0.9*y(k-2) + x(k).\n\n');
fprintf('We let x(k)=impulse, y(k<0)=0, and the output ==> h(k).\n\n');
fprintf('  For h(0): h(0) = h(-1) - 0.9*h(-2) + x(0) = 0-0+1 = 1\n');
fprintf('  For h(1): h(1) = h(0)  - 0.9*h(-1) + x(1) = 1-0+0 = 1\n');
fprintf('  Thereafter, h(k) = h(k-1) - 0.9*h(k-2), since x(k>0)=0\n\n');
fprintf('If we compute this numerically and plot a section, we get:\n');
h(1) = 1; h(2) = 1;  % MATLAB index 1 equals sequence index 0.
for i = 2:70
  h(i+1) = h(i) - 0.9*h(i-1);  % Shift indexes to MATLAB indexing.
end
clf; stem( 0:length(h)-1, h), ylabel('Sequence'), title('h')
xlabel('k'); box('off');
fprintf('\nPaused -----\n'); pause, clear all


fprintf('---------- EMPERICAL DETERMINATION OF STEP RESPONSE ----------\n');
fprintf('\nPaused -----\n'); pause, clear all

fprintf('One way to emperically determine the STEP response of a\n');
fprintf('  system is to excite the system with a STEP.\n\n');
fprintf('Let''s derive the beginning of the step response for\n');
fprintf('  the (assumed causal) system:\n');
fprintf('  y(k) = y(k-1) - 0.9*y(k-2) + x(k).\n\n');
fprintf('We let x(k)=Step, y(k<0)=0, and the output ==> s(k).\n\n');
fprintf('  For s(0): s(0) = s(-1) - 0.9*s(-2) + x(0) = 0-0+1 = 1\n');
fprintf('  For s(1): s(1) = s(0)  - 0.9*s(-1) + s(1) = 1-0+1 = 2\n');
fprintf('  Thereafter, s(k) = s(k-1) - 0.9*s(k-2) + 1, since x(k>=0)=1\n\n');
fprintf('If we compute this numerically and plot a section, we get:\n');
s(1) = 1; s(2) = 2;  % MATLAB index 1 equals sequence index 0.
for i = 2:100
  s(i+1) = s(i) - 0.9*s(i-1) + 1;  % Shift indexes to MATLAB indexing.
end
clf; stem( 0:length(s)-1, s), ylabel('Sequence'), title('h')
xlabel('k'); box('off');


return
