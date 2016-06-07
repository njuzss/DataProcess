function [newFeat, newLev, newInds] = appendAllTogether(totalProcessed, ...
  features, levels, indexes)
newFeat = zeros(totalProcessed, size(features{1}, 2));
newLev = zeros(totalProcessed, 1);
newInds = zeros(totalProcessed, 2);

featInd = 1;
for i = 1 : length(features)
  if isempty(features{i})
    continue;
  end
  startInd = featInd;
  endInd = startInd + size(features{i}, 1) - 1;
  newFeat(startInd:endInd, :) = features{i};
  features{i} = [];
  newLev(startInd:endInd) = levels{i};
  levels{i} = [];
  newInds(startInd:endInd, :) = indexes{i};
  indexes{i} = [];
  featInd = endInd + 1;
end
end