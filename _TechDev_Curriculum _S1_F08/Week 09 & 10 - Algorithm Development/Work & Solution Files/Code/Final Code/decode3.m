% data - Input data
% bits - Number of bits for encoding
% A - Upper limit, A must be greater than 64E3
function decData = decode3(data, bits, A)
    bWidth = (2*A/3^bits);                               % Bin width
    
    transData = reshape(data,size(data,1)/bits,bits);    % Temp storage

    decData = (sum((((transData/A) + 1).* ...
              repmat(3.^((bits-1):-1:0)*bWidth,size(transData,1),1))')-A); %#ok<UDIM>

    %scaleFactor = sqrt(decData(size(decData,2)))/1000;
    %decData = decData(1:size(decData,2)-1);
    decData = decData';
end


