function imagem_suavizada = suaviza(imagem)
IMG = imread(imagem);
plan = double(IMG(:,:,1));
tam = size(IMG);
arc = plan*0;
mascara = [ 1, 2, 1; 2, 4, 2; 1, 2, 1]*1/16;
for i = 2: tam(1) - 1
    for j = 2: tam(2) - 1
        janela = plan(i - 1: i + 1, j - 1: j + 1);
        prod = janela .* mascara;
        result = sum(sum(prod));
        arc(i,j) = result;
    end
end
figure(1), imshow(uint8(IMG)), title('Imagem original');
figure(2), imshow(uint8(arc)), title('Imagem suavizada');
end