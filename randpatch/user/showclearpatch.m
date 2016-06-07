clf;
clear;
load('C:\Users\zy\Desktop\cleanpatchmat\line.mat','final');
imagepath = 'C:\Users\zy\Desktop\inputdata\image\line\';
imagename = '2015_10.bmp';
I = imread([imagepath imagename]);
imshow(I);
color = 'r';
selCol = color;
for i =1 : length(final(1).imagename)
    if(strcmp(final(1).imagename(i),imagename))
        image = final(1).image(i);
        for j=1 : length(image.patch)
            if(image.patch(j).score > 0)
                rectangle('Position', [image.patch(j).x1 image.patch(j).y1 ...
                abs(image.patch(j).x2-image.patch(j).x1) abs(image.patch(j).y2-image.patch(j).y1)], ...
                'EdgeColor', selCol, ...
                'LineWidth', 4);
            end
        end
        break;
    end
end