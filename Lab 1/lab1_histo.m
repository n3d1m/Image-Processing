target = 'tire.tif';

% Initial image
tire = imread(target);
histo = imhist(tire);
figure;
subplot(1,2,1), imshow(tire);
subplot(1,2,2), imhist(tire);
% Question 6 -> report
% Question 7 -> report

%Negative of the image
tire_neg = 255 - tire;
figure;
subplot(1,2,1), imshow(tire_neg);
subplot(1,2,2), imhist(tire_neg);

%Verfiiy it worked
tire_neg2 = imcomplement(tire);
figure;
subplot(1,2,1), imshow(tire_neg2);
subplot(1,2,2), imhist(tire_neg2);
%Question 8 report

%Power-law transformations 
tire_05 = double(tire).^(0.5);
tire_05 = uint8(tire_05);
figure;
subplot(1,2,1), imshow(tire_05);
subplot(1,2,2), imhist(tire_05);

tire_13 = double(tire).^(1.3);
tire_13 = uint8(tire_13);
figure;
subplot(1,2,1), imshow(tire_13);
subplot(1,2,2), imhist(tire_13);

% Question 9 -> report
% Question 10 -> report
% Question 11 -> report

% Histogram equalization
tire_eq = histeq(tire);
figure;
subplot(1,2,1), imshow(tire_eq);
subplot(1,2,2), imhist(tire_eq);
% Question 12 -> report
% Question 13 -> report


