function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    
     %L = 2;

    L = layerNum + 1;

    H = size(wordMap, 1);

    W = size(wordMap, 2);

   % dictionarySize = size(dictionary,2);

    h2 = []; %initial level 2 histogram

    h1 = []; %initial level 1 histogram
    
    h0 = []; %initial level 0 histogram
    
    h = [];
    
    for n = 1:L

        if(n == 1)

            h_temp = getImageFeatures(wordMap,dictionarySize);
            weight = 0.5;
            h0 = [h0;weight*h_temp]; %final level 0 histogram

        else

            if(n == 2)

                col = [H/2, H/2];

                row = [W/2, W/2];

                if(mod(H,2) == 1)

                    col = [floor(H/2), ceil(H/2)];

                end

                if(mod(W,2) == 1)

                    row = [floor(W/2), ceil(W/2)];

                end

                C = mat2cell(wordMap, col, row);

            end

            if(n == 3)

                H_floor = floor(H/4);

                H_ceil  = ceil(H/4);

                col = [H/4, H/4, H/4, H/4];

                if(mod(H,4)==1)

                    col = [H_floor, H_floor,  H_floor, H_ceil];

                end

                if(mod(H,4)==2)

                    col = [H_floor, H_ceil, H_floor, H_ceil];

                end

                if(mod(H,4)==3)

                    col = [H_floor, H_ceil, H_ceil, H_ceil];

                end

                W_floor = floor(W/4);

                W_ceil  = ceil(W/4);

                row = [W/4, W/4, W/4, W/4];

                if(mod(W,4)==1)

                    row = [W_floor, W_floor, W_floor, W_ceil];

                end

                if(mod(W,4)==2)

                    row = [W_floor, W_ceil, W_floor, W_ceil];

                end

                if(mod(W,4)==3)

                    row = [W_floor, W_ceil,  W_ceil, W_ceil];

                end

                C = mat2cell(wordMap, col, row);

            end

            C_size = length(C);

            for i = 1:C_size

                for j = 1:C_size

                    cell = C{i,j};

                    h_temp = getImageFeatures(cell, dictionarySize);

                    if(n == 2)

                        weight = .5;

                        h1 = [h1; weight*h_temp]; %final level 1 histogram
                        %h1 = cat(2,h1,weight*h_temp);

                    end

                    if(n == 3)

                        weight = .25;

                        h2 = [h2; weight*h_temp]; %final level 2 histogram
                        %h2 = cat(2,h2,weight*h_temp);

                    end

                end

            end

        end
        
        h = [h0; h1; h2]; %concatenating the level 0,1,2 histograms
        h_normalize = h./norm(h,1);
        h = h_normalize;
    end
    
end