clc
clear all
close all
warning off

% test image: white rectangle in black background
f = zeros(256,256);
f(:,108:148)=1;
F2 = fft2(f);
FS = fftshift(F2);

figure,
subplot(1,2,1), imshow(f) ;
subplot(1,2,2), imshow(abs(FS), []);


% rotated image by 45 degrees
f_rotated = imrotate(f, 45);
F2_r = fft2(f_rotated);
FS_r = fftshift(F2_r);

figure,
subplot(1,2,1), imshow(f_rotated) ;
subplot(1,2,2), imshow(abs(FS_r), []);

% phase and amplitude contribution to lena image
lena = imread('lena.tiff');
lena = rgb2gray(lena); 
lena_F = fft2(lena);

amp = abs(lena_F);
phase = lena_F ./ amp; 

figure
subplot(1,3,1), imshow(lena);
subplot(1,3,2), imshow(log(amp), []);
subplot(1,3,3), imshow(log(phase), []);

figure
subplot(1,3,1), imshow(lena);
subplot(1,3,2), imshow(log(ifft2(amp)), []);
subplot(1,3,3), imshow(log(ifft2(phase)), []);