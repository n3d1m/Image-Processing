checker = rgb2gray(imread('checker.jpg'));
lena_gray = rgb2gray(imread(lena));

conv = [0; -1];

blah = conv2(checker, conv);

imshow(blah)

f3 = conv2(ones(1,3)/3,zeros(2,1));

blah2 = conv2(lena_gray,f3);

imshow(blah2)
