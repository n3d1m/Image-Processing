f = [0.3*ones(200,100) 0.7*ones(200,100)];
gaussian = imnoise(f,'gaussian',0.01);
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
