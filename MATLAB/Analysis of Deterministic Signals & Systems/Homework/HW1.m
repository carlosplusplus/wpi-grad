% Carlos Lazo
% ECE504 - Analysis of Deterministic Signals & Systems
% Homework #1, Part 1e)

clear all; close all; clc;

% Define all system variables -

g = 9.81;    % Force of gravity on the earth.
L =   .5;    % Assume a length of .5 meters.
M =    5;    % Assume a mass of 5 kg.

% Form numerator and denominator based on TF found in 1d)

num = [0 0 (1/(M*L))];
den = [1 0 (g/L)];

% Create transfer function:

sys = tf(num,den);

% Compute Step response:

figure;
step(sys);

% Compute Frequency response:

figure;
bode(sys);