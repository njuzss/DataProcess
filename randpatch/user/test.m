imPath = 'C:\Users\zy\Desktop\neg\airplane\1.png';
origin = imread(imPath);
I = im2double(origin);
ytop=size(I,1);
ybottom=0;
xleft=size(I,2);
xright=0;

for i =20:size(I,1)-20
    for j=11:size(I,2)-11
        if(I(i,j)<1)
             if(i < ytop)
                 ytop = i;
             end
             if(i > ybottom)
                 ybottom = i;
             end
             if(j < xleft)
                 xleft = j;
             end
             if(j > xright)
                 xright = j;
             end
        end
    end
end
I2=origin(ytop:ybottom,xleft:xright);
I3=imresize(I2,0.25)
imshow(I3);
%{
color = 'r';

  selCol = color;
  rectangle('Position', [xleft ytop ...
    abs(xright-xleft) abs(ybottom-ytop)], ...
    'EdgeColor', selCol, ...
    'LineWidth', 4);
%}
%feat = features(I, 8);