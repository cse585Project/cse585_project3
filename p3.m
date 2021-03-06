%%
clear all;
% Load the image
f = imread('disk.gif');
figure('Name',"Original Grayscale image"),imshow(f);

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
figure('Name',"Histogram for 5x5 meann filter result"), histogram(mean_image, 256);
% get the sub-region for calculation
sub_region = mean_image(50:181,30:155);
disk = reshape(sub_region, [], 1);
% use the threhold to get the interior of the large disk we want
rowsToDelete = disk < 115; % 115 is the threhold
disk(rowsToDelete) = [];
% mean and std of the the interior of the large disk region
mean_large_disk = mean(disk);
std_large_disk = std(double(disk));
%% Apply built-in median filter on grayscale image
% 1 Iteration
med_image = medfilt2(f, [5,5]);
figure('Name',"5x5 Median filter result (1 iteration)"),imshow(med_image);
% 5 Iterations
for i = 1:4
    med_image = medfilt2(med_image, [5,5]);
end
figure('Name',"5x5 Median filter result (5 iterations)"),imshow(med_image);
figure('Name',"Histogram for 5x5 median filter result"), histogram(med_image, 256);
% get the sub-region for calculation
sub_region = med_image(50:181,30:155);
disk = reshape(sub_region, [], 1);
% use the threhold to get the interior of the large disk we want
rowsToDelete = disk < 115; % 115 is the threhold
disk(rowsToDelete) = [];
% mean and std of the the interior of the large disk region
mean_large_disk = mean(disk);
std_large_disk = std(double(disk));
%% 5x5 alpha-trimmed mean filter (alpha = 0.25)
% 1 Iteration
alpha_image = alpha5x5(f, 0.25);
figure('Name',"5x5 alpha-trimmed mean filter result with alpha 0.25 (1 iteration)"),imshow(alpha_image);

% 5 Iterations
for i = 1:4
   alpha_image = alpha5x5(alpha_image, 0.25);
end
figure('Name',"5x5 alpha-trimmed mean filter result with alpha 0.25 (5 iterations)"),imshow(alpha_image);
figure('Name',"Histogram for 5x5 alpha-trimmed mean filter result with alpha 0.25"), histogram(alpha_image,256);
% get the sub-region for calculation
sub_region = alpha_image(50:181,30:155);
disk = reshape(sub_region, [], 1);
% use the threhold to get the interior of the large disk we want
rowsToDelete = disk < 115; % 115 is the threhold
disk(rowsToDelete) = [];
% mean and std of the the interior of the large disk region
mean_large_disk = mean(disk);
std_large_disk = std(double(disk));
%% 5x5 sigma filter (sigma = 20)
% 1 Iteration
sigma_image = sigma5x5(f, 20);
figure('Name',"5x5 sigma filter result with sigma 20 (1 iteration)"),imshow(sigma_image);

% 5 Iterations
for i = 1:4
   sigma_image = sigma5x5(sigma_image, 20);
end
figure('Name',"5x5 sigma filter result with sigma 20 (5 iterations)"),imshow(sigma_image);
figure('Name',"Histogram for 5x5 sigma filter result with sigma 20"), histogram(sigma_image,256);

% get the sub-region for calculation
sub_region = sigma_image(50:181,30:155);
disk = reshape(sub_region, [], 1);
% use the threhold to get the interior of the large disk we want
rowsToDelete = disk < 115; % 115 is the threhold
disk(rowsToDelete) = [];
% mean and std of the the interior of the large disk region
mean_large_disk = mean(disk);
std_large_disk = std(double(disk));

%% SNN filter 
% 1 Iteration
SNN_image = SNNmean(f);
figure('Name','5x5 SNN filter result(1 iteration)'),imshow(SNN_image);
% 5 Iterations
for i = 1:4
   SNN_image = sigma5x5(SNN_image, 20);
end
figure('Name',"5x5 SNN filter result(5 iterations)"),imshow(SNN_image);
figure('Name',"Histogram for 5x5 SNN filter result"), histogram(SNN_image,256);

% get the sub-region for calculation
sub_region = SNN_image(50:181,30:155);
disk = reshape(sub_region, [], 1);
% use the threhold to get the interior of the large disk we want
rowsToDelete = disk < 115; % 115 is the threhold
disk(rowsToDelete) = [];
% mean and std of the the interior of the large disk region
mean_large_disk = mean(disk);
std_large_disk = std(double(disk));
%% Anisotropic Diffusion
% part (a)
% K=30, g(.)=exp
img = imread('cwheelnoise.gif');
figure();
subplot(4,4,1);
imshow(img);
title('original image');

subplot(4,4,2);
histogram(img,256);
title('histogram on original image');

subplot(4,4,3);
plot((1:256),img(:,128).','-');
title('plot y=128 of original image');

tmp = img;
tmp((tmp>=80) & (tmp<=110))=0;
tmp(((0<tmp)&(tmp<80)) | (tmp>110))=255;
subplot(4,4,4);
imshow(tmp);
title('spoke of original image');


res1 = anisotopicdiff(img,5,30,2);
subplot(4,4,5);
imshow(res1);
title('image after 5 iteration');

subplot(4,4,6);
histogram(res1,256);
title('histogram after 5 iteration');

subplot(4,4,7);
plot((1:256),res1(:,128).','-');
title('plot y=128 after 5 iteration');

tmp = res1;
tmp((tmp>=80) & (tmp<=110))=0;
tmp(((0<tmp)&(tmp<80)) | (tmp>110))=255;
subplot(4,4,8);
imshow(tmp);
title('spoke of image after 5 iteration');


res2 = anisotopicdiff(img,20,30,2);
subplot(4,4,9);
imshow(res2);
title('image after 20 iteration');

subplot(4,4,10);
histogram(res2,256);
title('histogram after 20 iteration');

subplot(4,4,11);
plot((1:256),res2(:,128).','-');
title('plot y=128 after 20 iteration');

tmp = res2;
tmp((tmp>=80) & (tmp<=110))=0;
tmp(((0<tmp)&(tmp<80)) | (tmp>110))=255;
subplot(4,4,12);
imshow(tmp);
title('spoke of image after 20 iteration');


res3 = anisotopicdiff(img,100,30,2);
subplot(4,4,13);
imshow(res3);
title('image after 100 iteration');

subplot(4,4,14);
histogram(res3,256);
title('histogram after 100 iteration');

subplot(4,4,15);
plot((1:256),res3(:,128).','-');
title('plot y=128 after 100 iteration');

tmp = res3;
tmp((tmp>=80) & (tmp<=100))=0;
tmp(((0<tmp)&(tmp<80)) | (tmp>100))=255;
subplot(4,4,16);
imshow(tmp);
title('spoke of image after 100 iteration');

% part (b)
% K=30, g(.)=exp
img = imread('cameraman.tif');
figure();
subplot(2,2,1);
imshow(img);
title('original image');
res1 = anisotopicdiff(img,5,20,1);
subplot(2,2,2);
imshow(res1);
title('image after 5 iteration');
res2 = anisotopicdiff(img,20,20,1);
subplot(2,2,3);
imshow(res2);
title('image after 20 iteration');
res3 = anisotopicdiff(img,100,20,1);
subplot(2,2,4);
imshow(res3);
title('image after 100 iteration');





