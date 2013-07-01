%% Cross Ambiguity Function

% Array for t
t = (0:10000);

% Step size for Freq and Tau
df = .5;
dtau = 1;

% Make a big'ol matrix to put our CAF in!
A = zeros(200,100);

% For a bunch of Freqs and a bunch of Taus,
for f = -50:df:49
    for tau = -50:dtau:49                  
        
        % Calculate an S1 and an S2
        s1 = [zeros(1,250) exp(-.01*t(1:750))];
        s2 = [zeros(1,tau+250) exp(-.01*(t(1:750-tau)))];
            
        % Multiply our S1 S2 and the Freq Shift, Integrate
        A((f+50)/df+1,(tau+50)/dtau+1)=sum(s1.*s2.* exp(-j*2*pi*f*t(1:1000)/10000));
    end
end

% Absolute Value and Square the guy!
A = abs(A);
A = A.^2;

% Let's draw a plot! OK? OK!
surf([-50:dtau:(50-dtau)]./10,[-50:df:(50-df)],A);
ylabel('Frequency (Hz)')
xlabel('Tau (ms)')
zlabel('CAF')
title('Cross Ambiguity Function')