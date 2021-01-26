function img_aberta = abertura(imagem)
I = imread(imagem);
ib = im2bw(I);
BNW=ib;
img_aberta = ib;
img_ero = ib;
BNW = padarray (BNW, [1,1]);
[lin,col]=size(BNW);
for i=2:lin-1
  for j=2:col-1
    janela = BNW(i-1:i+1,j-1:j+1);
    s=sum(sum (janela, 1));
    if(s >= 1)
      img_aberta(i-1,j-1,:)=1;
    end
  end
end
img_ero = padarray (img_ero, [1,1]);
[lin,col]=size(img_ero);
for i=2:lin-1
  for j=2:col-1
    janela = img_ero(i-1:i+1,j-1:j+1);
    s=sum(sum (janela, 1));
    if(s < 9)
      img_aberta(i-1,j-1,:)=0;
    end
  end
end
subplot(1,2,1); imshow(ib);
subplot(1,2,2); imshow(img_aberta);
end