function genViewSet(K,vPath,views,index,imClass)

label_all = cell(views);

for i = 1:views
    load(strcat(vPath,num2str(i),'\',imClass,'_labels.mat'));
    label_all{i} = labels;
    clear idx;
end

file = strcat(imClass,'_view','.model');
fp = fopen(file,'w');
for i = 1:length(label_all{1})
    
    flag = false;
    for j = 1:length(label_all)
        temp = label_all{j}{i};
        if(~isempty(temp))
            flag =true;
            for x = 1:length(temp)
                fprintf(fp,'%d ',temp(x)+K*(index-1)*views+K*(j-1));
            end
        end
    end
    if(flag)
        fprintf(fp,'\n');
    end
    
end
fclose(fp);
end