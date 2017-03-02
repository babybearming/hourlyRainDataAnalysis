function selectRainData=selectRain(monthSet,daySet,rainData)

%%参数初始化
findMonth=monthSet;
findDay=daySet;
Data1=rainData;

%% 数据处理
Data=Data1(Data1(:,3)==findMonth&Data1(:,4)==findDay&Data1(:,6)>=0.1,:);
stationId=Data(1,1);
year=Data(:,2);
month=Data(:,3);
day=Data(:,4);
time=Data(:,5);
rainData=Data(:,6);
findYear=unique(year);%出现降水的年份
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
%docHeader={'年份','月份','日期','前一天21时','22时','23时','当天00时','01时','02时','03时','04时','05时','06时','07时','08时',...
 %   '09时','10时','11时','12时','13时','14时','15时','16时','17时','18时','19时','20时'};
%fileout={docHeader;num2str(outData)};
%xlswrite([num2str(findMonth) '月' num2str(findDay) '日' '.xls'],outData);


