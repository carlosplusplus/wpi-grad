function encData = encode3(data, bits)

A = 100000;                                   % Upper limit, A must be greater than 64K

bWidth = 66666;                               % Bin width

transData = data;                             % Temp storage

maxData = max(abs(data));                     % Max data value

scaleFactor = A/maxData;

scaledData = transData * scaleFactor;         % Scaled signal
scaledData(scaledData == 0) = 10^-6;

encData = zeros(size(data,1),bits);           % Encoded data stream

for z = 1:bits

    encData(:,z) = (scaledData./abs(scaledData)).*floor((abs(scaledData)+bWidth/2)/bWidth);
    encData(encData>=2) = 1;

    scaledData(encData(:,z)==1) = (scaledData(encData(:,z)==1) - bWidth)*2*A/bWidth;
    scaledData(encData(:,z)==0) = (scaledData(encData(:,z)==0))*2*A/bWidth;
    scaledData(encData(:,z)==-1) = (scaledData(encData(:,z)==-1) + bWidth)*2*A/bWidth;
    %     plot(encData(:,z))
    
end

encData = A*reshape(encData,size(data,1)*bits,1);

end

%% Input into main file.

% input = encode3(data,5);
% output = eldp((encode3(data,5)),3);
% sum(input - output)



