%Presentation Generation
function y = presGen(stage,item,play)
    load brownie
    set1 = data;
    load brownie
    set2 = data;
    load brownie
    set3 = data';
    
    switch stage
        % Part 1
        case 1
            load part1
            switch item
                case 1
                    y = p1s1;
                case 2
                    y = part1(p1s1);
                case 3
                    y = p1s2;
                case 4
                    y = part1(p1s2);
                otherwise
            end

        % Input Sound Files
        case 2   
            switch item
                case 1
                    y = set1;
                case 2
                    y = set2;
                case 3 
                    y = set3;
                otherwise
            end
        % Part 2 Generic Input and Output - Set 1
        case 3
            switch item
                case 1
                    y = set1;
                case 2
                    y = eldp(set1,1);
                case 3 
                    y = eldp(set1,2);
                case 4
                    y = eldp(set1,3);
                case 5
                    y = part2(set1,1);
                case 6
                    y = part2(set1,2);
                otherwise
            end
        % Bit Levels
        case 4
          %  bits = item;
          %  A = 100000; comp=2;
          %  save bCount A bits comp
            y = part2(set2,3);
        
        % Compression Levels
        case 5
            comp = item;
            temp = compress(set3,comp);
            tempOut = part2(temp,1);
            y = decompress(tempOut,comp);
        case 6
            soundsc(wavread('CustomSound04.wav'),44100);
        case 7
            soundsc(wavread('CustomSound05.wav'),44100);
        otherwise
            soundsc(wavread('CustomSound01.wav'),22050);
    end
    
    if play == 1
        soundsc(y);
    end
    
end
