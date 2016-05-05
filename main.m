clear;

%%  add the imagePath
vPath='D:\Experiments\MultiView\';
imPath='Projections\';
pPath='Patches\';
cluPath = 'Clusters\';
K=60;
imClass = char('armchair','sofa','endtable','teatable');

threshold_l = 0.1;
threshold_h = 0.2;
view = 13;
scene = 64;

% for i = 1:4  
%     genViewSet(K,vPath,deblank(imClass(i,:)));
% end

for j = 1:1
    for i = 1:5
%        run_randpatch( vPath,num2str(i),deblank(imClass(j,:)),imPath,pPath );
%        run_GMM( K,vPath,num2str(i),deblank(imClass(j,:)),pPath,cluPath );
%        run_idf(scene,view,K,vPath,cluPath,deblank(imClass(i,:)),threshold_l,threshold_h);
%        run_idf_backup(K,vPath,num2str(i),cluPath,deblank(imClass(j,:)),threshold_l,threshold_h);
%        run_genLabels(vPath,num2str(i),cluPath,deblank(imClass(j,:)));
        genModelSet(K,vPath,num2str(i),imClass);
        genViewSet(K,vPath,deblank(imClass(i,:)));
    end
end
