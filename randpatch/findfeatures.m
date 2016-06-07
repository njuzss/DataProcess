function [ patches ] = findfeatures(imPath)
% addpath(genpath('E:\Desktop\findfeature\'));
params = getParamsForCategory('a');
params = params(1);
% imPath = 'E:\BMPImages\2015_1.bmp';
I = im2double(imread(imPath));

% clear;
% addpath(genpath('C:\Users\zy\Desktop\findfeature\'));
% params = getParamsForCategory('a');
% params = params(1);
% imPath = 'D:\Data\all\2style_models\3u_chair\03\02.bmp';
% I = im2double(imread(imPath));

[IS, scale] = convertToCanonicalSize(I, params.imageCanonicalSize);
[rows, cols, unused] = size(IS);
[rows2, cols2, unused2] = size(I);
IG = getGradientImage(IS);

pyramid = constructFeaturePyramidForImg(imPath, params);
[features, levels, indexes] = unentanglePyramid(pyramid, ...
  params.patchCanonicalSize);
selLevels = 1 : params.scaleIntervals/2 : length(pyramid.scales);
levelScales = pyramid.scales(selLevels);
numLevels = length(selLevels);
[prSize, pcSize, unused] = getCanonicalPatchHOGSize(params);

levelFactor = params.levelFactor;
patches = [];
patFeats = [];
probabilities = [];

for i = 1 : numLevels-2
  levPatSize = floor(params.basePatchSize .* levelScales(i));
  numLevPat = floor((rows / (levPatSize(1) / levelFactor)) * ...
    (cols / (levPatSize(2) / levelFactor))*2);
  
  levelPatInds = find(levels == selLevels(i));
  if numLevPat <= 0
    continue;
  end
  
  IGS = IG;
  pDist = getProbDistribution(IGS, levPatSize);
  pDist1d = pDist(:);
  randNums = getRandForPdf(pDist1d, numLevPat);
  probs = pDist1d(randNums);
  [IY, IX] = ind2sub(size(IGS), randNums);
  IY = IY ./ (levelScales(i) * params.sBins);
  IX = IX ./ (levelScales(i) * params.sBins);
  IY = ceil(IY - prSize / 2);
  IX = ceil(IX - pcSize / 2);
  
  [nrows, ncols, unused] = size(pyramid.features{selLevels(i)});
  xyToSel = IY>0 & IY<=nrows-prSize+1 & IX>0 & IX<=ncols-pcSize+1;
  IY = IY(xyToSel);
  IX = IX(xyToSel);
  probs = probs(xyToSel);
  inds = sub2ind([nrows-prSize+1 ncols-pcSize+1], IY, IX);
  [inds, m, unused] = unique(inds);
  probs = probs(m);
  selectedPatInds = levelPatInds(inds);
  metadata = getMetadata(selectedPatInds, levels,...
    indexes, prSize, pcSize, pyramid,i,rows2,cols2);%i,修改到48和64
  feats = features(selectedPatInds, :);
  if ~isempty(metadata)
    patInds = cleanUpOverlappingPatches(metadata, ...
      params.patchOverlapThreshold, probs,I);%I,增加越界判断!
    patches = [patches metadata(patInds)];
    patFeats = [patFeats; feats(patInds, :)];
    probabilities = [probabilities probs(patInds)'];
  end
  
end
%%
% I3 = imread(imPath);
% imshow(I3);
% color = 'r';
% for i=1 : length(patches)
% %for i=1 : 10
%   selCol = color;
%   rectangle('Position', [patches(i).x1 patches(i).y1 ...
%     abs(patches(i).x2-patches(i).x1) abs(patches(i).y2-patches(i).y1)], ...
%     'EdgeColor', selCol, ...
%     'LineWidth', 4);
% end
%   