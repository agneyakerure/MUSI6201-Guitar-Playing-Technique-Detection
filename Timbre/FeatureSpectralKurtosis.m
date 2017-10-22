function [vsk] = FeatureSpectralKurtosis (xb)
[blockSize, numBlocks] = size(xb);

hWin = repmat(hann(blockSize), 1, numBlocks);
xb = xb .* hWin;

xb = abs(fft(xb, blockSize, 1));
xb = xb(1:floor(blockSize/2)+1,:);

mu_x    = mean(abs(xb), 1);
std_x   = std(abs(xb), 1);

xb       = xb - repmat(mu_x, size(xb,1), 1);

vsk     = sum ((xb.^4)./(repmat(std_x, size(xb,1), 1).^4*size(xb,1)));

vsk     = vsk-3;
       
vsk (sum(xb,1) == 0) = 0;

end
