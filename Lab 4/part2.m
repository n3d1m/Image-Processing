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
imshow(cman);
title('Cameraman - Original');
subplot(1,3,2);
imshow(cman_blur);
title('Cameraman - Disk Blur');
subplot(1,3,3);
imshow(cman_inv_blur);
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
psd = abs(fft2(cman_blur)).^2;
nsr = psd ./ 0.002;
hf = h_freq;
cman_wnr = deconvwnr(real(fft2(cman_blur_noise)),real(h_freq), 1./nsr);
cman_wnr = real(ifft2(fft2(cman_blur_noise).*conj(hf)./(abs(hf).^2 + 1/nsr2)));

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

% using a different estimate of the SNR
nsr2 = var(cman_blur(:)) / 0.002;
cman_wnr2 = deconvwnr(cman_blur_noise,h,1/nsr2);

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