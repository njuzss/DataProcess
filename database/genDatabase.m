function genDatabase(vPath,index,imClass, K,views)

label_all = cell(views,1);
for view = 1:views
    load(strcat(vPath,num2str(view),'\',imClass,'_labels.mat'));
    label_all{view} = labels;
end

data = strcat(imClass,'.data');
fp = fopen(data,'w');

% fprintf(fp,'%d\n',length(labels));

for i = 1:length(label_all{1})
    flag = false;
    for view = 1:views
        if(~isempty(label_all{view}{i}))
            flag = true;
            fprintf(fp,'%d ',length(label_all{view}{i}));
            
            for j = 1:length(label_all{view}{i})
                fprintf(fp,'%d ',label_all{view}{i}(j)+K*(index-1)*views+K*(view-1));
            end
            
        end
    end
    if(flag)
        fprintf(fp,'\n');
    end
end
fclose(fp);

end


