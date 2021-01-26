function result = Quantiza(entrada, saida, bitsR, bitsG, bitsB)
I = imread(entrada);
canalR = I(:,:,1);
canalG = I(:,:,2);
canalB = I(:,:,3);

result_bitsR = 256/2^bitsR;
result_bitsG = 256/2^bitsG;
result_bitsB = 256/2^bitsB;
subplot(3,2,1), imshow(canalR), title ('Canal R');
canalR2 = floor(canalR/result_bitsR)*result_bitsR+result_bitsR/2;
subplot(3,2,2), imshow(canalR2), title ('Canal R modificado');
subplot(3,2,3), imshow(canalG), title ('Canal G');
canalG2 = floor(canalG/result_bitsG)*result_bitsG+result_bitsG/2;
subplot(3,2,4), imshow(canalG2), title ('Canal G modificado');
subplot(3,2,5), imshow(canalB), title ('Canal B');
canalB2 = floor(canalB/result_bitsB)*result_bitsB+result_bitsB/2;
subplot(3,2,6), imshow(canalB2), title ('Canal B modificado');
resulta = cat(3, canalR2, canalG2, canalB2);
imwrite(resulta, saida);
figure; imshowpair(I, resulta, 'montage');
end