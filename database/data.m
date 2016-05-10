clear;
vPath='D:\Experiments\MultiView\database\';
imPath='Projections\';
pPath='Patches\';
K=60;
imClass = char('armchairs','sofas','endtables','teatables');
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
    for i = 1:5
        genDatabase(vPath,j,deblank(imClass(j,:)),i,K,view);
    end
end
