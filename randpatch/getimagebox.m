function I2 = getimagebox(origin,arg1)
I=im2double(origin);
ytop=size(I,1);
ybottom=0;
xleft=size(I,2);
xright=0;
offset=arg1;

for i =1:size(I,1)
    for j=1:size(I,2)
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
if(ybottom-ytop < 64)
   ybottom = ytop + 64; 
end
if(xright-xleft < 64)
   xright = xleft + 64; 
end
I2=origin(ytop-offset:ybottom+offset,xleft-offset:xright+offset,:);