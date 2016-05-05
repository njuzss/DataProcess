function genModelSet(K,vPath,view,views,imClass)

label_all = cell(length(imClass(:,1)),1);

for i = 1:length(imClass(:,1))
    load(strcat(vPath,view,'\',deblank(imClass(i,:)),'_labels.mat'));
    label_all{i} = labels;
    clear idx;
end

file = strcat('aest_view_',num2str(view),'.scene');
fp = fopen(file,'w');
for i = 1:length(label_all{1})
    
    flag = false;
    for j = 1:length(label_all)
        temp = label_all{j}{i};
        if(~isempty(temp))
            flag =true;
            for x = 1:length(temp)
                fprintf(fp,'%d ',temp(x)+K*(str2double(view)-1)+K*(j-1)*views);
            end
        end
    end
    if(flag)
        fprintf(fp,'\n');
    end
    
end

fclose(fp);
end