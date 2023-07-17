clc;
clear;
close all;
% FM ���ƽ������(ʹ��Communications Toolbox������)
% @author ľ���ٴ�

% ���Ʋ���
A = 1;                  % �ز��㶨���
fm = 2500;              % �����źŲ���
beta = 1e-6;            % ��Ƶָ��/����ָ��
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% FM ����
freqdev = beta*fm;
ini_phase = 0;
sig_fm_send = A*fmmod(mt, fc, fs, freqdev, ini_phase);

% ������
snr = 150;               % �����
sig_fm_receive = awgn(sig_fm_send, snr, 'measured');

% FM ���
[ sig_fm_demod ] = fmdemod(sig_fm_receive, fc, fs, freqdev, ini_phase);

% ��ͼ
nfft = length(sig_fm_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_fm_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('FM�����ź�');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('FM�����ź�˫�߷�����');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('���Ч��');
legend('�����ź�','����ź�');

fprintf('norm(�����ź� - ����ź�)/norm(�����ź�) = %.4f.\n', norm(mt-sig_fm_demod)/norm(mt));