target = im2double(imread('degraded.tif'));

figure
imshow(target);
title('Degraded Image');
rect = getrect;
xmin = rect(1);
ymin = rect(2);
width = rect(3);
height = rect(4);
smooth = target(ymin:ymin+height,xmin:xmin+width);
figure
imshow(smooth);
title('Smooth Patch');
noise_var = var(smooth(:));