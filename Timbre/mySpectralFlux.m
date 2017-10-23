function [specFlux] = mySpectralFlux(xb)

%% Audio Feature: Spectral Flux
% This function extracts the spectral flux for each block of audio
% in the input matrix xb.
% input: 
%   xb:     (blockSize x numBlocks) float matrix, where numBlocks is 
%           the number of blocks
% output: 
%   specFlux:(1 x numBlocks) float array, the resulting feature value per block

%% Write your code below:

[blockSize, numBlocks] = size(xb);

% Apply hann window to blocks
hWin = repmat(hann(blockSize), 1, numBlocks);
xb = xb .* hWin;

% Compute magnitude spectrum of each block
X = abs(fft(xb, blockSize, 1));
X = X(1:floor(blockSize/2)+1,:);

X_diff = diff(X, 1, 2);
specFlux = sqrt(sum(X_diff.^2))/size(X, 2);
specFlux = [specFlux(1), specFlux];

end