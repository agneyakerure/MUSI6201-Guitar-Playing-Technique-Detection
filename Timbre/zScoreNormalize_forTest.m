function [normFeatureMatrix] = zScoreNormalize_forTest(featureMatrix, STD, MEAN)

%% Performs z-score normalization over the input featureMatrix
%
% Inputs:
%   featureMatrix:  f x N float matrix, where f is the number of features (96 in this case)
%                   and N is the number of audio files in the directory.
%
% Outputs:
%   normFeatureMatrix:  f x N float matrix, where f is the number of features (96 in this case)
%                   and N is the number of audio files in the directory.

% Write your code below

% Compute mean and standard deviation of featureMatrix
meanFeatures = MEAN;
stdFeatures = STD;

% Normalize to 0 mean and 1 standard deviation. 
normFeatureMatrix = bsxfun(@minus, featureMatrix, meanFeatures);
normFeatureMatrix = bsxfun(@rdivide, normFeatureMatrix, stdFeatures);

% OR you can use loops if you're not familiar with bsxfun.
% normFeatureMatrix = zeros(size(featureMatrix));
% for i = 1:size(featureMatrix, 1)
%     normFeatureMatrix(i,:) = (featureMatrix(i,:) - meanFeatures(i))./stdFeatures(i);
% end