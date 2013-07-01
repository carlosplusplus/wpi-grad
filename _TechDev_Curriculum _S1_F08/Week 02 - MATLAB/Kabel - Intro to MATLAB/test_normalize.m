% test_normalize
%
% USAGE:  test_normalize( nrows, ncols, num_rep )

function test_normalize( nrows, ncols, num_rep )

a = randn( nrows, ncols );

tic
for(irep=1:num_rep)
   c=normalize1( a );
end;
t1 = toc;

a = randn( nrows, ncols );

tic
for(irep=1:num_rep)
   c=normalize2( a );
end;
t2 = toc;

a = randn( nrows, ncols );

tic
for(irep=1:num_rep)
   c=normalize3( a );
end;
t3 = toc;

a = randn( nrows, ncols );

tic
for(irep=1:num_rep)
   c=normalize_tricky( a );
end;
tt = toc;
disp( ['Time to run normalize1 = ', num2str(t1/num_rep)] )
disp( ['Time to run normalize2 = ', num2str(t2/num_rep)] )
disp( ['Time to run normalize3 = ', num2str(t3/num_rep)] )
disp( ['Time to run normalize_tricky = ', num2str(tt/num_rep)] )

