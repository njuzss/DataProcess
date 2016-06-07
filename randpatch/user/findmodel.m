clear;
mybegin= 0;
myend = 13;
matpath = 'E:\experiment\第五次实验\fifthresult\pascalClusters\div2\train\assimilated\detectionResult\pos\';
matnum = 156;
index =1;
for i=1 : matnum
    res = load([matpath num2str(i) '_res.mat']);
    %d=str2num(res.detResults.firstLevel.imagePath(75:end-4));%find eightresult
    d=str2num(res.detResults.firstLevel.imagePath(63:end-4));%find fifthresult
    if(mybegin<d && d <myend)
        fprintf('%d\n',i);
        index =index+1;
    end
    if(index > 12)
        break;
    end
end