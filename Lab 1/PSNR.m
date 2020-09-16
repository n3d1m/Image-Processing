function [PSNR_out] = PSNR(image_1,image_2)
%Calculates the PSNR between two images
MAX_f = 255;
MSE = sum((image_1(:) - image_2(:)).^2) / numel(image_1);
PSNR_out = 10*log10(power(MAX_f,2)/MSE);

%outputArg1 = inputArg1;
%outputArg2 = inputArg2;
end

