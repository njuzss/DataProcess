clf;
clear;
num = 1;
load('C:\Users\zy\Desktop\inputdata\dirtypatch\line.mat','result');
imagepath = 'C:\Users\zy\Desktop\inputdata\image\line\';
I = imread([imagepath result(num).image]);
imshow(I);
color = 'r';
selCol = color;

for i =1:length(result(num).allpatch)
    rectangle('Position', [result(num).allpatch(i).patch.x1 result(num).allpatch(i).patch.y1 ...
        abs(result(num).allpatch(i).patch.x2-result(num).allpatch(i).patch.x1) abs(result(num).allpatch(i).patch.y2-result(num).allpatch(i).patch.y1)], ...
        'EdgeColor', selCol, ...
        'LineWidth', 4);
end
