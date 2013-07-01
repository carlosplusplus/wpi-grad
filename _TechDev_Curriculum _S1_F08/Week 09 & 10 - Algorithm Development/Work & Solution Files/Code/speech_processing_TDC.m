clear all;
%% Part 1
load filtGood;
load part1;
data = p1s1;
for i = 1:2
    figure;
    specgram(data);
    soundsc(data);
    clean = filter(Num,1,data);
    figure;
    specgram(clean);
    soundsc(clean);
    data = p1s2;
end

%% Part 2 - Graph Input and Default Outputs
load rich
step1 = eldp(data,1);
step2 = eldp(data,2);
step3 = eldp(data,3);

figure
subplot(2,2,1), plot(data)
subplot(2,2,2), plot(step1)
subplot(2,2,3), plot(step2)
subplot(2,2,4), plot(step3)

figure
subplot(2,2,1), hist(data,100000)
subplot(2,2,2), hist(step1,100000)
subplot(2,2,3), hist(step2,100000)
subplot(2,2,4), hist(step3,100000)

% count = [countAmplitudes(data), countAmplitudes(step1), ...
%          countAmplitudes(step2), countAmplitudes(step3)];

%% Experiment 
input = rand(1000,1)*100000-500 + rand(1000,1);
test = eldp(input,3);
countAmplitudes(test)

%% Data Compression 1
mask1 = repmat([0 1],1,size(data,1)/2).*data'; %<- Compressed in Time
%mask2 = repmat([1 0],1,size(data,1)/2).*data';
test = mask1(1:19251)+mask1(2:19252);
cleanTest = filter(Num2,1,test);
soundsc(cleanTest);
specgram(cleanTest);

%% Data Compression
comp = [];
soundsc(data)
s = 1000;
for i=1:s:length(data')-s
    windowDCT = dct(data(i:i+s-1));
    comp(i:i+s-1) = idct(windowDCT(1:s/2), s); %<- Compressed in frequency
end
specgram(comp)
soundsc(comp)
soundsc(Y)
