function thedates = yeilddates(startdate,enddate)
% ���ɡ���ʼ���ڡ��͡��������ڡ��м���������ڣ��磺
% >> startdate = '1-feb-2016';
% >> enddate = '31-dec-2016';
% >> thedates = yeilddates(startdate,enddate)
% thedates =
% 
%         2016           2           1
%         2016           2           2
%         ....          ..          ..
%         2016          12          30
%         2016          12          31
thedates = datenum(startdate):datenum(enddate);
thedates = datevec(thedates);
thedates = thedates(:,1:3);
end