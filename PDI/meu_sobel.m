function img_binaria = meu_sobel(imagem, dir)
[f,cmap] = imread(imagem);
text_diag = 'diagonal';
text_vert = 'vertical';
text_hori = 'horizontal';
img_binaria = im2bw([f,cmap], [0.04])
if strcmpi(dir, text_vert) == 1 || strcmpi(dir, text_hori) == 1;
    %vertical
sx= [-1, -2, -1;0, 0, 0; 1, 2, 1];
    %horizontal
sy= [-1, 0, 1; -2, 0, 2; -1, 0, 1];
Gx=abs(imfilter(double(img_binaria), sx, 'conv', 'replicate'));
Gy=abs(imfilter(double(img_binaria), sy, 'conv', 'replicate'));
gx = mat2gray(Gx);
gy = mat2gray(Gy);

g = gx+gy; 
subplot(1,2,1); imshow(img_binaria, [],'Border','tight');    title('imagem original');
subplot(1,2,2); imshow(g, [],'Border','tight');   title('Sobel Vertical/Horizontal');
end 

if strcmpi(dir, text_diag) == 1;
    %diagonal esquerda
sx= [0, 1, 2; -1, 0, 1; -2, -1, 0];
    %diagonal direita
sy= [-2, -1, 0; -1, 0, 1; 0, 1, 2];
Gx=abs(imfilter(double(img_binaria), sx, 'conv', 'replicate'));
Gy=abs(imfilter(double(img_binaria), sy, 'conv', 'replicate'));
gx = mat2gray(Gx);
gy = mat2gray(Gy);

g = gx+gy; 
subplot(1,2,1); imshow(img_binaria, [],'Border','tight');    title('imagem original');
subplot(1,2,2); imshow(g, [],'Border','tight');   title('Sobel Diagonal');
end
end

%Utilizei também uma comparação de strings para fazer o teste, logo quando o
%usuário informa a direção, a função strcmpi testa as duas strings e
%através do condicional, escolhe qual operação fazer.

%% A diferença que notei entre operador de sobel diagonal e o vertical/horizontal é que o vertical, ao meu ver, pelo menos visualmente, parece ter um efeito melhor.

