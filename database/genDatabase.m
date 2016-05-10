function genDatabase(vPath,index,imClass,view, K,views)

load(strcat(vPath,num2str(view),'\',imClass,'_labels.mat'));

data = strcat(imClass,'_',num2str(view),'.data');

fp = fopen(data,'w');
fprintf(fp,'%d\n',length(labels));
for i = 1:length(labels)
    fprintf(fp,'%d %d\n',i,length(labels{i}));
    for j = 1:length(labels{i})
        fprintf(fp,'%d\n',labels{i}(j)+K*(index-1)*views+K*(view-1));
    end
    
end
fclose(fp);


end

