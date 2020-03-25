%%
clear all;
% Load the image
f = imread('RandomDisks-P10.jpg');
% Convert RGB image to grayscale image
g = rgb2gray(f);
figure('Name',"Original Grayscale image"),imshow(g);

%% Apply built-in median filter on grayscale image
% 1 Iteration
med_image = medfilt2(g, [5,5]);
figure('Name',"5x5 Median filter result (1 iteration)"),imshow(med_image);

% 5 Iterations
for i = 1:4
    med_image = medfilt2(med_image, [5,5]);
end
figure('Name',"5x5 Median filter result (5 iterations)"),imshow(med_image);

%% Apply 5x5 mean filter on grayscale image
gzero = zeros(size(g));
% 1 Iteration
mean_image = mean5x5(g, gzero, size(g, 1), size(g,2));
figure('Name',"5x5 Mean filter result (1 iteration)"),imshow(mean_image);

% 5 Iterations
for i = 1:4
    mean_image = mean5x5(mean_image, gzero, size(g, 1), size(g,2));
end
figure('Name',"5x5 Mean filter result (5 iterations)"),imshow(mean_image);