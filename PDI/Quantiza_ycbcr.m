function result = Quantiza_ycbcr(entrada, saida, bitsY, bitsCb, bitsCr)
I = imread(entrada);
I2 = rgb2ycbcr(I);
canalY = I2(:,:,1);
canalCb = I2(:,:,2);
canalCr = I2(:,:,3);
Y_bits = 256/2^bitsY;
Cb_bits = 256/2^bitsCb;
Cr_bits = 256/2^bitsCr;
subplot(3,2,1), imshow(canalY), title ('Canal Y');
canalY2 = floor(canalY/Y_bits)*Y_bits+Y_bits/2;
subplot(3,2,2), imshow(canalY2), title ('Canal Y modificado');
subplot(3,2,3), imshow(canalCb), title ('Canal Cb');
canalCb2 = floor(canalCb/Cb_bits)*Cb_bits+Cb_bits/2;
subplot(3,2,4), imshow(canalCb2), title ('Canal Cb modificado');
subplot(3,2,5), imshow(canalCr), title ('Canal Cr');
canalCr2 = floor(canalCr/Cr_bits)*Cr_bits+Cr_bits/2;
subplot(3,2,6), imshow(canalCr2), title ('Canal Cr modificado');
result = cat(3, canalY, canalCb, canalCr);
convert_img = ycbcr2rgb(result);
imwrite(convert_img, saida);
figure; imshow(convert_img);
end