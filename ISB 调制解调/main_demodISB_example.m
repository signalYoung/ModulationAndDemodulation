clc;
clear;
close all;
% ISB 解调仿真(调制信号为确知信号，数字正交解调)
% @author 木三百川

% 调制参数
fm = 2500;              % 调制信号参数
fc = 20000;             % 载波频率
fs = 8*fc;              % 采样率
total_time = 2;         % 仿真时长，单位：秒

% 采样时间
t = 0:1/fs:total_time-1/fs;

% 调制信号为确知信号
mut = sin(2*pi*fm*t)+cos(pi*fm*t);
mlt = sin(3*pi*fm*t)+cos(4*pi*fm*t);

% ISB 调制
[ sig_isb_send ] = mod_isb(fc, fs, mut, mlt, t);

% 加噪声
snr = 50;               % 信噪比
sig_isb_receive = awgn(sig_isb_send, snr, 'measured');

% 数字正交解调
phi0 = 0;
[ sig_isbu_demod,sig_isbl_demod ] = demod_isb(sig_isb_receive, fc, fs, t, phi0);

% 绘图
nfft = length(sig_isb_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_isb_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_isb_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('ISB接收信号');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_isb_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('ISB接收信号双边幅度谱');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mut(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_isbu_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('上边带解调效果');
legend('上边带调制信号','上边带解调信号');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mlt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_isbl_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('下边带解调效果');
legend('下边带调制信号','下边带解调信号');

coefu = mean(abs(mut))/mean(abs(sig_isbu_demod));
fprintf('norm(上边带调制信号 - %.2f * 上边带解调信号)/norm(上边带调制信号) = %.4f.\n', coefu, norm(mut-coefu*sig_isbu_demod)/norm(mut));

coefl = mean(abs(mlt))/mean(abs(sig_isbl_demod));
fprintf('norm(下边带调制信号 - %.2f * 下边带解调信号)/norm(下边带调制信号) = %.4f.\n', coefl, norm(mlt-coefl*sig_isbl_demod)/norm(mlt));