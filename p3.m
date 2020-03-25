%%
clear all;
% Load the image
f = imread('disk.gif');
figure('Name',"Original Grayscale image"),imshow(f);

%% Apply built-in median filter on grayscale image
% 1 Iteration
med_image = medfilt2(f, [5,5]);
figure('Name',"5x5 Median filter result (1 iteration)"),imshow(med_image);

% 5 Iterations
for i = 1:4
    med_image = medfilt2(med_image, [5,5]);
end
figure('Name',"5x5 Median filter result (5 iterations)"),imshow(med_image);

%% Apply 5x5 mean filter on grayscale image
fzero = zeros(size(f));
% 1 Iteration
mean_image = mean5x5(f);
figure('Name',"5x5 Mean filter result (1 iteration)"),imshow(mean_image);

% 5 Iterations
for i = 1:4
    mean_image = mean5x5(mean_image);
end
figure('Name',"5x5 Mean filter result (5 iterations)"),imshow(mean_image);

%% 5x5 sigma filter (sigma = 20)
% 1 Iteration
sigma_image = sigma5x5(f, 20);
figure('Name',"5x5 sigma filter result with sigma 20 (1 iteration)"),imshow(sigma_image);

% 5 Iterations
for i = 1:4
   sigma_image = sigma5x5(sigma_image, 20);
end
figure('Name',"5x5 sigma filter result with sigma 20 (5 iterations)"),imshow(sigma_image);
