function [y,list] = countAmplitudes(data)
list = [];
for i = 1:size(data,1)
    if (size(find(list==data(i)),2) == 0)
        list(size(list,2)+1)=data(i);
    end
end
y = size(list,2);
end
