for i=1 : 144
    save([num2str(i) '_res.mat'],'-v7.3');
    res = load(['E:\experiment\第六次实验\sixresult\pascalClusters\div2\train\assimilated\detectionResult\pos\' num2str(i) '_res.mat']);
    d=str2num(res.detResults.firstLevel.imagePath(63:end-4));
    if(d<13)
        fprintf('%d\n',d);
    end
end