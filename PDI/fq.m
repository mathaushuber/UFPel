figura = 'lena_cinza.bmp';
I = imread(figura);
[lin, col] = size(I);
y = fft2(I);
figure; imshow(log(abs(y)), []);
sy = fftshift(y);
figure; imshow(log(abs(sy)), []);
trans_inv = ifft2(y);
figure(3), imshow(trans_inv, []);