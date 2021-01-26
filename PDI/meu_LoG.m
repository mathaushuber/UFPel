function img_bordas = meu_LoG(imagem)
[lin,col] = imread(imagem);
sigma = 2.5;
ksize=ceil(4*sigma);
x=-ksize:ksize;
y=x;
[X,Y]=meshgrid(x,y);
img_binaria = im2bw([lin,col], [0.04]);
ss = [0, 0, -1, 0, 0; 0, -1, -2, -1, 0; -1, -2, 16, -2, -1;0, -1, -2, -1, 0; 0, 0, -1, 0, 0];
G=abs(imfilter(double(img_binaria), ss, 'conv', 'replicate'));
g = mat2gray(G);
kernel = (1/(2*pi*(sigma^2)))*exp(-((X.^2)+(Y.^2))/(2*(sigma^2)));
img_bordas = imfilter(g,kernel,'replicate');
subplot(1,2,1); imshow(img_binaria, [],'Border','tight');    title('imagem original');
subplot(1,2,2); imshow(img_bordas, [],'Border','tight');   title('Laplaciano Gaussiano');
end
% A diferença que notei entre o exercício anterior sobre o operador sobel,
% e o exercício do laplaciano gaussiano é que, o primeiro(sobel) parece ser
% mais sensível a ruídos e visualmente também parece produzir bordas mais espessas, por ser um operador de primeira ordem
% enquanto o laplaciano parece ser mais eficiente na parte de realçar
% detalhes.