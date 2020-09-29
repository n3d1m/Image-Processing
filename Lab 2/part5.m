cameraman = imread('cameraman.tif');
intensity = double(cameraman)/255;
gaussian = imgaussfilt(intensity,1,'FilterSize',7);

subtracted_image = intensity - gaussian;

figure
subplot(2,1,1), imshow(gaussian);
subplot(2,1,2), imshow(subtracted_image);

added_image = intensity + subtracted_image;

figure
subplot(2,1,1),imshow(intensity);
subplot(2,1,2),imshow(added_image);

multiplied_image = (subtracted_image*0.5) + intensity;

figure
subplot(2,1,1),imshow(intensity);
subplot(2,1,2),imshow(multiplied_image);

