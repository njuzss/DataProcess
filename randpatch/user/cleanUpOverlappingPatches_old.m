function patInds = cleanUpOverlappingPatches(patches, thresh, probs)
[unused, probInds] = sort(probs, 'descend');
patInds = zeros(1, length(patches));
indCount = 0;
mask = zeros(patches(1).size.nrows, patches(1).size.ncols);
nr = patches(1).y2 - patches(1).y1 + 1;
nc = patches(1).x2 - patches(1).x1 + 1;
patchArea = nr * nc;
for i = 1 : length(probInds)
  p = patches(probInds(i));
  %p
  subMaskArea = sum(sum(mask(p.y1:p.y2, p.x1:p.x2)));
  if subMaskArea / patchArea > thresh
    continue;
  end
  mask(p.y1:p.y2, p.x1:p.x2) = 1;
  indCount = indCount + 1;
  patInds(indCount) = probInds(i);
end
patInds = patInds(1:indCount);
patInds = sort(patInds);
end