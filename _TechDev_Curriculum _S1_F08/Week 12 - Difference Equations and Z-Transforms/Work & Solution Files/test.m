%% Week 12: Z-Transforms
syms a B damp stable p1
t = linspace(0,4,100);
damp = solve('(a + B - 2)^2 - 4*(1 - a) = 0',a);

y1 = subs(damp(1),B,t);
y2 = subs(damp(1),B,t);

figure; hold on;
plot(y1,t);
plot(y2,t);
plot(t,-2*t+4,'r');
hold off;
xlim([0 4]); ylim([0 4]);
title('\beta and \alpha');
xlabel('\alpha');
ylabel('\beta')

%%
% stable2 = solve('abs((-(a+B-2)-sqrt((a+B-2)^2-4*(1-a)))/2) = 1','B');
% stable = solve('abs((-(a+B-2)+sqrt((a+B-2)^2-4*(1-a)))/2) = 1','B');
% 
% %%
% clear all;
% N = 100;
% a = linspace(0,10,N);
% B = a;
% 
% f = inline('(-(a+B-2)-sqrt((a+B-2)^2-4*(1-a)))/2','a','B');
% 
% for i = 1:N
%     for j = 1:N
%         result(i,j) = abs(f(a(i),B(j))); %#ok<AGROW>
%     end
% end
% mesh(a,B,result);

%%
clear all;
figure;
H = inline('(a*z.^2 + (B - a)*z) ./ (z.^2 + (a + B -2)*z + 1 - a)','a','B','z');
w = linspace(-pi,pi,100);
z = exp(i*w);

hold on;
a = 1; B = 1;
Y = H(a,B,z);
plot(w,20*log(abs(Y)),'r')

a = 0.1; B = 1;
Y = H(a,B,z);
plot(w,20*log(abs(Y)))
hold off;

xlim([0 pi]);
title('Frequency Response');
ylabel('|H(\omega)| (dB)');
xlabel('\omega');
legend('a = 1, B = 1','a = 0.1, B = 1')

%%
clear all; figure; hold on;
H = inline('(a*z.^2 + (B - a)*z) ./ (z.^2 + (a + B -2)*z + 1 - a)','a','B','z');
w = linspace(-pi,pi,100);
z = exp(i*w);

a = 0.1; B = 1;
Y1 = H(a,B,z);
a = 0.1; B = 0.1;
Y2 = H(a,B,z);
a = 0.1; B = 0.01;
Y3 = H(a,B,z);

plot(w,20*log(abs(Y1)),'k')
plot(w,20*log(abs(Y2)),'r')
plot(w,20*log(abs(Y3)),'g')
hold off;
xlim([0 pi]);
title('Frequency Response');
ylabel('|H(\omega)| (dB)');
xlabel('\omega');
legend('a = 0.1, B = 1','a = 0.1, B = 0.1','a = 0.1, B = 0.01')

%%
clear all; figure; hold on;
H = inline('(a*z.^2 + (B - a)*z) ./ (z.^2 + (a + B -2)*z + 1 - a)','a','B','z');
w = linspace(-pi,pi,100);
z = exp(i*w);

a = 1; B = 1;
Y1 = H(a,B,z);
a = 0.1; B = 1;
Y2 = H(a,B,z);
a = 0.01; B = 1;
Y3 = H(a,B,z);
a = 0.001; B = 1;
Y4 = H(a,B,z);

plot(w,20*log(abs(Y1)),'k')
plot(w,20*log(abs(Y2)),'r')
plot(w,20*log(abs(Y3)),'g')
plot(w,20*log(abs(Y4)))
hold off;
xlim([0 pi]);
title('Frequency Response');
ylabel('|H(\omega)| (dB)');
xlabel('\omega');
legend('a = 1, B = 1','a = 0.1, B = 1','a = 0.01, B = 1','a = 0.001, B = 1')

%%
% num = [a -(B+a) 0];
% den = [1 (a + B -2) 1-a];
% 
% h = tf(num,den,'Ts');
% fvtool(num,den);