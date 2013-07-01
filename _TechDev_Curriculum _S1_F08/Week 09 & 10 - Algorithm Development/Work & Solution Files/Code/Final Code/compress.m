function out = compress(data,cFactor)
    if cFactor ~= 1
        out = data(1:cFactor:end);
    else
        out = data;
    end
end


