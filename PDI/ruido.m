function adicao_ruido = ruido(imagem)
I = imread(imagem);
adicao_ruido = imnoise(I, 'gaussian', 0, 0.01);
subplot(3,2,1); imshow(adicao_ruido), title('Gaussiano - Méd: 0, Var: 0.01'); 
adicao_ruido = imnoise(I, 'gaussian', 30, 0.01);
subplot(3,2,2); imshow(adicao_ruido), title('Gaussiano - Méd: 30, Var: 0.01'); 
adicao_ruido = imnoise(I, 'gaussian', 50, 0.05);
subplot(3,2,3); imshow(adicao_ruido), title('Gaussiano - Méd: 50, Var: 0.05'); 
adicao_ruido = imnoise(I, 'poisson');
subplot(3,2,4); imshow(adicao_ruido), title('Poisson'); 
adicao_ruido = imnoise(I, 'salt & pepper', 0.02);
subplot(3,2,5); imshow(adicao_ruido), title('salt & pepper - 2%');
adicao_ruido = imnoise(I, 'salt & pepper', 0.10);
subplot(3,2,6); imshow(adicao_ruido), title('salt & pepper - 10%');

end