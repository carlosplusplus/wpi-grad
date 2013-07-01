% test_amphase_mmul
%
% USAGE:  test_amphase_mmul( nrows_a, ncols_a, ncols_b, num_rep )

function test_amphase_mmul( nrows_a, ncols_a, ncols_b, num_rep )

a = randn( nrows_a, ncols_a );		% Log-normal distn
b = 2*pi*rand( ncols_a, ncols_b );	% Uniform distn

tic
for(irep=1:num_rep)
   c=amphase_mmul1( a, b );
end;
t1 = toc;

a = randn( nrows_a, ncols_a );		% Log-normal distn
b = 2*pi*rand( ncols_a, ncols_b );	% Uniform distn

tic
for(irep=1:num_rep)
   c=amphase_mmul2( a, b );
end;
t2 = toc;

a = randn( nrows_a, ncols_a );		% Log-normal distn
b = 2*pi*rand( ncols_a, ncols_b );	% Uniform distn

tic
for(irep=1:num_rep)
   c=amphase_mmul3( a, b );
end;
t3 = toc;

a = randn( nrows_a, ncols_a );		% Log-normal distn
b = 2*pi*rand( ncols_a, ncols_b );	% Uniform distn

tic
for(irep=1:num_rep)
   c=amphase_mmul4( a, b );
end;
t4 = toc;

disp( ['Time to run amphase_mmul1 = ', num2str(t1/num_rep)] )
disp( ['Time to run amphase_mmul2 = ', num2str(t2/num_rep)] )
disp( ['Time to run amphase_mmul3 = ', num2str(t3/num_rep)] )
disp( ['Time to run amphase_mmul4 = ', num2str(t4/num_rep)] )
