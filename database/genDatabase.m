function genDatabase(vPath,view,imClass,K,index )

load(strcat(vPath,view,'\',imClass,'_labelss.mat'));
load(strcat(vPath,view,'\',imClass,'_nums.mat'));

data = strcat(imClass,'_',view,'.txt');

fp = fopen(data,'at');
fprintf(fp,'%d\n',length(labels));
for i = 1:length(labels)
    fprintf(fp,'%d %d\n',i,length(labels{i}));
    for j = 1:length(labels{i})
        fprintf(fp,'%d %d\n',labels{i}(j)+K*(index-1),nums{i}(j));
    end
    
end
fclose(fp);


end

