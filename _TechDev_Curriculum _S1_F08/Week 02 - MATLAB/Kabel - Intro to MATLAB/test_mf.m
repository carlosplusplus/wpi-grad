% test_mf

function test_mf( mfilter )

switch( lower(mfilter) )
    case 'hanning'
        figg=2;
        h = hanning(100);
    case 'rect'
        figg=3;
        h = ones(100,1);
    case 'wgn'
        figg=4;
        h = randn(100,1);
    case 'sine'
        figg=5;
        n=0:99;
        h = 0.5+sin(2*pi*0.02*n).';
    case 'shortrect'
        figg=6;
        h = ones(25,1);
    otherwise
        error( 'Unknown matched filter type' );
end;

% make filter have unit energy
h = h ./ sqrt( sum( abs(h).^2 ));

% Create received signal with 10 dB SNR
r = 0.1 * randn( 1000, 1 );
if( isequal(lower(mfilter), 'shortrect') )
    r(100:124) = r(100:124) + h;
else
    r(100:199) = r(100:199) + h;
end;
figure(1); clf;
subplot(2,1,2);
plot(r);
ax=axis;
subplot(2,1,1)
plot(h);
axis(ax);
shg


% Apply matched filter
corr = mf( r, h );

% Plot results
figure(figg); clf;
subplot(2,1,1)
plot( fftshift( abs( fft(h,4096))))
subplot(2,1,2)
plot( corr );
shg;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
function corr = mf( x, h )
corr = conv(x,h(end:-1:1));
return;
