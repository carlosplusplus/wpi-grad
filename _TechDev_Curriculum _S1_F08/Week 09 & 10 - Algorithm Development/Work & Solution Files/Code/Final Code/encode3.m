% data - Input data
% bits - Number of bits for encoding
% A - Upper limit, A must be greater than 64E3
function output = encode3(data, bits, A)

    bWidth = (2*A/3);                        % Bin width

    transData = data;                             % Temp storage

    maxData = max(abs(data));                     % Max data value

    scaleFactor = A/maxData;

    scaledData = transData * scaleFactor; % Scaled signal
    scaledData(scaledData == 0) = 10^-6;

    encData = zeros(size(data,1),bits);           % Encoded data stream

    for z = 1:bits
        encData(:,z) = (scaledData./abs(scaledData)).*floor((abs(scaledData)+bWidth/2)/bWidth);
        encData(encData>=2) = 1;
        encData(encData<=-2) = -1;
        
        scaledData(encData(:,z)==1) = (scaledData(encData(:,z)==1) - bWidth)*2*A/bWidth;
        scaledData(encData(:,z)==0) = (scaledData(encData(:,z)==0))*2*A/bWidth;
        scaledData(encData(:,z)==-1) = (scaledData(encData(:,z)==-1) + bWidth)*2*A/bWidth;
    end

    output = A*reshape(encData,(size(data,1))*bits,1);

end