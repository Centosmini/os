%%%%%%%%%% 随机移移频干扰%%%%%%%%
clear all;close all;clc;

%%%%%%LFM信号%%%%%%%%%%%%%%%%%
T=20e-6;      %脉冲宽度为50us
B=10e6;        %LFM信号带宽
f0=0;      %中频信号
K=B/T;        %调频斜率
fs=40e6;
ts=1/fs;
SampleNum=T*fs;

t=linspace(0,T,SampleNum);
St=(1/sqrt(T))*exp(j*pi*K*t.^2+j*2*pi*f0*t);
Ht=(1/sqrt(T))*exp(-j*pi*K*(T-t).^2+j*2*pi*f0*(t-T));

figure,plot(t,real(St));
xlabel('时间-s');
ylabel('幅度-v');
title('LFM信号');

freq=linspace(-fs/2,fs/2,SampleNum);
figure,
plot(freq,abs(fftshift((fft(St)))));

%%%%%%%%脉冲压缩模块%%%%%%%%%%/max(abs(PulseCompression))
PulseCompression=conv(St,Ht);
Len=length(PulseCompression);
axisX=(1:Len)*ts;

figure,plot(axisX,abs(PulseCompression));

xlabel('时间-s');
ylabel('幅度');
title('LFM信号脉冲压缩后信号');
hold on;

Num=10;
delta_Fre=random('unif',-5,5,1,Num)*1e6;
S_J=zeros(1,length(St));
for i=1:Num
    S_J=S_J+(1/sqrt(T))*exp(j*pi*K*t.^2+j*2*pi*(f0+delta_Fre(i))*t);
end
S_J=S_J+St;

PulseCompression=conv(S_J,Ht);
Len=length(PulseCompression);
axisX=(1:Len)*ts;
figure,
subplot(121)
plot(axisX,abs(PulseCompression))
xlabel('时间-s');
ylabel('幅度');
title('(a)10个随机移频干扰信号')

Num=30;
delta_Fre=random('unif',-5,5,1,Num)*1e6;
S_J=zeros(1,length(St));
for i=1:Num
    S_J=S_J+(1/sqrt(T))*exp(j*pi*K*t.^2+j*2*pi*(f0+delta_Fre(i))*t);
end
S_J=S_J+St;

PulseCompression=conv(S_J,Ht);
Len=length(PulseCompression);
axisX=(1:Len)*ts;

subplot(122)
plot(axisX,abs(PulseCompression));
xlabel('时间-s');
ylabel('幅度');
title('(a)30个随机移频干扰信号');