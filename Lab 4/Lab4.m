%% Section 2

h = fspecial('disk',4); % disk blur function
cman = im2double(imread('cameraman.tif'));
h_freq = fft2(h, size(cman,1), size(cman,2)); % padded FFT of h
cman_blur = real(ifft2(h_freq.*fft2(cman))); % applied padded blur in freq domain

%QUESTION 1
% PSNR calculation
cman_blur_PSNR = PSNR(cman,cman_blur);

% Inverse filtering
cman_inv_blur = real(ifft2(fft2(cman_blur)./h_freq));

% PSNR calculation
cman_inv_blur_PSNR = PSNR(cman,cman_inv_blur);

% Show images
figure
sgtitle({sprintf('Original vs Blur PSNR = %f', cman_blur_PSNR),
    sprintf('Original vs Inverse Blur PSNR = %f',cman_inv_blur_PSNR)});
subplot(1,3,1);
imshow(cman, []);
title('Cameraman - Original');
subplot(1,3,2);
imshow(cman_blur, []);
title('Cameraman - Disk Blur');
subplot(1,3,3);
imshow(cman_inv_blur, []);
title('Cameraman - Inverse Filter');

% QUESTIONS 2 and 3
cman_blur_noise = imnoise(cman_blur,'gaussian',0,0.002);
cman_inv_blur_noise = real(ifft2(fft2(cman_blur_noise)./h_freq));

% PSNR 
cman_blur_noise_PSNR = PSNR(cman,cman_blur_noise);
cman_inv_blur_noise_PSNR = PSNR(cman,cman_inv_blur_noise);

% Show images
figure
sgtitle({sprintf('Original vs Blur + Noise PSNR = %f', cman_blur_noise_PSNR),
    sprintf('Original vs Inverse Blur + Noise PSNR = %f',cman_inv_blur_noise_PSNR)});
subplot(1,3,1);
imshow(cman);
title('Cameraman - Original');
subplot(1,3,2);
imshow(cman_blur_noise);
title('Cameraman - Disk Blur + Noise');
subplot(1,3,3);
imshow(cman_inv_blur_noise);
title('Cameraman - Inverse Filter');

% QUESTIONS 4 and 5 - Wiener
%psd = abs((fftshift(fft2(cman))).^2);
nsr = var(cman_blur(:)) / 0.002;
cman_wnr = deconvwnr(cman_blur_noise,h, 1./nsr);

% PSNR 
cman_wnr_PSNR = PSNR(cman,cman_wnr);

% Show images
figure
sgtitle({sprintf('Original vs Blur + Noise PSNR = %f', cman_blur_noise_PSNR),
    sprintf('Original vs Weiner Deconv = %f',cman_wnr_PSNR)});
subplot(1,3,1);
imshow(cman);
title('Cameraman - Original');
subplot(1,3,2);
imshow(cman_blur_noise);
title('Cameraman - Disk Blur + Noise');
subplot(1,3,3);
imshow(cman_wnr);
title('Cameraman - Weiner Filter');

% Applying Weiner's equation directly
cman_wnr2 = real(ifft2(fft2(cman_blur_noise).*conj(h_freq)./(abs(h_freq).^2 + 1/nsr)));

% PSNR 
cman_wnr_PSNR2 = PSNR(cman,cman_wnr2);

% Show images
figure
sgtitle({sprintf('Original vs Blur + Noise PSNR = %f', cman_blur_noise_PSNR),
    sprintf('Original vs Weiner Deconv2 PSNR = %f',cman_wnr_PSNR2)});
subplot(1,3,1);
imshow(cman);
title('Cameraman - Original');
subplot(1,3,2);
imshow(cman_blur_noise);
title('Cameraman - Disk Blur + Noise');
subplot(1,3,3);
imshow(cman_wnr2);
title('Cameraman - Weiner Filter 2');

%% Section 3

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

filter_size = [5,5];
lee_filter_1 = Lee_filter(target, noise_var, filter_size);

% PSNR calculation
cman_degredaded_PSNR = PSNR(cman,target);
cman_lee_PSNR = PSNR(cman, lee_filter_1);

% Show images
figure
sgtitle({sprintf('Original vs Lee Filter PSNR = %f', cman_lee_PSNR)});
subplot(1,2,1);
imshow(cman);
title('Cameraman - Original');
subplot(1,2,2);
imshow(lee_filter_1);
title('Cameraman - Denoised');

% Question 7 
target_freq = fftshift(fft2(target));
gaussFilt = fspecial('gaussian',[256 256], 30);
maxValue = max(max(gaussFilt));
minValue = min(gaussFilt(:));
norm = double(gaussFilt) / maxValue;
gauss = target_freq.*norm;
gauss_filter = real(ifft2(fftshift(gauss)));

%PSNR
cman_gauss_PSNR = PSNR(cman, gauss_filter);

figure
sgtitle({sprintf('Original vs Gauss Filter PSNR = %f', cman_gauss_PSNR)});
imshow(gauss_filter);
title('Cameraman - Low-Pass Gaus Filter');

% Question 8

noise_var_2 = 0.009;
noise_var_3 = 0.011; 

lee_filter_2 = Lee_filter(target, noise_var_2, filter_size);
lee_filter_3 = Lee_filter(target, noise_var_3, filter_size);

% PSNR calculation
cman_lee2_PSNR = PSNR(cman, lee_filter_2);
cman_lee3_PSNR = PSNR(cman, lee_filter_3);

% Show images
figure
sgtitle({sprintf('Lower Var PSNR = %f', cman_lee2_PSNR),...
        sprintf('Higher Var PSNR = %f', cman_lee3_PSNR)});
subplot(1,3,1);
imshow(cman);
title('Original');
subplot(1,3,2);
imshow(lee_filter_2);
title('Denoised - Lower Var');
subplot(1,3,3);
imshow(lee_filter_3);
title('Denoised - Higher Var');

% Question 9 

lee_filter_4 = Lee_filter(target, noise_var, [4,4]);
lee_filter_5 = Lee_filter(target, noise_var, [10,10]);

% PSNR calculation
cman_lee4_PSNR = PSNR(cman, lee_filter_4);
cman_lee5_PSNR = PSNR(cman, lee_filter_5);

% Show images
figure
sgtitle({sprintf('4x4 PSNR = %f', cman_lee4_PSNR),...
        sprintf('10x10 PSNR = %f', cman_lee5_PSNR)});
subplot(1,3,1);
imshow(cman);
title('Original');
subplot(1,3,2);
imshow(lee_filter_2);
title('Denoised - 4x4');
subplot(1,3,3);
imshow(lee_filter_3);
title('Denoised - 10x10');