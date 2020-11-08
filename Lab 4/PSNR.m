function [psnr] = PSNR(f,g)
%PSNR calculates the PSNR of two normalized images
%   f = reference image
%   g = noisy image
psnr = 10*log10(1/mean2((f-g).^2));
end

