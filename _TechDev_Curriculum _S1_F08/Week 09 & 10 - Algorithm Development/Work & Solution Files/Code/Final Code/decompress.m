function out = decompress(data, dFactor)
    if dFactor ~= 1
        out = interp(data,dFactor);
    else
        out = data;
    end
end


