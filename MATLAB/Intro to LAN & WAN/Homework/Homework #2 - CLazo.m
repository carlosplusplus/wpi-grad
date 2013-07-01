% Carlos Lazo
% ECE 506 – Introduction to LAN/WAN
% Homework #2, Problem 5
% Due Date: June 9th, 2009

clear all; close all; clc;

% The pdf of an exponentially distributed function looks like:

% f(x,lambda) = lambda * e ^ (-lambda * x), x >= 0
%             = 0                         , otherwise.

% In order to find the mean, we know that:
%   mean = E[X] = int(-INF,+INF) [x * f(x,lamdbda) * dx]

syms lambda x;

eqnMean = x * lambda * exp(-lambda * x);

mean = int(eqnMean,x,0,Inf);

simple(mean);

