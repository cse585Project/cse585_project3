%%%%%%%%%%%%%  Function alpha5x5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute a 5X5 alpha-trimmed mean filter at each pixel 
%           in an image 
%
% Input Variables:
%      f       MxN input 2D gray-scale image to be filtered
%      x       x coordinate of a pixel
%      y       y coordinate of a pixel
%      alp     alpha value
%      
% Returned Results:
%     alpha     new image cantaining the filtered results
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [alpha] = alpha5x5(f,alp)

%  Fill the output image with zeroes first
%  (Step below is admittedly very cumbersome!)
alpha = zeros(size(f));
alpha = uint16(alpha);
% Convert f to a 16-bit number, so we can do  sums > 255 correctly
g = uint16(f);

n = 25;     %window length
alpha_n = floor(n*alp);
head = alpha_n + 1;
tail = n - alpha_n;

% Define the coordinate limits for pixels that can be properly
%     processed by the 5X5 filter
for i = head:tail
    alpha = ordfilt2(g,i,ones(5,5)) + alpha;
end
alpha = alpha / (n - 2 * alpha_n);

alpha = uint8(alpha);