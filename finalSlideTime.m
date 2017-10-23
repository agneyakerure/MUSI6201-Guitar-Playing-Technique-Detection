function [slideTimes] = finalSlideTime(pitchInMidiSlide, timeStamps)

pitchInMidiCopy = pitchInMidiSlide;
uniqueVals = unique(pitchInMidiCopy, 'stable');
uniqueVals = uniqueVals(uniqueVals~=0);
pullOffTime = [];
indiceArray = [];
counter = 0;
nonZeroIndices = [];
slideTimes = [];

% for i = 1 : length(uniqueVals)
%     for j = 1 : length(pitchInMidiCopy)
%         if(pitchInMidiCopy(j) == uniqueVals(i))
%             if((pitchInMidiCopy(j + 1) == pitchInMidiCopy(j)) || (pitchInMidiCopy(j + 1) == 0))
%                 pitchInMidiCopy(j) = 0;
%             end
%             
%         end
%     end
% end

for j = 1 : length(pitchInMidiCopy)-1
    if(abs(pitchInMidiCopy(j+1) - pitchInMidiCopy(j)) ~= 1)
        pitchInMidiCopy(j) = 0;
    end
end
for k = 1 : length(pitchInMidiCopy)
   if(pitchInMidiCopy(k) ~= 0)
        indiceArray = [indiceArray, k];
    end
end
j = 1;
while (j <= length(indiceArray))
    k = j;
    
    while(k < length(indiceArray))
        
            if((0.01 < abs(timeStamps(indiceArray(k)) - timeStamps(indiceArray(k + 1)))) && (abs(timeStamps(indiceArray(k)) - timeStamps(indiceArray(k + 1)))< 0.07))
                counter = counter + 1;
            end
            k = k + 1;
        
    end
    
    if(counter >= 1)
        slideTimes = [slideTimes, timeStamps(indiceArray(j))];
        j = j + counter;
        counter = 0;
    else
        j = j + 1;
        counter = 0;
    end
    
end
    
    
end