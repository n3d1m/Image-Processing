function f = Lee_filter(R,n,sz)
% R = reference image
% n = noise_var
% sz = size of filter

% Calculate local mean and variance 
local_mean = colfilt(R, sz, 'sliding', @mean);
local_var = colfilt(R, sz, 'sliding', @var);

K = (local_var - n)./local_var;
f = K.*R + (1-K).*local_mean; 
end