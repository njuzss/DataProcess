clear;

%%  add the imagePath
vPath='D:\Experiments\MiltiView\';
imPath='Projections\';
pPath='Patches\';
K=60;
imClass = char('armchair','sofa','endtable','teatable');
view = 13;
scene = 64;
% tic;
% for j = 1:4
%     
%     for i = 1:5
% %        run_randpatch( vPath,num2str(i),deblank(imClass(j,:)),imPath,pPath );
%         detectGMM(vPath,num2str(i),deblank(imClass(j,:)),pPath);
%     end
%     
% end
% toc;
for j = 1:4
    for i = 1:5
        genDatabase(vPath,num2str(i),deblank(imClass(j,:)),K,j);
    end
    
end


