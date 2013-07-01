% Carlos Lazo
% ECE 503
% Homework #9
% Due: 3/29/10

function b = HW09_lpfir(M, cutoff)

    N = 100;
    
    % Find the index at which the cutoff should occur.
    
    ind_cut = ((cutoff) / pi) * N;
    
    % Set all values up to that cutoff = 1 to mimic the lowpass filter.
    
    H = zeros(1, N);
    
    H(1:ind_cut) = 1;
    
    % Add in linear phase.
    
    H(1:ind_cut) = H(1:ind_cut) .* ((-1) * ((M-1)/2) * ((2*pi*(1:(N/2))) / N));
    
    H(ind_cut + 1 : N) = H(ind_cut + 1 : N) .* (((M-1)/2) * (2*pi/N) * (N - (ind_cut + 1 : N)));
    
    % Take the IDFT of the sequence created.
    
    h_n       = ifft(H,N);
    
    % Truncate the given sequence.
    
    h_n_trunc = h_n(1:M);
    
    m = (1:M);
    
    % Generate the Blackman Window of length M.
    
    b_win = 0.42 - 0.5*cos((2*pi*m)/(M-1)) + 0.08*cos((4*pi*m)/(M-1));
    
    % Multiply the truncated IDFT by the Blackman Window function
    % to get the desired filter coefficients.
    
    b = h_n_trunc .* b_win;