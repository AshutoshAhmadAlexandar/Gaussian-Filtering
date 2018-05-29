function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
img = imread('/Users/ashutoshahmadalexandar/Desktop/stop_1333394828.avi_image20.png');
filterBank = createFilterBank();

%If image is greyscale
if(size(img,3) == 1)
    img = repmat(img, [1 1 3]);
end

%converting to double
img_Double = double(img);

%converting RGB images to LAB images
img_new = RGB2Lab(img_Double);
filterBank = createFilterBank();
%   filterBank:         a cell array of N filters
%figure, imshow(filteredImage)
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses
% TODO Implement your code here
filterResponses= [];
for i = 1:20
    filteredImage = imfilter(img_new, filterBank{i, 1});
    filterResponses_2(:,:,:,i) = filteredImage; %filterResponses_2 is a 4D matrix for montage
    filterResponses = cat(3, filteredImage, filterResponses); %used to include 20 different matrix of 3 different filters to make it total of 60 matrices
end

%montage(filterResponses_2, 'Size', [4 5]);
%imshow(img_montage);
