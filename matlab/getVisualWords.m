function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here

    %img = imread('/Users/ashutoshahmadalexandar/Desktop/CVIP/HW1/release/matlab/mountain/sun_aeldkedqeopyedlo.jpg');
    filterBank = createFilterBank();
    filter_Responses = extractFilterResponses(img, filterBank);
    dict = dictionary';
    dim1 = size(filter_Responses, 2)*size(filter_Responses, 1);
    filter_Responses = reshape(filter_Responses,dim1,size(filter_Responses, 3)); 
    wordMap = pdist2(dict, filter_Responses, 'euclidean', 'smallest', 1); %creating wordMap by finding the minimum distance
    R = size(img,1);
    C = size(img,2);
    
    %in = in';
    wordMap = reshape(wordMap, R, C); %reshaping the WordMap from 3D to 2D matrix
  
    
end
