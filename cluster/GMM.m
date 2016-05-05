function GMM( K,vPath,view,imClass,pPath,cluPath )

load(strcat(vPath,view,'\',imClass,'_hog.mat'));

tic;
GMModel = fitgmdist(V,K,'Regularize',0.01,'Start','plus');
idx = cluster(GMModel,V);
idx_model = strcat(vPath,view,'\',imClass,'_idx.mat');
save(idx_model,'idx');
gmm_model = strcat(vPath,view,'\',imClass,'_gmm.mat');
save(gmm_model,'GMModel');
toc;

%% mkdir
num_cluster = K;

for i = 1:num_cluster
    dirname = num2str(i);
    mkdir(fullfile(vPath,view,'\',cluPath,imClass),dirname);
    
end


%% collect the results
patPath = strcat(vPath,view,'\',pPath,imClass);
clusterPath = strcat(vPath,view,'\',cluPath,imClass);
Files = dir(fullfile(patPath,'*.bmp'));
names = {Files.name};     
name = natsort(names); 

 for i = 1:length(idx)
     sourcePath = strcat(patPath,'\',name{i});

    impath = strcat(clusterPath,'\',num2str(idx(i)),'\',name{i});
   
    Img = imread(sourcePath,'bmp');

    imwrite(Img,impath);
   
 end