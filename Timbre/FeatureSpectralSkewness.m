function [vssk] = FeatureSpectralSkewness (xb)
[blockSize, numBlocks] = size(xb);

hWin = repmat(hann(blockSize), 1, numBlocks);
xb = xb .* hWin;

xb = abs(fft(xb, blockSize, 1));
xb = xb(1:floor(blockSize/2)+1,:);

mu_x    = mean(abs(xb), 1);
std_x   = std(abs(xb), 1);

xb      = xb - repmat(mu_x, size(xb,1), 1);

vssk    = sum ((xb.^3)./(repmat(std_x, size(xb,1), 1).^3*size(xb,1)));

vssk (sum(xb,1) == 0) = 0;

end
