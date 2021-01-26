function resultante = canaisrgb(imagem)
I = imread(imagem);
canalR = I(:,:,1);
canalG = I(:,:,2);
canalB = I(:,:,3);
mat1r = canalR*0;
mat1b  = canalB*0;
mat1g = canalG*0;
subplot(2,2,1), imshow(canalR), title ('Canal R');
subplot(2,2,2), imshow(canalG), title ('Canal G');
subplot(2,2,3), imshow(canalB), title ('Canal B');
resultantered = cat(3, canalR, mat1g, mat1b);
figure; imshow(resultantered);
resultantegreen = cat(3, mat1r, canalG, mat1b);
figure; imshow(resultantegreen);
resultanteblue = cat(3, mat1r, mat1g, canalB);
figure; imshow(resultanteblue);

end