function [aggregatedFeatureVec] = aggregateFeaturesPerFile(featureValues)

%% Aggregates the values in featureValues and returns the mean and standard
% deviation, hence giving out 2 aggregated features per blocked feature per file.
% Input:
%   featureValues: 80 x numBlocks float array, features returned from extractFeatures.
% Output:
%   aggregatedFeatureVec: 160 x 1 float vector, aggregated feature vector
%                  Contains the mean and standard deviation of each in feature featureValues.

% Write your code below:

% Compute mean
feature_means = mean(featureValues, 2);

% Compute standard deviation
feature_stds = std(featureValues, 0, 2);

aggregatedFeatureVec = [feature_means; feature_stds];

end