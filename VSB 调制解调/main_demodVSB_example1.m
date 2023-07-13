clc;
clear;
close all;
% VSB 解调仿真(调制信号为确知信号，插入载波包络检波法)
% @author 木三百川

% 调制参数
fm = 2500;              % 调制信号参数
fc = 20000;             % 载波频率
fs = 8*fc;              % 采样率
total_time = 2;         % 仿真时长，单位：秒

% 采样时间
t = 0:1/fs:total_time-1/fs;

% 调制信号为确知信号
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% VSB 调制
% [ sig_vsb_send ] = mod_lvsb(fc, fs, mt, t);  % 残留下边带
[ sig_vsb_send ] = mod_uvsb(fc, fs, mt, t);  % 残留上边带

% 加噪声
snr = 50;               % 信噪比
sig_vsb_receive = awgn(sig_vsb_send, snr, 'measured');

% 插入载波包络检波法
phi0 = 0;
[ sig_vsb_demod ] = demod_vsb_method1(sig_vsb_receive, fc, fs, t, phi0);

% 绘图
nfft = length(sig_vsb_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_vsb_receive));
subplot(1,2,1);
plot(t(1:plot_length), sig_vsb_receive(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('VSB接收信号');
subplot(1,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_vsb_receive,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('VSB接收信号双边幅度谱');

figure;set(gcf,'color','w');
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
hold on;
plot(t(1:plot_length), sig_vsb_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('解调效果');
legend('调制信号','解调信号');

coef = mean(abs(mt))/mean(abs(sig_vsb_demod));
fprintf('norm(调制信号 - %.2f * 解调信号)/norm(调制信号) = %.4f.\n', coef, norm(mt-coef*sig_vsb_demod)/norm(mt));