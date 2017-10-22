%% Get the music features
blockSize = 1024;
hopSize = 256;
music_path = '../wav_split/1/bending_up_down_half/';
featureMatrixMusic = getMetaData(music_path, blockSize, hopSize);

%% Normalize them
normalizedFeatures = zScoreNormalize(featureMatrixMusic);