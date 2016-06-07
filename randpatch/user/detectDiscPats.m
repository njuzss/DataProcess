%% Do detection of discriminative patches.
% Author: saurabh.me@gmail.com (Saurabh Singh).

% Load up the models.

load([USR.modelDir 'pascal.mat'], 'detectors');

%% Load up the image.

imPaths = {'b.jpg'};
data = prepareDataForPaths(USR.imgDir, imPaths);

%% Run the detectors.
% Construct detection parameters.
detParams = getBaseDetectionParams();
detParams.useDecisionThresh = true;
detParams.fixedDecisionThresh = -0.9;
% Run the detectors.
res = detectors.detectPresenceInImg(data(1), USR.imgDir, true, detParams);

%% Display the detections

d = res.firstLevel.detections;
clf;
I = imread([USR.imgDir imPaths{1}]);
imshow(I);
%fprintf('%d\n',length(d));
count=1;
for i = 1 : length(d)/2
  if isempty(d(i).metadata)
    continue;
  end
  displayPatchBox(d(i).metadata, d(i).decision);
  count=count+1;
end
fprintf('%d\n',count);
