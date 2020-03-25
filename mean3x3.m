%%%%%%%%%%%%%  Function mean3x3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute a 3X3 mean (neighborhood average) filter at each pixel 
%           in an image 
%
% Input Variables:
%      f       MxN input 2D gray-scale image to be filtered
%      fzero   MxN image full of zeroes
%      M, N    rows (M) and columns (N) in f
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      xlo, xhi, ylo, yhi   Limits on what can be processed by filter
%      
% Returned Results:
%     mean     new image cantaining the filtered results
%
% Processing Flow:
%      1.  Set a new image full of ZEROS
%      2.  For each valid pixel,
%             compute the mean of the 3x3 neighborhood about the
%             pixel and assign this value to the mean image
%
%  Restrictions/Notes:
%      This function takes an 8-bit image as input.  
%
%  The following functions are called:
%      none
%
%  Author:      William E. Higgins
%  Date:        1/7/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mean] = mean3x3(f,fzero,M,N)

%  Fill the output image with zeroes first
%  (Step below is admittedly very cumbersome!)

for x = 1 : M        
    for y = 1 : N    
        mean(x,y) = fzero(x,y);
    end
end

% Convert f to a 16-bit number, so we can do  sums > 255 correctly

g = uint16(f);

% Define the coordinate limits for pixels that can be properly
%     processed by the 3X3 filter

xlo = 2;   % Can't process first column
xhi = M-1; % Can't process last  column
ylo = 2;   % Can't process first row
yhi = N-1; % Can't process last  row

% Compute the filtered output image

for x = xlo : xhi        % Don't consider boundary pixels that can't
    for y = ylo : yhi    %    be processed!
        for i = -1 : 1
            for j = -1 : 1   
                mean(x,y) = g(x-i,y-j) + mean(x,y);
            end
        end
        mean(x,y) = mean(x,y) / 9.;
    end
end

% Convert back to an 8-bit image

mean = uint8(mean);