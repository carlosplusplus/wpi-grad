function metric = verify(input, output)
    if size(input,1) > size(input,2)
        output = output(1:size(input,1));
    else
        output = output(1:size(input,2));
    end
    
    avgInput = mean(abs(input));
    avgOutput = mean(abs(output));
    
    scaledOut = (avgInput/avgOutput)*output;
    
    diff = input - scaledOut;
    
    metric = nanstd(diff/mean(abs(input)));
    
end