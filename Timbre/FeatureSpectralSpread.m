function [vss] = FeatureSpectralSpread (xb, fs)
[blockSize, numBlocks] = size(xb);

hWin = repmat(hann(blockSize), 1, numBlocks);
xb = xb .* hWin;

xb = abs(fft(xb, blockSize, 1));
xb = xb(1:floor(blockSize/2)+1,:);

vsc = mySpectralCentroid(xb, fs)*2/fs * size(xb,1);

vss     = zeros(size(vsc));

xb       = xb.^2;
    for n = 1:size(xb,2)
        % doubtful
        vss(n)  = (((0:size(xb,1)-1)-vsc(n)).^2*xb(:,n))./sum(xb(:,n));
    end
vss     = sqrt(vss);

vss     = vss / size(xb,1) * fs/2;

vss (sum(xb,1) == 0) = 0;

end
