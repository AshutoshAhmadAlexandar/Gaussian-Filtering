function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features

    % Get filterBank
    filterBank = createFilterBank(); 
    dictionarySize = size(dictionary,2);
    layerNum = 2;
    K = 250;
    train_H = K*(4^3-1)/3;
    train_length = length(train_imagenames);
    train_features = zeros(train_H, train_length);
    for i=1:length(train_imagenames)
    %i=1;
        wordMap2 = load(strrep(strcat('../data/',train_imagenames{i}),'.jpg','.mat'));
        wordMap = wordMap2.wordMap;
        train_features(:,i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
    end
    
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end