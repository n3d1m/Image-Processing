lena = rescale(rgb2gray(imread('lena.tiff')));
lena_noise = imnoise(lena,'gaussian',0,0.005);

lena_freq= fftshift(fft2(lena));
abs_clean = log(abs(lena_freq));

lena_noise_freq = fftshift(fft2(lena_noise));
abs_noise = log(abs(lena_noise_freq));

figure
subplot(1,2,1)
imshow(lena);
title('Clean Image');

subplot(1,2,2)
imshow(lena_noise);
title('Noisy Image');

figure
subplot(1,2,1);
imshow(abs_clean);
title('Fourier Transform of Clean Image');

subplot(1,2,2);
imshow(abs_noise);
title('Fourier Transform of Noisy Image');

r = 60;
h = fspecial('disk',r); 
h(h>0) = 1;
hfreq = zeros(512,512);
hfreq([[512]/2-r:[512]/2+r],[[512]/2-r:[512]/2+r])=h;

hfreq_transform = fftshift(fft2(hfreq));
abs_hfreq = log(abs(hfreq_transform));

figure
imshow(abs_hfreq);

filter = lena_noise_freq.*hfreq;
filteredImage = real(ifft2(fftshift(filter)));

figure
imshow(filteredImage,[]);

gaussFilt = fspecial('gaussian',[512 512], 60);
maxValue = max(max(gaussFilt));
minValue = min(gaussFilt(:));
normalization = double(gaussFilt) / maxValue;

filter2 = lena_noise_freq.*normalization;
filteredImage2 = real(ifft2(fftshift(filter2)));

figure
imshow(filteredImage2,[]);

[peaksnr,snr] = psnr(filteredImage2,lena);



