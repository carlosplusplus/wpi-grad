%%
clear all;
load rich
A = 100000; comp = 2;
for bits = 2:8
    save bCount bits A comp
    level3 = part2(data,3);
    dev(bits-1) = verify(data,level3); %#ok<AGROW>
end
figure;
plot(2:8,dev);

title('Level 3 - Bit Optimization')
xlabel('Number of Bits for Encoding')
ylabel('Signal Metric')

load rich
for comp = 2:8
    temp = decompress(compress(data,comp),comp);
    dev2(comp-1) = verify(data,temp(1:size(data,1))); %#ok<AGROW>
end
figure;
plot(2:8,dev2);

title('All Levels - Compression Optimization')
xlabel('Compression Level')
ylabel('Signal Metric')

%%