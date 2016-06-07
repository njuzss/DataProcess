clear;
numofimages = 468;
for k=1:numofimages
    %%read results
    %clear;
    res = load(['E:\experiment\第八次实验\eightresult\pascalClusters\div2\train\assimilated\detectionResult\pos\' num2str(k) '_res.mat']);
    %% Display the detections

    d = res.detResults.firstLevel.detections;
    %clf;
    %I = imread(res.detResults.firstLevel.imagePath);
    %imshow(I);
    num=1;
    for i = 1 : length(d)
      if isempty(d(i).metadata)
        continue;
      end
      for j=1 : length(d(i).metadata)
          final(k).order(num).patch = d(i).metadata(j);
          final(k).order(num).decision = d(i).decision(j);
          num = num+1;
      end
    end
    %%

    %%sort
    [decisionnew, index]=sort([final(k).order.decision],'descend');
    for i=1 : length(final(k).order)
      final(k).ordernew(i).patch = final(k).order(index(i)).patch;
      final(k).ordernew(i).decision = final(k).order(index(i)).decision;
    end

    %%
    %%clear the big patch
    num2=1;
    for i=1 : length(final(k).order)
        final(k).sizeofpatch(i) = abs(final(k).ordernew(i).patch.x2-final(k).ordernew(i).patch.x1)*abs(final(k).ordernew(i).patch.y2-final(k).ordernew(i).patch.y1);
       if(final(k).sizeofpatch(i) < 8000 && -0.7 < final(k).ordernew(i).decision)
           %size2(i)=sizeofpatch(i);
           final(k).ordernew2(num2)=final(k).ordernew(i);
           num2=num2+1;
       end
    end
    %%
    temp=str2num(res.detResults.firstLevel.imagePath(75:end-4));
    numofpatch = min(15,floor(num2/2));
    result(temp).allpatch=final(k).ordernew2(1:numofpatch);
    result(temp).image=res.detResults.firstLevel.imagePath(70:end);
end
save('C:\Users\zy\Desktop\inputdata\dirtypatch\three.mat','result');