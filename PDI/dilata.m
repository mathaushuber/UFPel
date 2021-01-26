function img_dilatada= dilata(imagem)
I = imread(imagem);
ib = im2bw(I);
BNW=ib;
img_dilatada = ib;
BNW = padarray (BNW, [1 1]);
[lin,col]=size(BNW);
for i=2:lin-1
  for j=2:col-1
    janela = BNW(i-1:i+1,j-1:j+1);
    s=sum(sum (janela, 1));
    if(s < 9)
      img_dilatada(i-1,j-1,:)=0;
    end
  end
end
subplot(1,2,1); imshow(ib);
subplot(1,2,2); imshow(img_dilatada);
end