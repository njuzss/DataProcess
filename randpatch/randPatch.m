% randpatch
%¡¡The patch sizes we've sampled are ([48,48],[64,64])or([32,32],[48,48]).You can choose the best size in 
%  the function 'findfeatues' to complete your mission.

function randPatch( vPath,view,imClass,imPath,pPath )

fid=fopen(fullfile([vPath,view,'\',imClass,'.txt']),'w');

tic;

%% randpatch
proPath = strcat(vPath,view,'\',imPath,imClass);
patPath = strcat(vPath,view,'\',pPath,imClass);
[pathstruct,pathstr]=dirext(proPath,'bmp');%

nImgs=length(pathstr);
name = {pathstruct.name};
for i=1:length(name)
    name{i} = name{i}(1:end-4);
end
name = natsort(name);
pathstr = natsort(pathstr);

for i=1:nImgs
    pic=imread(pathstr{i});
    patches=findfeatures(pathstr{i});
    patchnum=size(patches,2);

    dis=patches(1,1).x2-patches(1,1).x1;
    for j=1:patchnum
         patch=imcrop(pic,[patches(1,j).x1,...
                           patches(1,j).y1,...
                           patches(1,j).x2-patches(1,j).x1-1,...
                           patches(1,j).y2-patches(1,j).y1-1]);                       
                           filename=sprintf('_%d.bmp',j);                           
                           filename=fullfile([patPath,'\',name{i},filename]);
                          imwrite(patch, filename, 'bmp');
    end
    fprintf(fid,'%d', patchnum);
    fprintf(fid,'\r\n');
    fprintf('%d\n', i);
end
fclose(fid);

%% calculator the images'HOG feature
%% start up
count=0;     
V=zeros(patchnum,1296);  % HOG feature output. the rows of the V is the all patches' number.
prsize = 56;          % 'cause we have two different size image, we have to resize them to a common size
pcsize = 56;           %  to accomplish  the calculator of the images HOG .
%% add path
num= importdata(fullfile([vPath,view,'\',imClass,'.txt']));
for i=1:nImgs
    numb=num(i);
    for j=1:numb
        count=count+1;
        tPath=sprintf('_%d.bmp',j);
        tPath=fullfile([patPath,'\',name{i},tPath]);
        patch=imread(tPath);
        patch=imresize(patch,[prsize,pcsize]);
        HOG=hogcalculator(patch);
        V(count,:)=HOG;
    end
end

hog_feature = strcat(vPath,view,'\',imClass,'_hog.mat');
save(hog_feature,'V');
toc;
