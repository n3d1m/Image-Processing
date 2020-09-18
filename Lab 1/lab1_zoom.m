%Lab 1

%Image Quality Measures

%example useage of the PSNR function
lena_normal = imread('lena.tiff');
lena_noise = imnoise(lena_normal,'gaussian',0.05);

%figure(1)
%imshow(lena_normal);

%figure(2)
%imshow(lena_noise);

PNSR_out = PSNR(lena_normal,lena_noise);

%Digital Zooming

%loading the original images in
lena = imread('lena.tiff');
cameraman = imread('cameraman.tif');

%converting to grey (cameraman has no rgb values)
lena_gray = rgb2gray(lena);

%resizing using bilinear interpolation
lena_resize = imresize(lena_gray,0.25,'bilinear');
cameraman_resize = imresize(cameraman,0.25,'bilinear');

%comparing grayscale images to reduced resolution ones
figure;
subplot(2,2,1),imshow(lena_gray);
subplot(2,2,2),imshow(cameraman);
subplot(2,2,3),imshow(lena_resize);
subplot(2,2,4),imshow(cameraman_resize);

%Increasing resolution using nearest neighbour interpolation
lena_nn = imresize(lena_resize,4,'nearest');
cameraman_nn = imresize(cameraman_resize,4,'nearest');

figure;
subplot(1,2,1), imshow(lena_nn);
subplot(1,2,2), imshow(cameraman_nn);

lena_nn_PSNR = PSNR(lena_gray,lena_nn);
cameraman_nn_PSNR = PSNR(cameraman,cameraman_nn);

%Increasing resolution using nearest bilinear interpolation
lena_bilinear = imresize(lena_resize,4,'bilinear');
cameraman_bilinear = imresize(cameraman_resize,4,'bilinear');

figure;
subplot(1,2,1), imshow(lena_bilinear);
subplot(1,2,2), imshow(cameraman_bilinear);

lena_bilinear_PSNR = PSNR(lena_gray,lena_bilinear);
cameraman_bilinear_PSNR = PSNR(cameraman,cameraman_bilinear);

%Increasing resolution using nearest bicubic interpolation
lena_bicubic = imresize(lena_resize,4,'bicubic');
cameraman_bicubic = imresize(cameraman_resize,4,'bicubic');

figure;
subplot(1,2,1), imshow(lena_bicubic);
subplot(1,2,2), imshow(cameraman_bicubic);

lena_bicubic_PSNR = PSNR(lena_gray,lena_bicubic);
cameraman_bicubic_PSNR = PSNR(cameraman,cameraman_bicubic);

