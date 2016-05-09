function detectGMM( vPath,view,imClass,pPath )

load(strcat(vPath,view,'\',imClass,'_hog.mat'));
load(strcat(vPath,view,'\',imClass,'_gmm.mat'));

[idx,nlogl,P] = cluster(GMModel,V);

%% collect the results
num= importdata(fullfile([vPath,view,'\',imClass,'.txt']));

labels = cell(length(num),1);
count = 1;
for i=1:length(num)
    for j=1:num(i)
        labels{i} = [labels{i},idx(count)];
        count = count+1;
    end
end

for i= 1:length(labels)
%    labels{i} = unique(labels{i});
    labels_uniq{i} = unique(labels{i});
end

nums = labels_uniq;

for i = 1:length(labels)
    for j = 1:length(nums{i})
        num_count = 0;
        for k = 1:length(labels{i})
            if(labels{i}(k) == nums{i}(j))
                num_count = num_count +1;
            end
        end
        nums{i}(j) = num_count;
    end
end

labels = labels_uniq;

labels_gmm = strcat(vPath,view,'\',imClass,'_labelss');
save(labels_gmm,'labels');

nums_gmm = strcat(vPath,view,'\',imClass,'_nums');
save(nums_gmm,'nums');

end