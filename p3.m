clear all;
% Load the image
f = imread('RandomDisks-P10.jpg');
% Convert RGB image to grayscale image
g = rgb2gray(f);

% Apply median filter to grayscale image
med_image = medfilt2(g);

figure,imshow(g);
% figure,imshow(med_image);


gzero = zeros(size(g));
mean_image = mean5x5(g, gzero, size(g, 1), size(g,2));
figure,imshow(mean_image);