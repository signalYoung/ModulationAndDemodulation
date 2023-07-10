clc;
clear;
close all;
% AM 解调仿真(调制信号为确知信号，相干解调)
% @author 木三百川

% 调制参数
fm = 2500;              % 调制信号参数
beta = 0.8;             % 调幅深度/调制指数
fc = 20000;             % 载波频率
fs = 8*fc;              % 采样率
total_time = 2;         % 仿真时长，单位：秒

% 采样时间
t = 0:1/fs:total_time-1/fs;

% 调制信号为确知信号
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% AM 调制
[ sig_am_send ] = mod_am(fc, beta, fs, mt, t);

% 加噪声
snr = 50;               % 信噪比
sig_am_receive = awgn(sig_am_send, snr, 'measured');

% 非相干解调
phi0 = 0;               % 相干载波初相位
[ sig_am_demod ] = demod_am_method2(sig_am_receive, fc, fs, t, phi0);

% 绘图
nfft = length(sig_am_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_am_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('AM接收信号');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('AM接收信号双边幅度谱');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('解调效果');
legend('调制信号','解调信号');

coef = mean(abs(mt))/mean(abs(sig_am_demod));
fprintf('norm(调制信号 - %.2f * 解调信号)/norm(调制信号) = %.4f.\n', coef, norm(mt-coef*sig_am_demod)/norm(mt));