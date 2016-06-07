
clear;
imagepath = 'D:\Experiments\MultiView\Models\sofa';
targetpath = 'D:\Experiments\MultiView\Projections\sofa\';
[pathstruct,pathstr]=dirext(imagepath,'bmp');%
pathstr = natsort(pathstr);
nImgs=length(pathstr);

name = {pathstruct.name};
count = 0;
names = [];
for i=1:nImgs
    namet = name(i);
    namet1=namet{1}(1);
    namet1=str2num(namet1)+0;
    namet = namet{1}(2:end);
    namet=strcat(num2str(namet1),namet);
    name{i} = namet;
end

for i=1:nImgs
imginfo = imread(pathstr{i});
I2 = getimagebox(imginfo,0);%Ôö¼ÓÁËÆ«ÒÆ
%[height,width,depth] = size(I2);
str = [targetpath name{i}];%%
%imwrite(imginfo,str,'bmp');%%
imwrite(I2,str,'bmp');
end
