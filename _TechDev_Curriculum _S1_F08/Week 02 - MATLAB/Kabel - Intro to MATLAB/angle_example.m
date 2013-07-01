% angle_example.m
echo on
cmplx_gen_example
pause
figure(1); clf;
ang = angle(cc);
mag = abs(cc);

subplot(2,1,1)
plot((180/pi)*ang)
subplot(2,1,2)
plot(mag);

pause;

subplot(2,1,1)
plot((180/pi)*unwrap(ang))

echo off