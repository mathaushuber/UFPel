
function arquivo2 = redimensionar(arquivo1, tipo, num1, num2)
I = imread(arquivo1);
[lin, col,d] = size(I);
zl = lin/num1;
zc = col/num2;
if tipo == 1
    %Tipo vizinho mais proximo
 for i=1:1: zl;
     x = i/num1;
     mapi = round(x);
     if mapi == 0;
          mapi = 1;
     end
     for j=1:1:zc;
         y= j/num2;
         mapj = round(j);
         if mapj == 0;
          mapj = 1;
         end;
         img_redimensionada(i,j,:)= I(mapi,mapj,:);
     end
 end
 imwrite(img_redimensionada, 'nova_imagem.bmp');
 arquivo2 = 'nova_imagem.bmp';
 imshow(arquivo2);
end
if tipo == 2
    %Tipo Bilinear
  for i=1:zl
    
    x=i/num1;
    
    x1=floor(x);
    x2=ceil(x);
    if x1==0
        x1=1;
    end
    xint=rem(x,1);
    for j=1:zc
        
        y=j/num2;
        
        y1=floor(y);
        y2=ceil(y);
        if y1==0
            y1=1;
        end
        yint=rem(y,1);
        
        BL=I(x1,y1,:);
        TL=I(x1,y2,:);
        BR=I(x2,y1,:);
        TR=I(x2,y2,:);
        
        R1=BR*yint+BL*(1-yint);
        R2=TR*yint+TL*(1-yint);
        
        img_redimensionada(i,j,:)=R1*xint+R2*(1-xint);
    end
end
 imwrite(img_redimensionada, 'nova_imagem.bmp');
 arquivo2 = 'nova_imagem.bmp';
 imshow(arquivo2) 
end
end