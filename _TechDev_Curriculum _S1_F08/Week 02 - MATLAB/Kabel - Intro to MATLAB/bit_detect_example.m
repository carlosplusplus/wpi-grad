%% Setup: Create Bits and Add Noise (bit_detect_example.m)
echo on

% Create bits
actual_bits = randint(1024,1);

% Convert to bipolar voltages {+1, -1}
noiseless_volts = 1-2*actual_bits;

% Generate and add noisse
noise = 0.1*randn(size(noiseless_volts));
recvd_volts = noiseless_volts + noise;  % Std dev=0.1;
plot(recvd_volts, '.' );

%% Detection
detections = sign(recvd_volts);    % Outputs {+1,-1}
hold on; plot( detections, 'ro' ); hold off;

% Convert to bits
detections = -0.5*detections + 0.5;  % convert to bits: {0,1}

%% Calculate performance:
bit_error_rate = sum( detections ~= actual_bits ) / length(detections)

%% A slightly different BER calculation:
bit_error2 = mean(detections ~= actual_bits)
