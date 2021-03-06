target = 'lena1.tiff';
lena = imread(target);
lena = rgb2gray(lena);
lena = im2double(lena);
figure;
subplot(1,2,1), imshow(lena);
subplot(1,2,2), imhist(lena);

% add noise - zero mean gaussian with 0.002 variance
lena_noise = imnoise(lena,'gaussian',0,0.002);
figure;
subplot(1,2,1), imshow(lena_noise);
subplot(1,2,2), imhist(lena_noise);

% PSNR
noise_psnr = PSNR(lena,lena_noise);

% Average filter method 
% 3 by 3
filter33 = fspecial('average',3);
figure;
imagesc(filter33);
colormap(gray);

lena_denoised = imfilter(lena_noise,filter33);
figure;
subplot(1,2,1), imshow(lena_denoised);
subplot(1,2,2), imhist(lena_denoised);
denoised_psnr = PSNR(lena,lena_denoised);

% 7 by 7
filter77 = fspecial('average',7);
lena_denoised = imfilter(lena_noise,filter77);
figure;
subplot(1,2,1), imshow(lena_denoised);
subplot(1,2,2), imhist(lena_denoised);
denoised_psnr2 = PSNR(lena,lena_denoised);

% Gaussian
lena_denoised = imgaussfilt(lena_noise,1,'FilterSize',7);
figure;
subplot(1,2,1), imshow(lena_denoised);
subplot(1,2,2), imhist(lena_denoised);
denoised_psnr3 = PSNR(lena,lena_denoised);

% verify
filterGaus = fspecial('gaussian',[7 7],1);
lena_denoised = imfilter(lena_noise,filterGaus);
figure;
subplot(1,2,1), imshow(lena_denoised);
subplot(1,2,2), imhist(lena_denoised);
denoised_psnr4 = PSNR(lena,lena_denoised);

figure;
imagesc(filterGaus);
colormap(gray);

% add noise -salt and pepper
lena_noiseSP = imnoise(lena,'salt & pepper');
figure;
subplot(1,2,1), imshow(lena_noiseSP);
subplot(1,2,2), imhist(lena_noiseSP);
noiseSP_psnr = PSNR(lena,lena_noiseSP);

% 7x7 avg
lena_denoisedSP = imfilter(lena_noiseSP,filter77);
figure;
subplot(1,2,1), imshow(lena_denoisedSP);
subplot(1,2,2), imhist(lena_denoisedSP);
denoisedSP_psnr = PSNR(lena,lena_denoisedSP);

% 7x7 Gauss
lena_denoisedSP = imgaussfilt(lena_noiseSP,1,'FilterSize',7);
figure;
subplot(1,2,1), imshow(lena_denoisedSP);
subplot(1,2,2), imhist(lena_denoisedSP);
denoisedSP_psnr2 = PSNR(lena,lena_denoisedSP);

% verify / compare
lena_denoisedSP = imfilter(lena_noiseSP,filterGaus);
figure;
subplot(1,2,1), imshow(lena_denoisedSP);
subplot(1,2,2), imhist(lena_denoisedSP);
denoisedSP_psnr3 = PSNR(lena,lena_denoisedSP);

% median filter
lena_denoisedSP = medfilt2(lena_noiseSP);
figure;
subplot(1,2,1), imshow(lena_denoisedSP);
subplot(1,2,2), imhist(lena_denoisedSP);
denoisedSP_psnr4 = PSNR(lena,lena_denoisedSP);
