function [ sig_am_demod ] = demod_am_method3(sig_am_receive, fc, fs, t, phi0)
% DEMOD_AM_METHOD3        AM 数字正交解调/相干解调
% 输入参数：
%       sig_am_receive      AM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                相干载波初始相位
% 输出参数：
%       sig_am_demod        解调结果，与 sig_am_receive 等长
% @author 木三百川

% 第一步：乘以正交相干载波
sig_am_i = 2*sig_am_receive.*cos(2*pi*fc*t+phi0);
sig_am_q = -2*sig_am_receive.*sin(2*pi*fc*t+phi0);

% 第二步：低通滤波(补零进行时延修正)
b = fir1(256, fc/(fs/2), 'low');
sig_am_i_lpf = filter(b,1,[sig_am_i,zeros(1,fix(length(b)/2))]);
sig_am_q_lpf = filter(b,1,[sig_am_q,zeros(1,fix(length(b)/2))]);
sig_am_i_lpf = sig_am_i_lpf(fix(length(b)/2)+1:end);
sig_am_q_lpf = sig_am_q_lpf(fix(length(b)/2)+1:end);

% 第三步：计算包络
At = sqrt(sig_am_i_lpf.^2 + sig_am_q_lpf.^2);

% 第四步：去除直流分量
sig_am_demod = At - mean(At);

% 绘图
nfft = length(sig_am_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_receive));
subplot(2,2,1);
plot(t(1:plot_length), sig_am_i(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('乘以正交相干载波 I 路结果');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_i,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('乘以正交相干载波 I 路结果双边幅度谱');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_q(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('乘以正交相干载波 Q 路结果');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_q,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('乘以正交相干载波 Q 路结果双边幅度谱');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), sig_am_i_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('低通滤波 I 路结果');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_i_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('低通滤波 I 路结果双边幅度谱');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_q_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('低通滤波 Q 路结果');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_q_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('低通滤波 Q 路结果双边幅度谱');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), At(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('计算包络结果');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(At,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('计算包络结果双边幅度谱');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('（去除直流）解调结果');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('（去除直流）解调结果双边幅度谱');

end