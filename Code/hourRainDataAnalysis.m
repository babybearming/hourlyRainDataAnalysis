% 程序名: hourRainDataAnalysis.m
%
% 用途:
% 该程序用于大型活动中逐时降水数据分析，选取特定背景时段30年气象资料
% 分析特定日期的逐时降水过程，生成分析表（降水概率、频数）

% 版本信息:
%    日期             编程人员          版本改动描述
% ======   ==========    ================
%  2017.2.17          BBR                V1.0
%
% 变量定义:
% a              --

clear;clc;

% 参数初始化
stationId='54523'; % 需分析站点设置
findStartDate='29-april-2016'; % 设置需要分析的起止日期
findEndDate='29-april-2016';

endDateplus1=datestr(datenum(findEndDate)+1); %需计算夜间20时-次日08时的结果，故往后多加入一天的结果进行计算
theDates=yeilddates(findStartDate,endDateplus1); 
days=length(theDates(:,1));
outRainData=cell(1,days); % 输出各特定日期有降水的年份及逐时降水数据
monthSet=theDates(:,2);
daySet=theDates(:,3);

inputFilePath='../inputData/'; % 数据路径设置
outputFilePath='../result/';
inputFileName=[inputFilePath stationId '.txt'];
outputFileName=[outputFilePath stationId '站' findStartDate '至' findEndDate '降水分析结果.xls'];
startyr=1987;  % 背景时段设置
endyr=2016;
yrnums=endyr-startyr+1;

headerName1={'年份','月份','日期','前一天21时','21-22时','22-23时','23-当天0时','0-1时','1-2时','2-3时','3-4时',...
         	'4-5时','5-6时','6-7时','7-8时','8-9时','9-10时','10-11时','11-12时','12-13时','13-14时','14-15时','15-16时',...
			'16-17时','17-18时','18-19时','19-20时','上午','下午','夜间（昨日20时-当日08时）'};
headerName2={'月份','日期','前一天21时','21-22时','22-23时','23-当天0时','0-1时','1-2时','2-3时','3-4时',...
         	'4-5时','5-6时','6-7时','7-8时','8-9时','9-10时','10-11时','11-12时','12-13时','13-14时','14-15时','15-16时',...
			'16-17时','17-18时','18-19时','19-20时','上午','下午','夜间（昨日20时-当日08时）','夜间（20时-次日08时)'};
			
 %% 数据读取
M=importdata(inputFileName);
rainData=M.data;
rainData=rainData(rainData(:,2)>=startyr&rainData(:,2)<=endyr,:);
 
  for i=1:days
  outRainData{i}=selectRain(monthSet(i),daySet(i),rainData); 
  end
  
  %% 大于阈值降水频数、频率计算

  for i=1:days
      for j=1:27
        [counts0(i,j),Fre0(i,j)]=rainFreCalculate(outRainData{i}(1:end-1,j+3),0,yrnums);  % 出现降水频数及频率计算
        [counts3(i,j),Fre3(i,j)]=rainFreCalculate(outRainData{i}(1:end-1,j+3),3,yrnums);   % 大于3毫米降水频数及频率计算
      end
  end
  
  counts0(1:end-1,28)=counts0(2:end,27);
  Fre0(1:end-1,28)=Fre0(2:end,27);
  counts3(1:end-1,28)=counts3(2:end,27);
  Fre3(1:end-1,28)=Fre3(2:end,27);
  
  
  % 0-3毫米降水频数及频率计算
  
  %% 结果输出保存
  hs1=0;
  for i=1:days
      temp=outRainData{i};
      hs2=length(temp(:,1));
      xlsraindata(hs1+1:hs1+hs2,:)=temp;
      hs1=hs1+hs2;
  end
  
  xlswrite(outputFileName,headerName1,'关注时段提取的逐时降水数据'); xlswrite(outputFileName,xlsraindata,'关注时段提取的逐时降水数据','A2');
  xlswrite(outputFileName,headerName2,'降水频数'); xlswrite(outputFileName,[theDates(:,2:3),counts0],'降水频数','A2');
  xlswrite(outputFileName,headerName2,'降水频率'); xlswrite(outputFileName,[theDates(:,2:3),Fre0],'降水频率','A2');
  xlswrite(outputFileName,headerName2,'大于3毫米降水频数'); xlswrite(outputFileName,[theDates(:,2:3),counts3],'大于3毫米降水频数','A2');
  xlswrite(outputFileName,headerName2,'大于3毫米降水频率'); xlswrite(outputFileName,[theDates(:,2:3),Fre3],'大于3毫米降水频率','A2');
  
  