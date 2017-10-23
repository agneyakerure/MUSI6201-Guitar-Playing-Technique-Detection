function [vmfcc] = FeatureSpectralMfccs(xb, fs)
[blockSize, numBlocks] = size(xb);

% Apply hann window to blocks
hWin = repmat(hann(blockSize), 1, numBlocks);
xb = xb .* hWin;

% Compute magnitude spectrum of each block
xb = abs(fft(xb, blockSize, 1));
xb = xb(1:floor(blockSize/2)+1,:);

iNumCoeffs  = 40;

vmfcc       = zeros(iNumCoeffs, size(xb,2));

H           = ToolMfccFb(size(xb,1), fs);

T           = GenerateDctMatrix (size(H,1), iNumCoeffs);

for n = 1:size(xb,2)
        X_Mel       = log10(H * xb(:,n)+1e-20);
        vmfcc(:,n)  = T * X_Mel; 
end

end

%> see function mfcc.m from Slaneys Auditory Toolbox
function [T] = GenerateDctMatrix (iNumBands, iNumCepstralCoeffs)
    T       = cos((0:(iNumCepstralCoeffs-1))' * ...
				(2*(0:(iNumBands-1))+1) * pi/2/iNumBands);
            
    T       = T/sqrt(iNumBands/2);
    T(1,:)  = T(1,:) * sqrt(2)/2;
end