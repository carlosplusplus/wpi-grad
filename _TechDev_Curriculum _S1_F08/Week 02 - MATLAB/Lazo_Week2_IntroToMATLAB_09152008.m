%% Carlos Lazo
%  ELDP Class of 2011
%  Introduction to MATLAB Assignment
%  Due: 9/15/08 @ 8:30am

%% Problem #6

% Define sample and signal frequencies.

F_sample = 20;
F_sin = .5;

% Define the phase based on problem requirements.

phase = (68*pi)/180;

% Initialize time vector based on sampling frequency.

t = [-1:1/F_sample:9];

% Define sinusoidal equation and plot over -1 to 9 seconds.

y = sin(2*pi*F_sin*t - phase);

plot(t,y,'b');

title('Sine Wave from -1s to 9s');      % Define title of the plot.
xlabel('Time (sec)');                   % Define x-axis of the plot.
ylabel('Amplitude');                    % Define y-axis of the plot.


%% Problem #7

% Define fibonacci number manually in variable 'n':

n = 3;

% Call fibonacci function which recursively finds the appropriate fibonacci
% number.  This assumes that n > 2.

f_3 = fibonacci(n)

% A few more tests:

n = 4;
f_4 = fibonacci(n)

n = 5;
f_5 = fibonacci(n)

n = 10;
f_10 = fibonacci(n)

n = 20;
f_20 = fibonacci(n)


%% Problem #11

% Define x to be the variable sent to the function to define a vector of
% alternating ones and zeros.

x = 3;

% Send input to function, creating vector of alternating ones and zeros.

v_3 = alternate(x)

% A few more tests:

x = 1;
v_1 = alternate(x)

x = 2;
v_2 = alternate(x)

x = 5;
v_5 = alternate(x)

x = 10;
v_10 = alternate(x)

%% Problem #13

% Define a square matrix of size nxn of random numbers between 0-10.

n = 5;

A = rand(n)*10

% Set matrix B = matrix A.

B = A;

% Create an identity matrix of size n.

I = eye(n)

% Find all indices in I where there is a 1.
    % In essence, this returns all indices along the main diagonal.

one_indices = find(I == 1)

% Replace all indices on main diagonal of B with 1's.

B(one_indices) = 1;

% Print out B.

B