%%%%%%%%%% �������Ƶ����%%%%%%%%
clear all;close all;clc;

%%%%%%LFM�ź�%%%%%%%%%%%%%%%%%
T=20e-6;      %������Ϊ50us
B=10e6;        %LFM�źŴ���
f0=0;      %��Ƶ�ź�
K=B/T;        %��Ƶб��
fs=40e6;
ts=1/fs;
SampleNum=T*fs;

t=linspace(0,T,SampleNum);
St=(1/sqrt(T))*exp(j*pi*K*t.^2+j*2*pi*f0*t);
Ht=(1/sqrt(T))*exp(-j*pi*K*(T-t).^2+j*2*pi*f0*(t-T));

figure,plot(t,real(St));
xlabel('ʱ��-s');
ylabel('����-v');
title('LFM�ź�');

freq=linspace(-fs/2,fs/2,SampleNum);
figure,
plot(freq,abs(fftshift((fft(St)))));

%%%%%%%%����ѹ��ģ��%%%%%%%%%%/max(abs(PulseCompression))
PulseCompression=conv(St,Ht);
Len=length(PulseCompression);
axisX=(1:Len)*ts;

figure,plot(axisX,abs(PulseCompression));

xlabel('ʱ��-s');
ylabel('����');
title('LFM�ź�����ѹ�����ź�');
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
xlabel('ʱ��-s');
ylabel('����');
title('(a)10�������Ƶ�����ź�')

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
xlabel('ʱ��-s');
ylabel('����');
title('(a)30�������Ƶ�����ź�');