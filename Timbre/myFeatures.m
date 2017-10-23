close all
clear all
clc
 
%% Get the music features
blockSize = 1024;
hopSize = 256;
featureMatrixMusic_train = [];
featureMatrixMusic_test = [];
 
for i = 1:5
    music_path = ['../Audio_Files/', num2str(i), '/'];
    featMat = getMetaData(music_path, blockSize, hopSize);
    featMat = [featMat; i*ones(1, size(featMat, 2))];
    
    
    featMat = featMat(:,randperm(size(featMat, 2)));
    
    train = floor(size(featMat, 2)*4/5);
    
    featureMatrixMusic_train = [featureMatrixMusic_train , featMat(:,1:train)];
    featureMatrixMusic_test = [featureMatrixMusic_test , featMat(:,train+1:end)];
    
    
end
 
num_features = size(featureMatrixMusic_train, 1);
 
order_train = featureMatrixMusic_train(num_features,:);
order_test = featureMatrixMusic_test(num_features,:);
 
featureMatrixMusic_train = featureMatrixMusic_train(1:num_features-1,:);
featureMatrixMusic_test = featureMatrixMusic_test(1:num_features-1,:);
 
 
%% Normalize them
[MEAN, STD, normFeatureMatrix_train] = zScoreNormalize(featureMatrixMusic_train);
 
[normFeatureMatrix_test] = zScoreNormalize_forTest(featureMatrixMusic_test, STD, MEAN);
 
%%
 
order_train = order_train';
order_test = order_test';
 
normFeatureMatrix_train = normFeatureMatrix_train';
normFeatureMatrix_test = normFeatureMatrix_test';
 
%%
 
% normFeatureMatrix_tr = [normFeatureMatrix_train(:, 2:8), normFeatureMatrix_train(:, 10:end)];
% normFeatureMatrix_ts = [normFeatureMatrix_test(:, 2:8), normFeatureMatrix_test(:, 10:end)];
 
normFeatureMatrix_tr = normFeatureMatrix_train;
normFeatureMatrix_ts = normFeatureMatrix_test;
 
model = svmtrain(order_train, normFeatureMatrix_tr, '-s 1');
[p_order_test, ~,~] = svmpredict(order_test, normFeatureMatrix_ts, model);
 
%%
 
[cm, ~] = confusionmat(order_test, p_order_test);