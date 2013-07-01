% meshgrid_examples

%Constructing a surface
x_axis = [-100:100];
y_axis = [-120:120];
[x,y] = meshgrid( x_axis, y_axis );
z = x.^2 + y.^2;
figure(1);clf;
mesh( x,y,z )       % Try, also,the plot3 command
pause

% Tagging data
clear variables;
az=[-90:90];
el=[0:45];
load array_response;
whos
pause
[azgrid, elgrid] = meshgrid( az, el);
figure(2);clf;
mesh( azgrid, elgrid, arr_response );
xlabel( 'az')
ylabel( 'el')
zlabel( 'Array Response')
