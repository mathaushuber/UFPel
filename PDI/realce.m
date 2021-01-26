function imagem_realcada = realce(imagem)
IMG = imread(imagem);
plan = double(IMG(:,:,1));
tam = size(IMG);
arc = plan*0;
mascara = [ 0, 1, 0; 1, -4, 1; 0, 1, 0];
for i = 2: tam(1) - 1
    for j = 2: tam(2) - 1
        janela = plan(i - 1: i + 1, j - 1: j + 1);
        prod = janela .* mascara;
        result = sum(sum(prod));
        arc(i,j) = result;
    end
end
figure(1), imshow(uint8(IMG)), title('Imagem original');
figure(2), imshow(uint8(arc)), title('Imagem realçada');
end