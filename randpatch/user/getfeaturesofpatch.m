impath='C:\Users\zy\Desktop\new\';
imgDir = fullfile(impath);
imgIds=dir(fullfile(imgDir, '*'));
imgIds={imgIds.name};
nImgs=length(imgIds);

%{
I = im2double(imread(imPath));
I1 = imresize(I,[80,80]);
feat = features(I1, sBins);
%}
prsize = 80;
pcsize = 80;
sBins = 8;
dim =31;

for i=3:nImgs
     s = imgIds{i};
     I = im2double(imread([impath s]));
     I1 = imresize(I,[prsize,pcsize]);
     feat = features(I1, sBins);
     feat2 = feat(:,:,1:dim);
     [rows,cols,d] = size(feat2);
     featDim = rows * cols * d;
     result.patch(i-2).feature = reshape(feat2, 1, featDim);
     result.patch(i-2).name=imgIds{i};
end