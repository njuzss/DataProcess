clear;
modelnum = 12;%模型数量
imagenum = 12;%每个模型的投影数量
left = 4;%去掉最后几分之一
for i = 1: modelnum
    if(i == 6)
        continue;
    end
    fin=fopen(['C:\Users\zy\Desktop\cleanpatchtxt\curve\' num2str(i) '.txt'],'r');
    threldscore =0;%得分阈值
    %初始化该模型下每个视角的patch
    for t =1 : imagenum
        result(i).image(t).patch = [];
        final(i).image(t).patch = [];
    end
    while ~feof(fin) 
        str=fgetl(fin);
        S = regexp(str,',','split');
        score = str2double(S(4));
        if(threldscore == 0)
            threldscore = score /left;%得分阈值为最大得分的几分之几
        end
        if(score > threldscore)%如果超过阈值
            imagename = S(3);
            imageid = mod(floor(str2double(imagename{1}(6:end-4))),12);
            if(imageid == 0)
                imageid =12;
            end
            result(i).imagename(imageid) = S(3);
            final(i).imagename(imageid) = S(3);
            patch.score = score;
            patch.x1 = str2double(S(5));
            patch.x2 = str2double(S(6));
            patch.y1 = str2double(S(7));
            patch.y2 = str2double(S(8));
            result(i).image(imageid).patch= [result(i).image(imageid).patch patch];
        end
    end
    fclose(fin);
    threldscore=0;
    for t =1 : length(result(i).imagename)
        image = result(i).image(t);
        for j = 1:length(image.patch)
            if(image.patch(j).score > 0)%这里判断这个patch是否可以忽略掉，而不是看得分低
                for(k = j+1:length(image.patch))
                    if(image.patch(k).score > 0)
                        widthj = image.patch(j).x2 - image.patch(j).x1;
                        heighj = image.patch(j).y2 - image.patch(j).y1;
                        widthk = image.patch(k).x2 - image.patch(k).x1;
                        heighk = image.patch(k).y2 - image.patch(k).y1;
                        if(abs(image.patch(k).y2- image.patch(j).y1) > abs(image.patch(j).y2- image.patch(k).y1))
                            widthmax = abs(image.patch(k).y2- image.patch(j).y1);
                            widthmin = abs(image.patch(j).y2- image.patch(k).y1);
                        else
                            widthmin = abs(image.patch(k).y2- image.patch(j).y1);
                            widthmax = abs(image.patch(j).y2- image.patch(k).y1);
                        end
                        if(abs(image.patch(k).x2- image.patch(j).x1) > abs(image.patch(j).x2- image.patch(k).x1))
                            heighmax = abs(image.patch(k).x2- image.patch(j).x1);
                            heighmin = abs(image.patch(j).x2- image.patch(k).x1);
                        else
                            heighmin = abs(image.patch(k).x2- image.patch(j).x1);
                            heighmax = abs(image.patch(j).x2- image.patch(k).x1);
                        end
                        %判断两个矩阵是否相交
                        if(widthmax < widthj+widthk && heighmax < heighj+heighk)
                           S = widthmin * heighmin;
                           %如果重合面积过大
                           if(S > 1000)
                              image.patch(k).score =0;
                           end
                        end
                    end
                end
            end
        end 
        for j=1 : length(image.patch)
            if(image.patch(j).score > 0)             
                final(i).image(t).patch = [final(i).image(t).patch image.patch(j)];
            end
        end
    end
end
save('C:\Users\zy\Desktop\cleanpatchmat\curve.mat','final');