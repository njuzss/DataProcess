clear;
vPath='D:\Experiments\MultiView\';
imPath='Projections\';
pPath='Patches\';
K=60;
imClass = char('armchair','sofa','endtable','teatable');
view = 5;
scene = 64;

%% generate clusters using pre-trained gmm
% tic;
% for j = 1:4
%     
%     for i = 1:5
% %         run_randpatch( vPath,num2str(i),deblank(imClass(j,:)),imPath,pPath );
%         detectGMM(vPath,num2str(i),deblank(imClass(j,:)));
%     end
%     
% end
% toc;
%% generate database
for j = 1:4
    
    genDatabase(vPath,j,deblank(imClass(j,:)),K,view);
    
end
