function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.
    load('traintest.mat');
    K = 250; %K-value
    alpha = 100; %Alpha Value
    filterBank  = createFilterBank();
     j = 1;
    % TODO Implement your code here
    %imPaths = dir('/Users/ashutoshahmadalexandar/Desktop/CVIP/HW1/release/data/');
    
    %Clustering the images using the alpha values
    for k = 1:length(train_imagenames)
        img = imread(strcat('/Users/ashutoshahmadalexandar/Desktop/CVIP/HW1/release/data/',train_imagenames{k}));
        
        if(size(img,3) == 1)
             img = repmat(img, [1 1 3]);
        end
        
        filtered_files = extractFilterResponses(img, filterBank);
        size_row = size(filtered_files, 1);
        size_col = size(filtered_files, 2);
        %index_point = 1: (size_row * size_col);
        rand_row = randperm(size_row, alpha);
        rand_col = randperm(size_col, alpha);
        
        for m = 1:alpha
            index_responses(j,:) = filtered_files(rand_row(m), rand_col(m), :);
            j = j+1;
        end
        %[rand_row rand_col] = ind2sub((size_row*size_col), rand_points);
        %filtered_files_2 = filtered_files{rand_row, rand_col,:};
    end
    
    %making dictionary
   [~, dictionary] = kmeans(index_responses, K, 'EmptyAction', 'drop');
       dictionary = dictionary'; 
end
%aTx3F=zeros(a*total_image, 60);
