function [slides] = pitchTimePresence(tempArr, diffTempArr, timeArr)
len = length(diffTempArr);
temp = [];
ctr = 0;

for i = 1 : length(diffTempArr)
    if(diffTempArr(i) ~= 1)
        ctr = ctr + 1;
    end
end
answerArray = [];
count = 0;
for j = 1 : len
    if(diffTempArr(j) ~= 1)
        count = count + 1;
        if(count == 1)
            difference = abs(timeArr(tempArr(j)) - timeArr(1));
            if(difference > 0.01 && difference < 0.07)
                answerArray = [answerArray, difference];
            end

        elseif(count == ctr)
            difference = abs(timeArr(end) - timeArr(tempArr(j)));
            if(difference > 0.01 && difference < 0.07)
                answerArray = [answerArray, difference];
            end
            
        else    
            difference = abs(timeArr(tempArr(j)) - timeArr(tempArr(j-1)+1));
            if(difference > 0.01 && difference < 0.07)
                answerArray = [answerArray, difference];
            end
        end
    
    else
        difference = abs(timeArr(tempArr(end)) - timeArr(tempArr(1)));
        if(difference > 0.01 && difference < 0.1)
            answerArray = [answerArray, difference];
        else
            answerArray = 0;
        end
        break;
    end 
end

slides = answerArray;

end
