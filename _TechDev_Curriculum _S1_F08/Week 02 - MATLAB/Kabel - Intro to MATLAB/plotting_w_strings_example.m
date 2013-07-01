echo on;
t = [0:0.01:1];		% plotting_w_strings_example.m
for( freq=1:0.5:3 )
   y = sin( 2*pi*freq*t );	% Sine wave w/ frequency freq
   plot(t,y);
   title( ['Sine wave with freq ', num2str(freq), ' Hz'] )
   xlabel( 'time (sec)' ); ylabel( 'Ampl.' );
   print( ['graph', int2str(round(freq*10))] );	% Save plot
   disp( 'Hit space bar to continue' )
   pause;
end;

dir *.ps		% Take a look at what was created
echo off
