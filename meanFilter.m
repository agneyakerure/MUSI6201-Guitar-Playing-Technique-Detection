function [filteredSignal] = meanFilter(inputSignal, windowLength, stepSize)

len = length(inputSignal);
windowLengthSamples = round(windowLength * 44100);
step = round(stepSize * 44100);
numWindows = floor((len - windowLengthSamples)/step) + 1;
currentPos = 1;

for i = 1 : numWindows 
    frame = inputSignal(currentPos:currentPos + windowLengthSamples - 1);
    
    filteredSignal(i, 1) = sum(frame)/length(frame);
    currentPos = currentPos + step;
end

end