% Carlos Lazo
% ECE 503
% Homework #5
% Due: 2/22/10

function [X_k] = HW05_dft_idft (x_n, N, S)

syms k;

% With the function being passed N, develop function from n = 0..N

n = 0:(N-1);

% If selection input S = 0, perform the DFT.
% Else, perform the IDFT.

if (S == 0)

    % Develop the expression for the DFT:
    
    X_k = sum( x_n .* exp((-j*2*pi*k*n)/N) );
    
    % Substitute k for k = 0..N-1, which is the n vector:
    
    X_k = subs(X_k, 'k', n);

else
    
    % Develop the expression for the IDFT:
    
    X_k = (1/N) * sum( x_n .* exp((j*2*pi*k*n)/N) );
    
    % Substitute k for k = 0..N-1, which is the n vector:
    
    X_k = subs(X_k, 'k', n);
    
end
    
    