function [psnr] = PSNR(f,g)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
psnr = 10*log10(1/mean2((f-g).^2));
end

