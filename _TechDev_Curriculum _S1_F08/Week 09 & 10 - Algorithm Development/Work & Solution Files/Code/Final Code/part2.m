% data - input data
% corruption_level - integer level of corruption
function output = part2(data,corruption_level)
    preProcessed = part2pre(data,corruption_level);
    received = eldp(preProcessed,corruption_level);
    postProcessed = part2post(received,corruption_level);
    output = postProcessed;
end
