clc;
clear;
close all;
% AM �������(�����ź�Ϊȷ֪�źţ���ɽ��)
% @author ľ���ٴ�

% ���Ʋ���
fm = 2500;              % �����źŲ���
beta = 0.8;             % �������/����ָ��
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% AM ����
[ sig_am_send ] = mod_am(fc, beta, fs, mt, t);

% ������
snr = 50;               % �����
sig_am_receive = awgn(sig_am_send, snr, 'measured');

% ����ɽ��
phi0 = 0;               % ����ز�����λ
[ sig_am_demod ] = demod_am_method2(sig_am_receive, fc, fs, t, phi0);

% ��ͼ
nfft = length(sig_am_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_am_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('AM�����ź�');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('AM�����ź�˫�߷�����');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('���Ч��');
legend('�����ź�','����ź�');

coef = mean(abs(mt))/mean(abs(sig_am_demod));
fprintf('norm(�����ź� - %.2f * ����ź�)/norm(�����ź�) = %.4f.\n', coef, norm(mt-coef*sig_am_demod)/norm(mt));