% data - input data
% corruption_level - integer level of corruption
function output = part2post(data,corruption_level)
    comp = 2;
    bits = 4;
    A = 100000;
    if corruption_level == 3 
        output = decompress(decode3(data, bits, A),comp);
        
    else
       
        switch corruption_level
            case 1
                width = 1024;
                bins = 129;
            otherwise
                width = 4096;
                bins = 33;
        end
        
        tSignal = data(1:length(data)/2);
        tData = data(length(data)/2+1:length(data));
        output = (tSignal*width + tData*width/(bins))'; 
    end
end
