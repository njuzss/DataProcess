function [pathstruct,pathstr]=dirext(thepath,syntax)
% ʹ�õݹ鷽���г������ָ��Ŀ¼�µ��ļ�
% ����ʹ��dos����õ���ͬ��Ч��
% [~,pathstruct]=system(['dir /B/S ', thepath])
%
% �������
% thepath����Ҫ������Ŀ¼
% syntax��ƥ���﷨����֧������ƥ��
% �����﷨ http://www.cnblogs.com/deerchao/archive/2006/08/24/zhengzhe30fengzhongjiaocheng.html
% .                    ƥ������з�����������ַ�
% \w            ƥ����ĸ�����ֻ��»��߻���
% \s                    ƥ������Ŀհ׷�
% \d                    ƥ������
% \b                    ƥ�䵥�ʵĿ�ʼ�����
% ^                    ƥ���ַ����Ŀ�ʼ
% $                    ƥ���ַ����Ľ���
% *                    �ظ���λ�����
% +                    �ظ�һ�λ�����
% ?                    �ظ���λ�һ��
% {n}                    �ظ�n��
% {n,}                    �ظ�n�λ�����
% {n,m}                    �ظ�n��m��
%
% �������
% pathstruct: ��������Ŀ¼���ṹ�����飬�ֶ�ͬ��dir����
% pathstr: �����ļ���Ŀ¼���б�
% 
% ��������
% thepath='C:\Users\dynamic\Documents';;
% syntax='wav' % ��������wav�ļ�
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