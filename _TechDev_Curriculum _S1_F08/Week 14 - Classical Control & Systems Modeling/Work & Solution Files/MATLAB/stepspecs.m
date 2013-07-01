function [os,ts,tr]=stepspecs(t,y,yss,sp)
%STEPSPECS System Step Response Specifications.
% [OS,Ts,Tr]=STEPSPECS(T,Y,Yss,Sp) returns the percent overshoot OS,
% settling time Ts, and rise time Tr from the step response data contained
% in T and Y.
% Y is a vector containing the system response at the associated time
% points in the vector T. Yss is the steady state or final value of the
% response.
% If Yss is not given, Yss=Y(end) is assumed. Sp is the settling time
% percentage.
% If Sp is not given, Sp = 2% is assumed. The settling time is the time it
% takes the response to converge within +-Sp percent of Yss.
% The rise time is assumed to be the time for the response to initially
% travel from 10% to 90% of the final value Yss.

% D.C. Hanselman, University of Maine, Orono, ME 04469
% Mastering MATLAB 7
% 2005-03-20

%--------------------------------------------------------------------------
if nargin<2
   error('At Least Two Input Arguments are Required.')
end
if numel(t)~=length(t) || numel(y)~=length(y)
   error('T and Y Must be Vectors.')
end
if nargin==2
   yss=y(end);
   sp=2;
elseif nargin==3
   sp=2;
end
if isempty(yss)
   yss=y(end);
end
if yss==0
   error('Yss Must be Nonzero.')
end
if yss<0 % handle case where step response may be negative
   y=-y;
   yss=-yss;
end
t=t(:);
y=y(:);
% find rise time using linear interpolation
idx1=find(y>=yss/10,1);
idx2=find(y>=9*yss/10,1);
if isempty(idx1) || idx1==1 || isempty(idx2)
   error('Not Enough Data to Find Rise Time.')
end
alpha=(yss/10-y(idx1-1))/(y(idx1)-y(idx1-1));
t1=t(idx1-1)+alpha*(t(idx1)-t(idx1-1));
alpha=(9*yss/10-y(idx2-1))/(y(idx2)-y(idx2-1));
t2=t(idx2-1)+alpha*(t(idx2)-t(idx2-1));
tr=t2-t1;

% find settling time using linear interpolation
idx1=find(abs(y-yss)>abs(yss*sp/100),1,'last');
if isempty(idx1) || idx1(1)==length(y)
   error('Not Enough Data to Find Settling Time.')
end
if y(idx1)>yss
   alpha=(y(idx1)-(1+sp/100)*yss)/(y(idx1)-y(idx1+1));
   ts=t(idx1)+alpha*(t(idx1+1)-t(idx1));
else
   alpha=((1-sp/100)*yss-y(idx1))/(y(idx1+1)-y(idx1));
   ts=t(idx1)+alpha*(t(idx1+1)-t(idx1));
end
% find percent overshoot based on peak data value
os=max(0,(max(y)-yss)/yss)*100;