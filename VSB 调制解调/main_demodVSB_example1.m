clc;
clear;
close all;
% VSB �������(�����ź�Ϊȷ֪�źţ������ز�����첨��)
% @author ľ���ٴ�

% ���Ʋ���
fm = 2500;              % �����źŲ���
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% VSB ����
% [ sig_vsb_send ] = mod_lvsb(fc, fs, mt, t);  % �����±ߴ�
[ sig_vsb_send ] = mod_uvsb(fc, fs, mt, t);  % �����ϱߴ�

% ������
snr = 50;               % �����
sig_vsb_receive = awgn(sig_vsb_send, snr, 'measured');

% �����ز�����첨��
phi0 = 0;
[ sig_vsb_demod ] = demod_vsb_method1(sig_vsb_receive, fc, fs, t, phi0);

% ��ͼ
nfft = length(sig_vsb_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_vsb_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_vsb_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('VSB�����ź�');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_vsb_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('VSB�����ź�˫�߷�����');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_vsb_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('���Ч��');
legend('�����ź�','����ź�');

coef = mean(abs(mt))/mean(abs(sig_vsb_demod));
fprintf('norm(�����ź� - %.2f * ����ź�)/norm(�����ź�) = %.4f.\n', coef, norm(mt-coef*sig_vsb_demod)/norm(mt));