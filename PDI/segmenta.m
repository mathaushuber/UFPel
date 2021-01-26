function img_binaria = segmenta(imagem)
%%LIMIARIZAÇÃO GLOBAL, FAZENDO A BINARIZAÇÃO DA IMAGEM COMPLETA
I = imread(imagem);
level = graythresh(I)
img_binaria = im2bw(I, level);
figure; imshow(img_binaria), title('LIMIARIZAÇÃO GLOBAL');

%%LIMIARIZAÇÃO LOCAL, DIVIDINDO A IMAGEM EM OITO PARTES E FAZENDO A
%%BINARIZAÇÃO DE CADA UMA EM SEPARADO
lim_local = imread(imagem);
level = graythresh(lim_local);
[linhas colunas] = size(lim_local);
col1 = 1;
col2 = floor(colunas/2);
col3 = col2 + 1;
col4 = 2;
col5 = floor(colunas/4);
col6 = col5 + 1;
lin1 = 1;
lin2 = floor(linhas/2);
lin3 = lin2 + 1;
lin4 = 2;
lin5 = floor(linhas/4);
lin6 = lin5 + 1;
imagem1 = imcrop(lim_local, [col1 lin1 col2 lin2]);
imagem2 = imcrop(lim_local, [col3 lin1 colunas - col2 lin2]);
imagem3 = imcrop(lim_local, [col1 lin3 col2 lin2]);
imagem4 = imcrop(lim_local, [col3 lin3 colunas - col2 linhas - lin2]);
imagem5 = imcrop(lim_local, [col4 lin4 col5 lin5]);
imagem6 = imcrop(lim_local, [col6 lin4 colunas - col5 lin5]);
imagem7 = imcrop(lim_local, [col4 lin6 col5 lin5]);
imagem8 = imcrop(lim_local, [col6 lin6 colunas - col5 linhas - lin5]);
imgbin1 = im2bw(imagem1, [0.04]);
imgbin2 = im2bw(imagem2, [0.04]);
imgbin3 = im2bw(imagem3, [0.04]);
imgbin4 = im2bw(imagem4, [0.04]);
imgbin5 = im2bw(imagem5, [0.04]);
imgbin6 = im2bw(imagem6, [0.04]);
imgbin7 = im2bw(imagem7, [0.04]);
imgbin8 = im2bw(imagem8, [0.04]);
figure;
subplot(3, 3, 1);
imshow(imgbin1), title('LIMIARIZAÇÃO POR PARTES');
subplot(3, 3, 2);
imshow(imgbin2);
subplot(3, 3, 3);
imshow(imgbin3);
subplot(3, 3, 4);
imshow(imgbin4);
subplot(3, 3, 5);
imshow(imgbin5);
subplot(3, 3, 6);
imshow(imgbin6);
subplot(3, 3, 7);
imshow(imgbin7);
subplot(3, 3, 8);
imshow(imgbin8);
end

%% Utilizei a função greythresh que pelo que entendi, calcula um limite global da imagem em escala de cinza, usando o método de Otsu. Achando o melhor thresholder, na minha opinião visual, nesse exemplo não ficou bem nítido, quando testei thresholders manualmente, o que se mostrou melhor visualmente foi o 0.04.
%De todo modo, mesmo com o thresholder com o limite global 'level', dá para
%notar uma diferença entre a limiar por partes que cumpre um papel melhor,
%pois a limiarização global pode falhar quando a iluminação não for boa.