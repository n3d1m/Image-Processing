freq_noise = im2double(imread('frequnoisy.tif'));
F=fftshift(fft2(freq_noise)); %frequency spectrum 
amplitude = log(abs(F)); %amplitude spectrum

figure
imshow(freq_noise)

figure
imshow(amplitude,[])

%coordinates of noise locations were viewed by inspecting the figure
peakCoordsX = [65 105 129 153 193]; 
peakCoordsY = [65 119 129 139 193];

for i=1:length(peakCoordsX)
    xIndex = peakCoordsX(i);
    yIndex = peakCoordsY(i);
    
    amplitude(yIndex,xIndex) = 0; %this is just to diplay a figure with zero noise
    F(yIndex,xIndex) = 0; %set the x and y index to 0 in the original fourier transfer matrix
end

figure
imshow(amplitude,[]);

filteredImage = ifft2(fftshift(F)); %inverse shift and fourier transform

figure
imshow(filteredImage, []) %clean image
