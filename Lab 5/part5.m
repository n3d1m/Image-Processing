z = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62; 18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92; 49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];
f = double(rgb2gray(imread('lena3.tiff')));

T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
f_trans = blockproc(f-128,[8 8],dct);

q = @(block_struct)(block_struct.data) ./ z;
f_trans_2 = blockproc(f_trans,[8 8],q);
f_trans_2 = round(f_trans_2);

f_trans_3 = blockproc(f_trans_2,[8 8],@(block_struct) z .* block_struct.data);
inverse_dtc = @(block_struct) round(T' * block_struct.data * T);
image2 = blockproc(f_trans_3,[8 8],inverse_dtc) + 128;

figure
imshow(f,[])

figure
imshow(image2,[])

peaksnr = psnr(rescale(f),rescale(image2));