function veri = metricEval(data, A)

m = max(abs(data));

A = A*m;

noise = data+(A*rand(size(data,1),1)-A/2);

soundsc(noise);

veri = verify(data,noise);
