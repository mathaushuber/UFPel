function figura_out = restaura_media(figura_in, N);
I = imread(figura_in);
fSize = N; 
padding = ceil((fSize-1)/2);

mask = zeros(size(I) + padding*2);


for x=1:size(I,1)
    for y=1:size(I,2)
        mask(x+padding,y+padding) = I(x,y);
    end
end

figura_out = zeros(size(I));

for k=1:size(I,1)
    for l=1:size(I,2)
        sum=0;
        for x=1:fSize
            for y=1:fSize                
                sum = sum + mask(k+x-1,l+y-1);
            end
        end        
        figura_out(k,l) = ceil(sum/(fSize*fSize));
    end
end

figura_out = uint8(figura_out);
figure; subplot(1,2,1), imshow(figura_in); subplot(1,2,2), imshow(figura_out);
end