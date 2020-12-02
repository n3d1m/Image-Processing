T = dctmtx(8);
f = double(rgb2gray(imread('lena3.tiff')));

% figure
% plot(T(1,:))
% hold on
% plot(T(2,:))
% hold on
% plot(T(3,:))
% hold on
% plot(T(4,:))
% hold on
% plot(T(5,:))
% hold on
% plot(T(6,:))
% hold on
% plot(T(7,:))
% hold on
% plot(T(8,:))
% legend('row 1','row 2', 'row 3', 'row 4', 'row 5', 'row 6', 'row 7', 'row 8')

dct = @(block_struct) T * block_struct.data * T';
f_trans = blockproc(f-128,[8 8],dct);

DCT_1 = f_trans(81:88,296:303);
DCT_2 = f_trans(1:8,1:8);

% figure
% imshow(abs(DCT_1),[])

% figure
% imshow(abs(DCT_2),[])

mask = zeros(8,8);
mask(1,1) = 1;
mask(1,2) = 1;
mask(1,3) = 1;
mask(2,1) = 1;
mask(3,1) = 1;
mask(2,2) = 1;

F_thresh = blockproc(f_trans,[8 8],@(block_struct) mask .* block_struct.data);
inverse_dtc = @(block_struct) T' * block_struct.data * T;
image_2 = blockproc(F_thresh,[8 8],inverse_dtc) + 128;

peaksnr = psnr(rescale(f),rescale(image_2));

figure
imshow(image_2, [])