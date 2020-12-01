%% Section 3

% Question 8 and 9

peppers = imread('peppers.png');
C = makecform('srgb2lab');
im_lab = applycform(peppers,C);
% 
K = 2;
row = [55 200];
col = [155 400];
% K = 4;
% row = [55 130 200 280];
% col = [155 110 400 470];

% First reshape the a and b channels:

ab = double(im_lab(:,:,2:3)); % NOT im2double
m = size(ab,1);
n = size(ab,2);
ab = reshape(ab,m*n,2);

% Convert (r,c) indexing to 1D linear indexing.
idx = sub2ind([size(peppers,1) size(peppers,2)], row, col);

% Vectorize starting coordinates
for k = 1:K
    mu(k,:) = ab(idx(k),:);
end

cluster_idx = kmeans(ab, K, 'Start', mu); 

% Label each pixel according to k-means
pixel_labels = reshape(cluster_idx, m, n);
figure
imshow(pixel_labels, [])
title('Image labeled by cluster index')
colormap('jet')

% Question 10

colors = 0:K;
ori_label = repmat(pixel_labels,[1 1 3]);
segmented_colours = zeros([size(peppers), K],'uint8');

for count = 1:K+1
  color = peppers;
  color(ori_label ~= colors(count)) = 0;
  segmented_colours(:,:,:,count) = color;
end 

montage({segmented_colours(:,:,:,2),segmented_colours(:,:,:,3)}) ...
    %segmented_colours(:,:,:,4),segmented_colours(:,:,:,5)});
title("Montage of Purple and Other Coulour Segments")
