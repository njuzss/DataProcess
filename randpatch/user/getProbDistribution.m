function dist = getProbDistribution(I, pSize)
h = fspecial('gaussian', pSize, min(pSize)/3);
I = imfilter(I, h);
dist = I ./ sum(sum(I));
end