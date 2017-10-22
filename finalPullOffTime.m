function [pullOffTime] = finalPullOffTime(pitchInMidi, timeStamps)

pitchInMidiCopy = pitchInMidi;
uniqueVals = unique(pitchInMidiCopy, 'stable');
uniqueVals = uniqueVals(uniqueVals~=0);
pullOffTime = [];
for i = 1 : length(uniqueVals)
    for j = 1 : length(pitchInMidiCopy)
        if(pitchInMidiCopy(j) == uniqueVals(i))
            if((pitchInMidiCopy(j + 1) == pitchInMidiCopy(j)) || (pitchInMidiCopy(j + 1) == 0))
                pitchInMidiCopy(j) = 0;
            end
        end
    end
end
for j = 1 : length(pitchInMidiCopy) - 1
    if(pitchInMidiCopy(j) ~= 0)
        if((abs(timeStamps(j+1) - timeStamps(j)) < 0.02))
            pullOffTime = [pullOffTime, timeStamps(j)];
        end
    end
end

end