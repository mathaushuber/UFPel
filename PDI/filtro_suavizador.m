function imagem_suavizada = filtro_suavizador(imagem)
IMG = imread(imagem);
mascara = [ 1, 2, 1; 2, 4, 2; 1, 2, 1]*1/16;
y = filter2(mascara, IMG, 'full');
mesh(y);
figure(1), imshow(uint8(IMG)), title('Imagem original');
figure(2), imshow(uint8(y)), title('Imagem suavizada');
end