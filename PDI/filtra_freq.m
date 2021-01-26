function img_filtrada = filtra_freq(imagem, mascara)
%filtro passa-baixa
I = imread(imagem);
Id = im2double(I);
y = fft2(Id);
[l,c] = size(I);
sy = fftshift(y);
imwrite(sy, 'nova_imagem.png');
novaimg = 'nova_imagem.png';
figure; imshow(log(abs(sy)), []);
distancia = distmat(l,c);
mascara = zeros(l,c);
radius = 35;
ind = distancia <= radius;
mascara(ind) = 1;
mascarad = double(mascara);
IMG_filt = mascarad .* y;
img_filtrada = real(ifft2(IMG_filt));
figure; imshow(img_filtrada, []);
end