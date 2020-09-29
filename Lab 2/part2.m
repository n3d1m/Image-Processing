lena = imread('lena1.tiff');
lena_gray = rgb2gray(lena);

%getting the range of intensities
intensity = double(lena_gray)/255;

%impulse functions
h1 = (1/6)*ones(1,6);
h2 = diff(h1);
h3 = [-1 1];

lena_h1 = conv2(intensity,h1);
lena_h2 = conv2(intensity,h2);  
lena_h3 = conv2(intensity,h3);

figure
subplot(2,2,1),imshow(intensity);
subplot(2,2,2),imshow(lena_h1);
subplot(2,2,3),imshow(lena_h2);
subplot(2,2,4),imshow(lena_h3);

