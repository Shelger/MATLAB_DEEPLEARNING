clc
P=p';
T=OUTPUT;
echo on;
%对数据进行归一化
[T,T1]=mapminmax(T',0,1)
[P,P1]=mapminmax(p',0,1)
clc
echo off;

%构建神经网络
net=newff(minmax(P),[5,5,1],{'logsig','logsig','purelin'},'trainlm');

%初始化
net=init(net);
%参数设置
net.trainParam.epochs=500; 
net.trainParam.goal=1e-5;
%训练
[net,tr]=train(net,P,T)
pause
clc

%变量筛选MIV算法实现


A=sim(net,P)
E=T-A
EOUT=mapminmax('reverse',E,T1);
MSE=mse(E)
pause
clc
echo off

%用余下数据进行预测
X=x';
Y=y';
[X,X1]=mapminmax('apply',X,P1);
B=sim(net,X)
XOUT=mapminmax('reverse',B,T1);
F=Y-XOUT
pause
clc
echo off

%处理单一因素列数据
G=P';
M=P';
for n=1:5
   G1=1.1*G(:,n);
   G(:,n)=G1;
   G2=0.9*G(:,n);
   M(:,n)=G2;
   GOUT=sim(net,G');
   MOUT=sim(net,M');
   C=GOUT-MOUT;
   eval(['MIV_',num2str(n) ,'=mean(C)'])
end

   
   
   
   
   
   










