clear all;
% Part 1
load shirt
p1s1input = data;
load rich
p1s2input = data;
load part1
% p1s1
% m(1) = verify(p1s1input,presGen(1,1));
% m(2) = verify(p1s1-(p1s1-p1s1input),presGen(1,2));
% % p1s2
% m(3) = verify(p1s2input,presGen(1,3));
% m(4) = verify(p1s2-(p1s2-p1s2input),presGen(1,4));

% Part 2
% eldp(data,1)
m(5) = verify(presGen(3,1,0),presGen(3,2,0));
% eldp(data,2)
m(6) = verify(presGen(3,1,0),presGen(3,3,0));
% eldp(data,3)
m(7) = verify(presGen(3,1,0),presGen(3,4,0));
% part2(data,1)
m(8) = verify(presGen(3,1,0)',presGen(3,5,0));
% part2(data,2)
m(9) = verify(presGen(3,1,0)',presGen(3,6,0));
% part2(set3,3) bits
m(10) = verify(presGen(2,2,0),presGen(4,bits,0));

m(11) = verify(presGen(2,2,0),presGen(4,bits,0));

m = m';
