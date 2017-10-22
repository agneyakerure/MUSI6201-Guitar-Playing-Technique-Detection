clear;
clc;

currentFolder = pwd;
inputAudioFolder = '/Users/agneyakerure/Desktop/ACA_Project';
cd(inputAudioFolder);
audioFileNames = dir('*wav');
len = length(audioFileNames);
Fs = 44100;

for i = 1 : len
   pathToSonicAnnotator =  '/Users/agneyakerure/Desktop/ACA_Project/sonic-annotator-1.5-osx-amd64/sonic-annotator ';
   vamp = ' -d vamp:mtg-melodia:melodia:melody ';
   audioFile = audioFileNames(i).name;
   writer = ' -w csv';
   command = [pathToSonicAnnotator, vamp, audioFile, writer];
   system(command);
end

csvFiles = dir('*csv');
len = length(csvFiles);
pitchTracks = cell(len, 1);
timeStamps = cell(len, 1);

for i = 1 : len
    output = dlmread(csvFiles(i).name);
    pitchTracks = output(:, 2);
    timeStamps = output(:, 1);
   
    len = length(pitchTracks);
    for j = 1 : len
       if(pitchTracks(j) < 0)
           pitchTracks(j) = 0;
       end
    end
    figure;
    plot(pitchTracks);
    [pitchInMidi] = freqToMidi(pitchTracks);
    for j = 1 : length(pitchInMidi)
        if(isinf(pitchInMidi(j)))
            pitchInMidi(j) = 0;
        end 
    end
    
    % Vibrato
    figure;
    plot(pitchInMidi);hold on;
    [pks, locs] = findpeaks(pitchInMidi);
    plot(locs, pks); hold off;
    
    
    newPitchInMidi = pitchInMidi;
    temp_pitchInMidi = [0;0;pitchInMidi;0;0];
    for i = 3:length(temp_pitchInMidi)-2
        newPitchInMidi(i-2) = mean([temp_pitchInMidi(i-2),temp_pitchInMidi(i-1),temp_pitchInMidi(i),temp_pitchInMidi(i+1),temp_pitchInMidi(i+2)]);
    end
    
    movAvg = dsp.MovingAverage();
    newPitchInMidi = step(movAvg,newPitchInMidi);
    figure;
    plot(newPitchInMidi); hold on;
    [pks, locs] = findpeaks(newPitchInMidi, 'MinPeakProminence', 0.1);
    plot(locs, pks); 
    newPitchInMidi2 = 1.01*max(newPitchInMidi) - newPitchInMidi;
    [pks2, locs2] = findpeaks(newPitchInMidi2, 'MinPeakProminence', 0.1);
    pks2 = newPitchInMidi(locs2);
    plot(locs2, pks2); hold off;
    
    a1 = [pks, locs; pks2, locs2];
    b1 = sortrows(a1,2);
    
    [vibratoTime] = finalVibratoTime(b1, newPitchInMidi, timeStamps);
    


    % For Slide - we need quantized pitchInMidi (not floating)
    [pitchInMidiSlide] = freqToMidiQuant(pitchTracks);
    for j = 1 : length(pitchInMidiSlide)
        if(isinf(pitchInMidiSlide(j)))
            pitchInMidiSlide(j) = 0;
        end 
    end
 
    [slideTimes] = finalSlideTime(pitchInMidiSlide, timeStamps);

    %Pull-off
    [pitchInMidiPull] = freqToMidiQuant(pitchTracks);
    for j = 1 : length(pitchInMidiPull)
        if(isinf(pitchInMidiPull(j)))
            pitchInMidiPull(j) = 0;
        end 
    end
    [pullOffTime] = finalPullOffTime(pitchInMidiPull, timeStamps);
    
    
    
end