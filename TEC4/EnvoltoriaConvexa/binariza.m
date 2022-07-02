function binariza(imagem)
I = imread(imagem)
bin = im2bw(I,0.2);
imwrite(bin, 'imgbin.jpg');
end
