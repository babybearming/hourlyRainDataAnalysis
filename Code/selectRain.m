function selectRainData=selectRain(monthSet,daySet,rainData)

%%������ʼ��
findMonth=monthSet;
findDay=daySet;
Data1=rainData;

%% ���ݴ���
Data=Data1(Data1(:,3)==findMonth&Data1(:,4)==findDay&Data1(:,6)>=0.1,:);
stationId=Data(1,1);
year=Data(:,2);
month=Data(:,3);
day=Data(:,4);
time=Data(:,5);
rainData=Data(:,6);
findYear=unique(year);%���ֽ�ˮ�����
yearNums=length(findYear);
outData=zeros(yearNums+1,30);%

for i=1:yearNums
   M=Data1(Data1(:,2)==findYear(i)&Data1(:,3)==findMonth&Data1(:,4)==findDay,6);
   outData(i,1)=findYear(i);
   outData(i,2)=findMonth;
   outData(i,3)=findDay;
   outData(i,4:27)=M';
   outData(i,end-1)=sum(outData(i,22:27));
   outData(i,end-2)=sum(outData(i,16:21));
   outData(i,end)=sum(outData(i,4:15));
end
outData(end,4:end)=sum(outData(1:end-1,4:end),1);
selectRainData=outData;

end
%docHeader={'���','�·�','����','ǰһ��21ʱ','22ʱ','23ʱ','����00ʱ','01ʱ','02ʱ','03ʱ','04ʱ','05ʱ','06ʱ','07ʱ','08ʱ',...
 %   '09ʱ','10ʱ','11ʱ','12ʱ','13ʱ','14ʱ','15ʱ','16ʱ','17ʱ','18ʱ','19ʱ','20ʱ'};
%fileout={docHeader;num2str(outData)};
%xlswrite([num2str(findMonth) '��' num2str(findDay) '��' '.xls'],outData);


