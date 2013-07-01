function y = binNumber(value, binWidth)
    if value == 0
        value = 10E-6;
    end
    y = (value/abs(value))*floor((abs(value) + binWidth/2)/binWidth);
end