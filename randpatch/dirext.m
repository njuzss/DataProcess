function [pathstruct,pathstr]=dirext(thepath,syntax)
% 使用递归方法列出或查找指定目录下的文件
% 可以使用dos命令得到相同的效果
% [~,pathstruct]=system(['dir /B/S ', thepath])
%
% 输入参数
% thepath：需要检索的目录
% syntax：匹配语法，仅支持正则匹配
% 正则语法 http://www.cnblogs.com/deerchao/archive/2006/08/24/zhengzhe30fengzhongjiaocheng.html
% .                    匹配除换行符以外的任意字符
% \w            匹配字母或数字或下划线或汉字
% \s                    匹配任意的空白符
% \d                    匹配数字
% \b                    匹配单词的开始或结束
% ^                    匹配字符串的开始
% $                    匹配字符串的结束
% *                    重复零次或更多次
% +                    重复一次或更多次
% ?                    重复零次或一次
% {n}                    重复n次
% {n,}                    重复n次或更多次
% {n,m}                    重复n到m次
%
% 输出参数
% pathstruct: 检索到的目录，结构体数组，字段同于dir函数
% pathstr: 所有文件和目录的列表
% 
% 典型例子
% thepath='C:\Users\dynamic\Documents';;
% syntax='wav' % 查找所有wav文件
% [pathstruct,pathstr]=dirext(thepath,syntax)
%
% persistent list count
% if isempty(list)
    count=0;
%     list=struct('name',[],'date',[],'bytes',[],'isdir',[],'datenum',[],'path',[]);%{thepath};
% else
%     tmp=length(list);
%     if count>0.8*tmp;
%         list(2*tmp)=list(1);
%     end
% end

filesystem=dir(thepath);
for i=1:length(filesystem)
    file=filesystem(i);
    name=file.name;
    type=file.isdir;    
    if ~strcmpi(name,'.') && ~strcmpi(name,'..')
        count=count+1;
        nextpath=fullfile(thepath,name);
        file.path=nextpath;
        list(count)=file;
        if type
            dirext(nextpath);
        end
    end
end
pathstruct=list(1:count);
if nargin==2
    listpath={pathstruct.path};
    flag=regexp(listpath,syntax);
    pathstruct=pathstruct(~cellfun(@isempty,flag));
end
pathstr={pathstruct.path}';