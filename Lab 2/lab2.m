lena = imread('lena1.tiff');
lena_gray = rgb2gray(lena);

%getting the range of intensities
intensity = double(lena_gray)/255;

%impulse functions
h1 = (1/6)*ones(1,6);
h2 = diff(h1);
h3 = [-1 1];

lena_h1 = conv2(intensity,h1);
lena_h2 = conv2(intensity,h2);  
lena_h3 = conv2(intensity,h3);

figure
subplot(2,2,1),imshow(intensity);
subplot(2,2,2),imshow(lena_h1);
subplot(2,2,3),imshow(lena_h2);
subplot(2,2,4),imshow(lena_h3);

% part 3

f = [0.3*ones(200,100) 0.7*ones(200,100)];
gaussian = imnoise(f,'gaussian',0,0.01);
salt_pepper = imnoise(f,'salt & pepper',0.05);
multiplicative = imnoise(f,'speckle',0.04);

figure
subplot(2,2,1),imshow(f);
subplot(2,2,2),imshow(gaussian);
subplot(2,2,3),imshow(salt_pepper);
subplot(2,2,4),imshow(multiplicative);

figure
subplot(2,1,1),imshow(gaussian);
subplot(2,1,2),imhist(gaussian); 

figure
subplot(2,1,1),imshow(salt_pepper);
subplot(2,1,2),imhist(salt_pepper); 

figure
subplot(2,1,1),imshow(multiplicative);
subplot(2,1,2),imhist(multiplicative); 

figure
imhist(f)

% part 4

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

% part 5

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

