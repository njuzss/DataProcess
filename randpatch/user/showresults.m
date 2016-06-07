%%read results
clear;
res = load('E:\experiment\第五次实验\fifthresult\pascalClusters\div2\train\assimilated\detectionResult\pos\146_res.mat');
%% Display the detections

d = res.detResults.firstLevel.detections;
clf;
%I = imread([res.detResults.firstLevel.imagePath(1:55) '3' res.detResults.firstLevel.imagePath(56:end)]);
%I = imread(res.detResults.firstLevel.imagePath);
I = imread(['E:\experiment\第五次实验\image\' res.detResults.firstLevel.imagePath(58:end)]);
imshow(I);
num=1;
for i = 1 : length(d)
  if isempty(d(i).metadata)
    continue;
  end
  for j=1 : length(d(i).metadata)
      order(num).patch = d(i).metadata(j);
      order(num).decision = d(i).decision(j);
      num = num+1;
  end
end
%%

%%sort
[decisionnew, index]=sort([order.decision],'descend');
for i=1 : length(order)
  ordernew(i).patch = order(index(i)).patch;
  ordernew(i).decision = order(index(i)).decision;
end

%%
%%clear the big patch
num2=1;
for i=1 : length(order)
    sizeofpatch(i) = abs(ordernew(i).patch.x2-ordernew(i).patch.x1)*abs(ordernew(i).patch.y2-ordernew(i).patch.y1);
   if(sizeofpatch(i) < 8000 && -0.7< ordernew(i).decision)
       size2(i)=sizeofpatch(i);
       ordernew2(num2)=ordernew(i);
       num2=num2+1;
   end
end
%%
if(num2 == 1)
    finalresult =0;
else
    finalresult=min(10,length(ordernew2)/2);
end
color = 'r';
for i=1 : finalresult
%for i=1 : 10
  selCol = color;
  rectangle('Position', [ordernew2(i).patch.x1 ordernew2(i).patch.y1 ...
    abs(ordernew2(i).patch.x2-ordernew2(i).patch.x1) abs(ordernew2(i).patch.y2-ordernew2(i).patch.y1)], ...
    'EdgeColor', selCol, ...
    'LineWidth', 4);

    text(ordernew2(i).patch.x1, ordernew2(i).patch.y1 - 12, sprintf('%.3f', ...
      ordernew2(i).decision), ...
      'BackgroundColor', selCol, ...
      'Color', 'k', ...
      'FontSize', 5);
end