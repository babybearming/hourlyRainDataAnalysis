% ������: hourRainDataAnalysis.m
%
% ��;:
% �ó������ڴ��ͻ����ʱ��ˮ���ݷ�����ѡȡ�ض�����ʱ��30����������
% �����ض����ڵ���ʱ��ˮ���̣����ɷ�������ˮ���ʡ�Ƶ����

% �汾��Ϣ:
%    ����             �����Ա          �汾�Ķ�����
% ======   ==========    ================
%  2017.2.17          BBR                V1.0
%
% ��������:
% a              --

clear;clc;

% ������ʼ��
stationId='54523'; % �����վ������
findStartDate='29-april-2016'; % ������Ҫ��������ֹ����
findEndDate='29-april-2016';

endDateplus1=datestr(datenum(findEndDate)+1); %�����ҹ��20ʱ-����08ʱ�Ľ��������������һ��Ľ�����м���
theDates=yeilddates(findStartDate,endDateplus1); 
days=length(theDates(:,1));
outRainData=cell(1,days); % ������ض������н�ˮ����ݼ���ʱ��ˮ����
monthSet=theDates(:,2);
daySet=theDates(:,3);

inputFilePath='../inputData/'; % ����·������
outputFilePath='../result/';
inputFileName=[inputFilePath stationId '.txt'];
outputFileName=[outputFilePath stationId 'վ' findStartDate '��' findEndDate '��ˮ�������.xls'];
startyr=1987;  % ����ʱ������
endyr=2016;
yrnums=endyr-startyr+1;

headerName1={'���','�·�','����','ǰһ��21ʱ','21-22ʱ','22-23ʱ','23-����0ʱ','0-1ʱ','1-2ʱ','2-3ʱ','3-4ʱ',...
         	'4-5ʱ','5-6ʱ','6-7ʱ','7-8ʱ','8-9ʱ','9-10ʱ','10-11ʱ','11-12ʱ','12-13ʱ','13-14ʱ','14-15ʱ','15-16ʱ',...
			'16-17ʱ','17-18ʱ','18-19ʱ','19-20ʱ','����','����','ҹ�䣨����20ʱ-����08ʱ��'};
headerName2={'�·�','����','ǰһ��21ʱ','21-22ʱ','22-23ʱ','23-����0ʱ','0-1ʱ','1-2ʱ','2-3ʱ','3-4ʱ',...
         	'4-5ʱ','5-6ʱ','6-7ʱ','7-8ʱ','8-9ʱ','9-10ʱ','10-11ʱ','11-12ʱ','12-13ʱ','13-14ʱ','14-15ʱ','15-16ʱ',...
			'16-17ʱ','17-18ʱ','18-19ʱ','19-20ʱ','����','����','ҹ�䣨����20ʱ-����08ʱ��','ҹ�䣨20ʱ-����08ʱ)'};
			
 %% ���ݶ�ȡ
M=importdata(inputFileName);
rainData=M.data;
rainData=rainData(rainData(:,2)>=startyr&rainData(:,2)<=endyr,:);
 
  for i=1:days
  outRainData{i}=selectRain(monthSet(i),daySet(i),rainData); 
  end
  
  %% ������ֵ��ˮƵ����Ƶ�ʼ���

  for i=1:days
      for j=1:27
        [counts0(i,j),Fre0(i,j)]=rainFreCalculate(outRainData{i}(1:end-1,j+3),0,yrnums);  % ���ֽ�ˮƵ����Ƶ�ʼ���
        [counts3(i,j),Fre3(i,j)]=rainFreCalculate(outRainData{i}(1:end-1,j+3),3,yrnums);   % ����3���׽�ˮƵ����Ƶ�ʼ���
      end
  end
  
  counts0(1:end-1,28)=counts0(2:end,27);
  Fre0(1:end-1,28)=Fre0(2:end,27);
  counts3(1:end-1,28)=counts3(2:end,27);
  Fre3(1:end-1,28)=Fre3(2:end,27);
  
  
  % 0-3���׽�ˮƵ����Ƶ�ʼ���
  
  %% ����������
  hs1=0;
  for i=1:days
      temp=outRainData{i};
      hs2=length(temp(:,1));
      xlsraindata(hs1+1:hs1+hs2,:)=temp;
      hs1=hs1+hs2;
  end
  
  xlswrite(outputFileName,headerName1,'��עʱ����ȡ����ʱ��ˮ����'); xlswrite(outputFileName,xlsraindata,'��עʱ����ȡ����ʱ��ˮ����','A2');
  xlswrite(outputFileName,headerName2,'��ˮƵ��'); xlswrite(outputFileName,[theDates(:,2:3),counts0],'��ˮƵ��','A2');
  xlswrite(outputFileName,headerName2,'��ˮƵ��'); xlswrite(outputFileName,[theDates(:,2:3),Fre0],'��ˮƵ��','A2');
  xlswrite(outputFileName,headerName2,'����3���׽�ˮƵ��'); xlswrite(outputFileName,[theDates(:,2:3),counts3],'����3���׽�ˮƵ��','A2');
  xlswrite(outputFileName,headerName2,'����3���׽�ˮƵ��'); xlswrite(outputFileName,[theDates(:,2:3),Fre3],'����3���׽�ˮƵ��','A2');
  
  