clear;
clc;

%Audio Data Input Folder
currentFolder = pwd;
inputAudioFolder = '/Users/agneyakerure/Desktop/audio content analysis/ACA_Project';
cd(inputAudioFolder);
audioFileNames = dir('*wav'); %Change this to suit your need
len = length(audioFileNames);
Fs = 44100;

%Using Sonic Annotator and Melodia
for i = 1 : len
   pathToSonicAnnotator =  '/Users/agneyakerure/Desktop/audio\ content\ analysis/ACA_Project/sonic-annotator-1.5-osx-amd64/sonic-annotator ';
   vamp = ' -d vamp:mtg-melodia:melodia:melody ';
   audioFile = audioFileNames(i).name;
   writer = ' -w csv';
   command = [pathToSonicAnnotator, vamp, audioFile, writer];
   system(command);
end

%Saving Output of Sonic Annotator as a CSV file
csvFiles = dir('*csv');
len = length(csvFiles);
pitchTracks = cell(len, 1);
timeStamps = cell(len, 1);

for i = 1 : len
    %Reading Data from CSV file for each audio file
    output = dlmread(csvFiles(i).name);
    pitchTracks = output(:, 2);
    timeStamps = output(:, 1);
   
    len = length(pitchTracks);
    for j = 1 : len
       if(pitchTracks(j) < 0)
           pitchTracks(j) = 0;
       end
    end
%     figure;
%     plot(pitchTracks);
    
    %Finding Pitch in Midi values
    [pitchInMidi] = freqToMidi(pitchTracks);
    for j = 1 : length(pitchInMidi)
        if(isinf(pitchInMidi(j)))
            pitchInMidi(j) = 0; %All values which are infinity are set to 0
        end 
    end
    
    
    
    
    % Vibrato
%     figure; %figure 1 - PitchInMidi
%     plot(pitchInMidi);hold on;
%     [pks, locs] = findpeaks(pitchInMidi);
%     plot(locs, pks); hold off;
%     
%     
%     newPitchInMidi = pitchInMidi;
%     temp_pitchInMidi = [0;0;pitchInMidi;0;0];
%     for k = 3:length(temp_pitchInMidi)-2
%         newPitchInMidi(k-2) = mean([temp_pitchInMidi(k-2),temp_pitchInMidi(k-1),temp_pitchInMidi(k),temp_pitchInMidi(k+1),temp_pitchInMidi(k+2)]);
%     end
%     
%     movAvg = dsp.MovingAverage();
%     newPitchInMidi = step(movAvg,newPitchInMidi);
%     figure;
%     plot(newPitchInMidi); hold on;
%     
%     tf = islocalmin(newPitchInMidi, 'MinProminence', 0.35);
%     tg = islocalmax(newPitchInMidi, 'MinProminence', 0.35);
%     arr = togetherEqual(tf, tg);
%     
%     [vibratoTime] = finalVibratoTime2(arr, newPitchInMidi, timeStamps);

    
    

    % For Slide - we need quantized pitchInMidi (not floating)
%     [pitchInMidiSlide] = freqToMidiQuant(pitchTracks);
%     for j = 1 : length(pitchInMidiSlide)
%         if(isinf(pitchInMidiSlide(j)))
%             pitchInMidiSlide(j) = 0;
%         end 
%     end
%  
%     [slideTimes] = finalSlideTime(pitchInMidiSlide, timeStamps);





%     %Pull-off
    [pitchInMidiPull] = freqToMidiQuant(pitchTracks);
    for j = 1 : length(pitchInMidiPull)
        if(isinf(pitchInMidiPull(j)))
            pitchInMidiPull(j) = 0;
        end 
    end
    [pullOffTime] = finalPullOffTime(pitchInMidiPull, timeStamps);
    
    
    
end