function figura_out = restaura_mediana(figura_in, N);
i=imread(figura_in);
tam = size(i);
pad=uint8(zeros(size(i)+2*(N-1)));

for x=1:size(i,1)
            for y=1:size(i,2)
                pad(x+N-1,y+N-1)=i(x,y);
            end
end 

 for i = 2:tam(1) - 1
    for j = 2:tam(2) - 1
        kernel=uint8(zeros((N)^2,1));
        t=1;
        for x=1:N
          for y=1:N
                kernel(t)=pad(i+x-1,j+y-1);
                t=t+1;
          end
        end
        filt=sort(kernel);
        figura_out(i,j)=filt(ceil(((N)^2)/2));
    end
 end
subplot(1,2,1);imshow(figura_in);
subplot(1,2,2);imshow(figura_out);
end