params = getParamsForCategory('a');
params = params(1);
imPath = 'C:\Users\zy\Desktop\screen\curve\01table_end\1.bmp';
I = im2double(imread(imPath));

[IS, scale] = convertToCanonicalSize(I, params.imageCanonicalSize);
[rows, cols, unused] = size(IS);
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

i=1;
levPatSize = floor(params.basePatchSize .* levelScales(i));
numLevPat = floor((rows / (levPatSize(1) / levelFactor)) * ...
(cols / (levPatSize(2) / levelFactor))*2);

levelPatInds = find(levels == selLevels(i));

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
indexes, prSize, pcSize, pyramid);
feats = features(selectedPatInds, :);
if ~isempty(metadata)
patInds = cleanUpOverlappingPatches(metadata, ...
  params.patchOverlapThreshold, probs);
patches = [patches metadata(patInds)];
patFeats = [patFeats; feats(patInds, :)];
probabilities = [probabilities probs(patInds)'];
end
  