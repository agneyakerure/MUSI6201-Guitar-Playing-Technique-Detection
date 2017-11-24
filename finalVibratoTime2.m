function [vibratoTime] = finalVibratoTime2(arr, newPitchInMidi, timeStamps)

    vibratoTime = [];
    for i = 1 : length(arr)
        if(arr(i) == 1)
            initialIndex = i;
            break;
        end
    end
    
    for i = length(arr) : -1: 1
        if(arr(i) == 1)
            finalIndex = i;
            break;
        end
    end
    
    for i = 1 : length(arr)
        if(arr(i) == 1)
            if(i == initialIndex) %First Peak Element
                nextIndex = findNextIndex(i, arr);
                dist = abs(timeStamps(nextIndex) - timeStamps(i));
                if(dist < 0.03) && (dist > 0.4)
                    arr(i) = 0;
                end
                pitchDist = abs(newPitchInMidi(nextIndex) - newPitchInMidi(i)) * 100;
                if(pitchDist > 225)
                    arr(i) = 0;
                end
            elseif(i == finalIndex) %Last Peak Element
                prevIndex = findPrevIndex(i, arr);
                dist = abs(timeStamps(i) - timeStamps(prevIndex));
                if(dist < 0.03) && (dist > 0.4)
                    arr(i) = 0;
                end
                pitchDist = abs(newPitchInMidi(i) - newPitchInMidi(prevIndex)) * 100;
                if(pitchDist > 225)
                    arr(i) = 0;
                end
            else %Other Peak Elements
                prevIndex = findPrevIndex(i, arr);
                nextIndex = findNextIndex(i, arr);
                dist1 = abs(timeStamps(i) - timeStamps(prevIndex));
                if(dist1 < 0.03) && (dist1 > 0.4)
                    arr(i) = 0;
                end
                dist2 = abs(timeStamps(nextIndex) - timeStamps(i));
                if(dist2 < 0.03) && (dist2 > 0.4)
                    arr(i) = 0;
                end
                
                pitchDist1 = abs(newPitchInMidi(nextIndex) - newPitchInMidi(i)) * 100;
                pitchDist2 = abs(newPitchInMidi(i) - newPitchInMidi(prevIndex)) * 100;
                if(pitchDist1 > 225) && (pitchDist2 > 225)
                    arr(i) = 0;
                end
            end
        end
    end
    
    for i = 1 : length(arr)
        if(arr(i) == 1)
            vibratoTime = [vibratoTime, timeStamps(i)];
        end
    end
    
    vibratoTime = vibratoTime';
end