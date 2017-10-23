function [zcr] = myZCR(xb)

%% Audio Feature: Zero-Crossing Rate
% This function extracts the zero-crossing rate for each block of audio
% in the input matrix xb.
% input: 
%   xb:     (blockSize x numBlocks) float matrix, where numBlocks is 
%           the number of blocks
% output: 
%   specCrest:(1 x numBlocks) float array, the resulting feature value per block

%% Write your code below:

numBlocks = size(xb, 2);
zcr = zeros(1, numBlocks);

for i=1:numBlocks
    block = xb(:,i);.........................................
    sign_block = sign(block);
    diff_block = diff(sign_block);
    diff_block(1) = 0;
    block_zcr = 0.5 * (sum(abs(diff_block))) / size(xb, 1);
    zcr(i) = block_zcr;
end

end