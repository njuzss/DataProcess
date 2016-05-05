function genViewSet(K,vPath,imClass)

label_all = cell(5,1);

for i = 1:5
    load(strcat(vPath,num2str(i),'\',imClass,'_labels.mat'));
    label_all{i} = labels;
    clear idx;
end

for i = 1:length(label_all{i})
    file = strcat(imClass,'_view','.txt');
    fp = fopen(file,'at');
    
    for j = 1:length(label_all)
        temp = label_all{j}(i);
        if(~isempty(temp{1}))
            for x = 1:length(temp{1})
                fprintf(fp,'%d ',temp{1}(x)+K*(j-1));
            end
        end
    end
    fprintf(fp,'\n');
    fclose(fp);
end
end