clc;
clear;
close all;
% ISB �������(�����ź�Ϊȷ֪�źţ������������)
% @author ľ���ٴ�

% ���Ʋ���
fm = 2500;              % �����źŲ���
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mut = sin(2*pi*fm*t)+cos(pi*fm*t);
mlt = sin(3*pi*fm*t)+cos(4*pi*fm*t);

% ISB ����
[ sig_isb_send ] = mod_isb(fc, fs, mut, mlt, t);

% ������
snr = 50;               % �����
sig_isb_receive = awgn(sig_isb_send, snr, 'measured');

% �����������
phi0 = 0;
[ sig_isbu_demod,sig_isbl_demod ] = demod_isb(sig_isb_receive, fc, fs, t, phi0);

% ��ͼ
nfft = length(sig_isb_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_isb_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_isb_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('ISB�����ź�');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_isb_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('ISB�����ź�˫�߷�����');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mut(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_isbu_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�ϱߴ����Ч��');
legend('�ϱߴ������ź�','�ϱߴ�����ź�');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mlt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_isbl_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�±ߴ����Ч��');
legend('�±ߴ������ź�','�±ߴ�����ź�');

coefu = mean(abs(mut))/mean(abs(sig_isbu_demod));
fprintf('norm(�ϱߴ������ź� - %.2f * �ϱߴ�����ź�)/norm(�ϱߴ������ź�) = %.4f.\n', coefu, norm(mut-coefu*sig_isbu_demod)/norm(mut));

coefl = mean(abs(mlt))/mean(abs(sig_isbl_demod));
fprintf('norm(�±ߴ������ź� - %.2f * �±ߴ�����ź�)/norm(�±ߴ������ź�) = %.4f.\n', coefl, norm(mlt-coefl*sig_isbl_demod)/norm(mlt));