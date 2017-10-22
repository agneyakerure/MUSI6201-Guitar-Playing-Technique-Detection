function [vibratoTime] = finalVibratoTime(b1, newPitchInMidi, timeStamps)
i = 1;
[m, ~] = size(b1);
vibratoTime = [];
timeArray = [];
while(i <= (m - 3))
    if(b1(i, 1)>b1(i+1, 1)<b1(i+2, 1)>b1(i+3, 1) || b1(i, 1)<b1(i+1, 1)>b1(i+2, 1)<b1(i+3, 1))
        temp = [b1(i, 2), b1(i+1, 2), b1(i+2, 2), b1(i+3, 2)];
        % check time difference
        for j = 1 : 3
            timeDiff = abs(timeStamps(temp(j)) - timeStamps(temp(j + 1)));
            pitchDiff = abs(newPitchInMidi(temp(j)) - newPitchInMidi(temp(j + 1))) * 100;
            if((timeDiff > 0.03 && timeDiff < 0.4) && (pitchDiff < 225))
                flag = true;
            else
                b1(j, :) = [];
                i = i + 1;
                flag = false;
                break;
            end
        end
        if((flag == true))
            vibratoTime = [vibratoTime, timeStamps(b1(i, 2))]; % , timeStamps(b1(i+4, 2))
            i = i + 4;
        end
    else
        b1(i, :) = [];
        i = i + 1;
    end
    [m, ~] = size(b1);
end

end