function [ sig_am_demod ] = demod_am_method2(sig_am_receive, fc, fs, t, phi0)
% DEMOD_AM_METHOD2        AM 相干解调
% 输入参数：
%       sig_am_receive      AM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                相干载波初始相位
% 输出参数：
%       sig_am_demod        解调结果，与 sig_am_receive 等长
% @author 木三百川

% 第一步：乘以相干载波
ct = 2*cos(2*pi*fc*t+phi0);
sig_am_ct = sig_am_receive.*ct;

% 第二步：低通滤波(补零进行时延修正)
b = fir1(256, fc/(fs/2), 'low');
sig_am_lpf = filter(b,1,[sig_am_ct,zeros(1, fix(length(b)/2))]);
sig_am_lpf = sig_am_lpf(fix(length(b)/2)+1:end);

% 第三步：去除直流分量
sig_am_demod = sig_am_lpf - mean(sig_am_lpf);

% 绘图
nfft = length(sig_am_ct);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_ct));
subplot(3,2,1);
plot(t(1:plot_length), sig_am_ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('乘以相干载波结果');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('乘以相干载波结果双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), sig_am_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('低通滤波结果');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('低通滤波结果双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('（去除直流）解调结果');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('（去除直流）解调结果双边幅度谱');

end