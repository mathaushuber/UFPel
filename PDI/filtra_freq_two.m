function img_filtrada = filtra_freq_two(imagem, mascara)
%filtro passa-alta
I = im2double(imread(imagem));
y = fft2(I);
[l, c] = size(I);
distancia = distmat(l,c);
mascara = ones(l,c);
radius = 30;
ind = distancia <= radius;
mascara(ind) = 0;
a = 1, b = 1;
mascarad = double(a +(b.* mascara));
IMG_filt = mascarad .* y;
img_filtrada = real(ifft2(IMG_filt));
imshow(img_filtrada, []);
end