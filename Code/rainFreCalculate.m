function [counts,Fre] = rainFreCalculate( inputdata,yuzhi,yrnums )
%用于计算一列数据大于特定数值的个数及占气候背景的频率
%   输入一列数据及阈值，返回频数和频率
M=inputdata;
yz=yuzhi;
yn=yrnums;
counts=length(M(M>yz));
Fre=counts/yrnums*100.0;
end

