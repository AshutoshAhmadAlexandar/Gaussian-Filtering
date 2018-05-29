function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    
    conf = zeros(8,8);
    test_length = length(test_imagenames);
    %known_group = test_labels;
    %finding the predicted group
     for i = 1:test_length;
         predicted = guessImage(strcat('../data/',test_imagenames{i}));
         predicted_index = find(strcmp(predicted, mapping));
         predicted_labels(i) = predicted_index;
     end
     
     %predicted_labels = predicted_labels';
     %predicted_labels = cell2mat(predicted_labels);
     
     %creating confusion matrix with known and guess labels
     conf = confusionmat(test_labels, predicted_labels);

end