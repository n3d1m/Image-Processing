%% Section 2

% Questions 1 && 2
peppers = im2double(imread('peppers.png'));
peppers_ycbcr = rgb2ycbcr(peppers); 
pep_y = peppers_ycbcr(:,:,1);
pep_cb = peppers_ycbcr(:,:,2);
pep_cr = peppers_ycbcr(:,:,3);

% plots
figure
subplot(2,2,1)
imshow(peppers_ycbcr); 
title('Original YCbCr')

subplot(2,2,2)
imshow(pep_y)
title('Y channel')

subplot(2,2,3)
imshow(pep_cb)
title('Cb channel')

subplot(2,2,4)
imshow(pep_cr)
title('Cr channel')

% Questions 3 && 4 

pep_cb2 = imresize(pep_cb, 0.5);
pep_cr2 = imresize(pep_cr, 0.5);
pep_cbUP = imresize(pep_cb2, 2,'bilinear');
pep_crUP = imresize(pep_cr2, 2,'bilinear');

chroma_pep = cat(3, pep_y, pep_cbUP, pep_crUP);

figure
subplot(1,2,1)
imshow(peppers)
title('Original')

subplot(1,2,2)
imshow(ycbcr2rgb(chroma_pep))
title('Chroma Sub-sampling')

% Questions 5, 6 && 7 

pep_y2 = imresize(pep_y,0.5);
pep_yUP = imresize(pep_y2, 2,'bilinear');

y_pep = cat(3, pep_yUP, pep_cb, pep_cr);

figure
subplot(1,2,1)
imshow(peppers)
title('Original')

subplot(1,2,2)
imshow(ycbcr2rgb(y_pep))
title('Luma Sub-sampling')

gray_pep = rgb2gray(peppers);
gray_chroma = rgb2gray(ycbcr2rgb(chroma_pep));
gray_y = rgb2gray(ycbcr2rgb(y_pep)); 

chroma_PSNR =psnr(gray_pep, gray_chroma);
y_PSNR =psnr(gray_pep, gray_y);
