% BAE Systems ELDP Program
% TDC 1 - Controls
% Cross coupling quantity calculations
% Coded by Christopher C. Rappa
% 12/19/2008
function [cc,w] = crossCoupling(t,y,ts,threshold)
    % This function calculates cross coupling and missile angluar frequency 
    % with the system's step response
    % t - Input time vector
    % y - System step response
    % ts - Input settle time
    % threshold - Influence threshold for cross coupling
    
    tScaled = t(t<ts);      % Only examine output before settle time
    w = atan(threshold)/ts; % Calculate missle rotation frequency
    cc = sum(tan(w*tScaled)*abs(1-y(1:length(tScaled)))); %Calculate cross coupling
end %CCR