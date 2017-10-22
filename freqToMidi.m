function  [pitchInMidi] = freqToMidi(pitchInHz)

%% Converts fundamental pitch in Hz to pitch in MIDI
% Input:
%   pitchInHz:		(N x 1) float vector, fundamental pitch in Hz
% Output:
%   pitchInMidi:    (Nx 1) float vector, pitch in MIDI

% Check input dimensions 
[~,n] = size(pitchInHz);
if (n>1)
    error('illegal input signal');
end

%% Please write your code here

base_a4 = 440;
n = length(pitchInHz);
pitchInMidi = zeros(size(pitchInHz));

for i = 1 : n
    pitchInMidi(i, 1) = 69 + (12*log2(pitchInHz(i, 1)/base_a4));
end

end