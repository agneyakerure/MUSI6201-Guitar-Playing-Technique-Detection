function [newTempArr] = removeSingleUniqueElements(tempArr, pitchInMidi)
newTempArr = tempArr;
    for k = 1 : length(tempArr)
        if(k == 1)
            if(abs(pitchInMidi(tempArr(k)) - pitchInMidi(tempArr(k+1))) ~= 1)
                newTempArr(k) = [];
            end
            
        elseif(k == length(tempArr))
            if(abs(pitchInMidi(tempArr(k)) - pitchInMidi(tempArr(k-1))) ~= 1)
                newTempArr(k) = [];
            end
            
        else
            if((abs(pitchInMidi(tempArr(k)) - pitchInMidi(tempArr(k-1))) ~= 1) && (abs(pitchInMidi(tempArr(k)) - pitchInMidi(tempArr(k+1))) ~= 1))
                newTempArr(k) = [];
            end
        end
    end
end