% Setup: Create Bits and Add Noise
echo on
actual_bits = randint(1024,1);
noiseless_volts = 1-2*actual_bits;      % Convert to bipolar voltages {+1,-1}
noise = 0.1*randn(size(noiseless_volts));
recvd_volts = noiseless_volts + noise;  % Std dev=0.1;
plot(recvd_volts, '.' );

% SNR = ???????
% What would the plot look like if noise had std dev of 1.0?
pause


% Detection (Written in a somewhat contrived fashion--
%       See below for a different implementation

detections = zeros(size(recvd_volts));  % Preallocate to save execution time
echo off;   % Don't show every iteration of loop
for(isamp=1:length(recvd_volts))
    if( recvd_volts(isamp) > 0 )
        detections(isamp) = 0;
    elseif( recvd_volts(isamp) < 0 )
        detections(isamp) = 1;
    else            % recvd_volts exactly equals 0.0
        detections(isamp) = 0;
    end;
end;

% Calculate performance:
echo on;
bit_error_rate = sum( detections ~= actual_bits ) / length(detections)
pause;


% A better way to implement detections:
detections2 = sign(recvd_volts);    % Outputs {+1,-1}
detections2 = -0.5*detections2 + 0.5;  % convert to bits: {0,1}

% A slightly different BER calculation:
bit_error2 = mean(detections2 ~= actual_bits)



