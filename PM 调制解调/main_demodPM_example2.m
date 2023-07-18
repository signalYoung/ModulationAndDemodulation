clc;
clear;
close all;
% PM �������(�����ź�Ϊȷ֪�źţ�ϣ��������˲ʱ��λ��)
% @author ľ���ٴ�

% ���Ʋ���
A = 1;                  % �ز��㶨���
fm = 2500;              % �����źŲ���
beta = 4;               % ����ָ��/����ָ��
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% PM ����
[ sig_pm_send ] = mod_pm(fc, beta, fs, mt, t, A);

% ������
snr = 50;               % �����
sig_pm_receive = awgn(sig_pm_send, snr, 'measured');

% ϣ��������˲ʱ��λ��
ini_phase = 0;
[ sig_pm_demod ] = demod_pm_method2(sig_pm_receive, fc, fs, t, ini_phase);

% ��ͼ
nfft = length(sig_pm_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_pm_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_pm_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('PM�����ź�');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_pm_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('PM�����ź�˫�߷�����');

coef = mean(abs(mt))/mean(abs(sig_pm_demod));
fprintf('norm(�����ź� - %.2f * ����ź�)/norm(�����ź�) = %.4f.\n', coef, norm(mt-coef*sig_pm_demod)/norm(mt));

figure;set(gcf,'color','w');
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), coef*sig_pm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('���Ч��');
legend('�����ź�','����ź�(�Ŵ��)');