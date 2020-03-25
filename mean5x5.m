%%%%%%%%%%%%%  Function mean5x5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute a 5X5 mean (neighborhood average) filter at each pixel 
%           in an image 
%
% Input Variables:
%      f       MxN input 2D gray-scale image to be filtered
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      xlo, xhi, ylo, yhi   Limits on what can be processed by filter
%      
% Returned Results:
%     mean     new image cantaining the filtered results
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mean] = mean5x5(f)

%  Fill the output image with zeroes first
%  (Step below is admittedly very cumbersome!)
mean = zeros(size(f));

% Convert f to a 16-bit number, so we can do  sums > 255 correctly

g = uint16(f);

% Define the coordinate limits for pixels that can be properly
%     processed by the 5X5 filter

xlo = 3;   % Can't process first column
xhi = size(f,1)-2; % Can't process last  column
ylo = 3;   % Can't process first row
yhi = size(f,2)-2; % Can't process last  row

% Compute the filtered output image

for x = xlo : xhi        % Don't consider boundary pixels that can't
    for y = ylo : yhi    %    be processed!
        for i = -2 : 2
            for j = -2 : 2   
                mean(x,y) = g(x-i,y-j) + mean(x,y);
            end
        end
        mean(x,y) = mean(x,y) / 25.;
    end
end

% Convert back to an 8-bit image

mean = uint8(mean);