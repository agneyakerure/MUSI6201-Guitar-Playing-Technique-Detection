function [slideTimes] = findSlideTime(pitchInMidi, timeStamps)

len = length(pitchInMidi);
slideNotesArray = zeros(length(pitchInMidi), 0);
uniqueVals = unique(pitchInMidi, 'stable');
uniqueVals = uniqueVals(uniqueVals~=0);
slideTimes = [];
for i = 1 : length(uniqueVals)
    tempArr = [];
    for j = 1 : length(pitchInMidi)
        if(pitchInMidi(j) == uniqueVals(i))
            tempArr = [tempArr, j]; % no
        end
    end
    % tempArr has indices of one frequency which is being checked - if it
    % is between 10ms and 70ms
    tempArr = removeSingleUniqueElements(tempArr); % removes single unique elements - need continuous to check time difference
    tempArr = tempArr';
    diffTempArr = diff(tempArr); % newTempArr has indices of frequencies to be checked for length
    
    pitchTime(i, 1) = pitchTimePresence(tempArr, diffTempArr, timeStamps);
    
    % Slide Time Extract will extract indices of required time
    % stamps(timeStamps) and subtract to find if 10ms<x<70ms
    
    
    % Need to check if these are continuous in steps of 3
    
end

end