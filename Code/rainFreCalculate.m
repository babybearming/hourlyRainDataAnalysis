function [counts,Fre] = rainFreCalculate( inputdata,yuzhi,yrnums )
%���ڼ���һ�����ݴ����ض���ֵ�ĸ�����ռ���򱳾���Ƶ��
%   ����һ�����ݼ���ֵ������Ƶ����Ƶ��
M=inputdata;
yz=yuzhi;
yn=yrnums;
counts=length(M(M>yz));
Fre=counts/yrnums*100.0;
end

