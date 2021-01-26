function imagem_suavizada = filtro_realce(imagem)
IMG = imread(imagem);
mascara = [ 0, 1, 0; 1, -4, 1; 0, 1, 0];
y = filter2(mascara, IMG, 'full');
mesh(y);
figure(1), imshow(uint8(IMG)), title('Imagem original');
figure(2), imshow(uint8(y)), title('Imagem realçada');
end