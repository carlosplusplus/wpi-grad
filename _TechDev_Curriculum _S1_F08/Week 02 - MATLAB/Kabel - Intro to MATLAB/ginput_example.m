clicknum=0;button=1;	% ginput_example.m
figure(1);clf;
h=text(0,0.9,{'Click lots of times','To end right-click'})
while(button==1)
   clicknum=clicknum+1;
   [x,y,button]=ginput(1);
   text(x,y,['.',int2str(clicknum)]);
end;
title( 'Connect the dots')
delete(h)

