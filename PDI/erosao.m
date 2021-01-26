function img_erodida= erosao(imagem, e_estruturante)
I = imread(imagem);
ib = im2bw(I);
BNW=ib;
img_erodida = ib;
BNW = padarray (BNW, e_estruturante);
[lin,col]=size(BNW);
for i=2:lin-1
  for j=2:col-1
    janela = BNW(i-1:i+1,j-1:j+1);
    s=sum(sum (janela, 1));
    if(s >= 1)
      img_erodida(i-1,j-1,:)=1;
    end
  end
end
subplot(1,2,1); imshow(ib);
subplot(1,2,2); imshow(img_erodida);
end