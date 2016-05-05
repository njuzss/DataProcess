clear;
vPath='D:\Experiments\MultiView\';
imPath='Projections\';
pPath='Patches\';
cluPath = 'Clusters\';

imClass = char('armchair','sofa','endtable','teatable');
K=60;         %max k among models
view = 5;
scene = 64;
threshold_l = 0.1;
threshold_h = 0.16;

%% clustering
% for j = 1:length(imClass(:,1))
%     for i = 1:view      
% %        randpatch( vPath,num2str(i),deblank(imClass(j,:)),imPath,pPath );
% %         GMM( K,vPath,num2str(i),deblank(imClass(j,:)),pPath,cluPath );
% %       filterClu(K,scene,vPath,num2str(i),cluPath,deblank(imClass(j,:)),threshold_l,threshold_h);
%     end
% end
%% generate inter-view trainning data 
% for i = 1:length(imClass(:,1))  
%        
%        genViewSet(K,vPath,view,i,deblank(imClass(i,:)));
% end
%% generate intra-view trainning data 
for i = 1:view
       genModelSet(K,vPath,num2str(i),view ,imClass);
end