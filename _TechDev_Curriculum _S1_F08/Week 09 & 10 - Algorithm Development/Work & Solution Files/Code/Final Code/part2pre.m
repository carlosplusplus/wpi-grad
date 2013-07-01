% data - input data
% corruption_level - integer level of corruption
function output = part2pre(data,corruption_level)
    comp = 2;
    bits = 4;
    A = 100000;
    if corruption_level == 3 
        output = compress(encode3(data, bits,A),comp); 
    else
       
        switch corruption_level
            case 1
                width = 1024;
                bins = 129;
            otherwise
                width = 4096;
                bins = 33;
        end

        for i = 1:length(data)
            signal(i) = binNumber(data(i),width); %#ok<AGROW>
            remainder = data(i) - signal(i)*width;
            encode(i) = binNumber(remainder, width/bins); %#ok<AGROW>
        end

        output = [signal,encode]*width*bins/2;
    end
end
