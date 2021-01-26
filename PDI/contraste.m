function nova_imagem = contraste(figura)
I = imread(figura);
histogram(I);
        menor = min(min(I(:)));
        maior = max(max(I(:)));
   saida(:, :) = ((I(:, :) - menor)/(maior - menor))*256
  %Gerando nova imagem com o contraste alargado! 
 imwrite(saida, 'novaimagem.bmp');
 nova_imagem = imread('novaimagem.bmp');
 %Para mostrar a imagem!
 figure(1), imshow('novaimagem.bmp');
 %Para mostrar o histograma!
 figure(2), histogram(nova_imagem);
 return
end 
