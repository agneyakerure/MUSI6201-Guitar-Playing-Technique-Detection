function [aggregatedFeatureVec] = aggregateFeaturesPerFile(featureValues)

%% Aggregates the values in featureValues and returns the mean, standard
% deviation, max, min, skewness and kurtosis, hence giving out
% 6 aggregated features per blocked feature per file.
% Input:
%   featureValues: 96 x numBlocks float array, features returned from extractFeatures.
% Output:
%   aggregatedFeatureVec: 256 x 1 float vector, aggregated feature vector
%                  Contains the mean, standard deviation, max, min, skewness and kurtosis
%                  of each in feature featureValues.

% Write your code below:

featureValues_Mfcc = featureValues(17:end, :);
featureValues = featureValues(1:16, :);

% Compute mean
feature_means = mean(featureValues, 2);

% Compute standard deviation
feature_stds = std(featureValues, 0, 2);

feature_max = max(featureValues, [], 2);
feature_min = min(featureValues, [], 2);
feature_skewness = skewness(featureValues, 0, 2);
feature_kurtosis = kurtosis(featureValues, 0, 2);

aggregatedFeatureVec = [feature_means; feature_stds; feature_max; feature_min; feature_skewness; feature_kurtosis];

feature_means_Mfcc = mean(featureValues_Mfcc, 2);
feature_stds_Mfcc = std(featureValues_Mfcc, 0, 2);

aggregatedFeatureVec = [aggregatedFeatureVec; feature_means_Mfcc; feature_stds_Mfcc];

end