function [specCentroid] = mySpectralCentroid(xb, fs)

%% Audio Feature: Spectral Centroid
% This function extracts the spectral centroid for each block of audio
% in the input matrix xb.
% input: 
%   xb:     (blockSize x numBlocks) float matrix, where numBlocks is 
%           the number of blocks
% output: 
%   specCentroid:(1 x numBlocks) float array, the resulting feature value per block

%% Write your code below:

[blockSize, numBlocks] = size(xb);

% Apply hann window to blocks
hWin = repmat(hann(blockSize), 1, numBlocks);
xb = xb .* hWin;

% Compute magnitude spectrum of each block
X = abs(fft(xb, blockSize, 1));
X = X(1:floor(blockSize/2)+1,:);

binIndices = 0:size(X, 1)-1;

specCentroid = binIndices*X ./ sum(X, 1);
specCentroid(sum(X, 1) == 0) = 0;
specCentroid = specCentroid ./ blockSize * fs;
end