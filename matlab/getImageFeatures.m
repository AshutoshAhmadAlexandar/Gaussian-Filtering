function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
	
    %dictionarySize = size(dictionary, 2);
    h_object  = histogram(wordMap, dictionarySize);
    h = h_object.Values;
    h=h';
    h_normalize = h./norm(h,1);
    h = h_normalize;
	assert(numel(h) == dictionarySize);
end