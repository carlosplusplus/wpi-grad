function PS_out_of_luck = detection_problem( method )

if( ~exist('method') ), method=1; end;
if( isempty(method) ), method=1; end;

N = 10000000;      % Population size
Pdisease = 0.3/100; % P(disease)
Pfalse_pos = 0.07;   % P(False positive)
Pfalse_neg = 0.07;   % P(False negative)
% Generate flags for all individuals which mark for disease
carrier_flags = randbin( N, 1, Pdisease );

% Handle the detection part--2 ways:

%Detection statistics--Method 1:
if( method==1 )
    detection_flags = ~carrier_flags & randbin( N, 1, Pfalse_pos) ...
                     | carrier_flags & randbin( N, 1, 1-Pfalse_neg);
else
    detection_flags = zeros(N,1);
    % Handle Detected positives
    detection_flags(carrier_flags)  = randbin( sum(carrier_flags), 1, 1-Pfalse_neg );
    % Next, False Positives
    detection_flags(~carrier_flags) = randbin( sum(~carrier_flags), 1, Pfalse_pos );
end;

% Answer the question: P(Disease | tests postive )
PS_out_of_luck = sum( carrier_flags(detection_flags==1) ) ./ sum( detection_flags==1 );
return;


% Function to generate an array in which a certain fraction of the elements
% are true (or 1), and the rest are FALSE (or 0).
function out = randbin( nrows, ncols, fraction_true )
% Two ways:
% First method--Use a specialized Matlab command:
% out = randsrc( nrows, ncols, [1,0; fraction_true, 1-fraction_true] );
% out = logical(out);
% Second method--Make use of uniform random number generator:
out = rand( nrows, ncols );
out = (out <= fraction_true);
return;
