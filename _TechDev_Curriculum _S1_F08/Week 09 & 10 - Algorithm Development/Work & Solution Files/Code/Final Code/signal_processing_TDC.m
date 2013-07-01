clear all; close all; clc;
%% Part 1 - Speech Signal Filtering

load part1;

p1s1clean = part1(p1s1);
p1s2clean = part1(p1s2);

save part1clean p1s1clean p1s2clean

%% Part 2 - Signal Corruption
load rich

level1 = part2(data,1);
level2 = part2(data,2);
level3 = part2(data,3);
