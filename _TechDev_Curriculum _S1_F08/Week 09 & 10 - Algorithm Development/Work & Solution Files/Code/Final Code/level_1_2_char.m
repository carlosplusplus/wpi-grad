%% Corruption Level 1 and 2 Characterization
clear all;
L = 100;        % Number of output generations
N = 10000;      % Number of Random samples in input
widthT = zeros(1,L); 
numAT = zeros(1,L);
t = linspace(L,10*L*L,L);

for m = 1:3
    for j = 1:L
        max = t(j);
        set = rand(N,1)*2*max-max;
        result = eldp(set,m);
        [numA, list] = countAmplitudes(result);
        list = sort(list);
        numAT(j) = numA;

        if 1 ~= size(list,2)
            for i = 1:size(list,2)-1
                width(i) = list(i+1)-list(i); %#ok<AGROW>
            end
            widthT(j) = width(1);
        end
    end
    figure
    plot(t,widthT);
    xlabel('Signal Height')
    ylabel('Bin Width')
    title(['Level ', int2str(m), ' - Bin Width versus Signal Height'])    
    
    figure;
    plot(t,numAT);
    xlabel('Signal Height')
    ylabel('Number of Bins')
    title(['Level ', int2str(m), ' - Number of Bins versus Signal Height'])
end


