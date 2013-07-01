% Plot_example2.m
% Setup:
echo on;
t = [0:0.01:1];   f=1.5;   phi=pi/3;      % 60 degree phase shift; 1.5 Hz freq
y=sin(2*pi*f*t);           % 1.5 Hz Sine wave
y1 = sin(2*pi*f*t + phi);
pause;

% Method 1:
figure(1);
clf;
plot( t, y, t, y1 );
pause
plot( t, y, 'b',  t, y1, 'r' );
pause;

%Method 2:  If you can't or forget to use method 1
plot( t, y);
hold on;
plot( t, y1, 'r' );      % Why use 'r' here?
Hold off;                % Future plots don't overwrite plots
pause

% Method 3:  If you have mastered the sublime zen that is Matlab
plot( t, [y; y1] );
pause

% Plotting separate plots in a figure:
clf
subplot(2,1,1)
plot(t,y,'r.-');
subplot(2,1,2)
plot(t,y1,'b:' );
echo off;

