function [featureVect] = extractFeatures(x, blockSize, hopSize, fs)

%% Blocks an audio signal and calls the individual feature extraction functions.
% 
% Input:
%   x:           N x 1 float vector, input signal
%   blockSize:   int, size of each block
%   hopSize:     int, hop size
%   fs:          int, sampling frequency of x
% Output:
%   featureVect: (96 x numBlocks) float matrix, where numBlocks is 
%                the number of blocks
% Note:
%   1)  numBlocks depends on the length of the audio, zeropadding may be needed

[~,n] = size(x);
if (n>1)
    error('Illegal input signal. Signal has to be downmixed');
end
[m,n] = size(blockSize);
if (m ~= 1 && n ~=1)
    error('Illegal blockSize');
end
[m,n] = size(hopSize);
if (m ~= 1 && n ~=1)
    error('Illegal hopSize');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('Illegal fs');
end
%% Write your code below

xb = myBlockAudio(x, blockSize, hopSize, fs);

featureVect = zeros(96, size(xb, 2));

featureVect(1,:) = myRMS(xb);
featureVect(2,:) = myZCR(xb);
featureVect(3,:) = mySpectralCentroid(xb, fs);
featureVect(4,:) = mySpectralFlux(xb);
featureVect(5,:) = mySpectralCrest(xb);
featureVect(6,:) = FeatureSpectralKurtosis(xb);
featureVect(7,:) = FeatureSpectralSkewness(xb);
featureVect(8,:) = FeatureSpectralSpread(xb, fs);

featureVect(9,:) = [0,diff(myRMS(xb))];
featureVect(10,:) = [0,diff(myZCR(xb))];
featureVect(11,:) = [0,diff(mySpectralCentroid(xb, fs))];
featureVect(12,:) = [0,diff(mySpectralFlux(xb))];
featureVect(13,:) = [0,diff(mySpectralCrest(xb))];
featureVect(14,:) = [0,diff(FeatureSpectralKurtosis(xb))];
featureVect(15,:) = [0,diff(FeatureSpectralSkewness(xb))];
featureVect(16,:) = [0,diff(FeatureSpectralSpread(xb, fs))];

featureVect_Mfcc = FeatureSpectralMfccs(xb, fs);

diff_featureVect_Mfcc = diff(featureVect_Mfcc, 1, 2);
diff_featureVect_Mfcc = [zeros(size(featureVect_Mfcc,1), 1), diff_featureVect_Mfcc];

featureVect_Mfcc = [featureVect_Mfcc; diff_featureVect_Mfcc];

featureVect(17:end,:) = featureVect_Mfcc;


end