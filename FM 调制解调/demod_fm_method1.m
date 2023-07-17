function [ sig_fm_demod ] = demod_fm_method1(sig_fm_receive, fc, fs, t)
% DEMOD_FM_METHOD1        FM 非相干解调（鉴频器）
% 输入参数：
%       sig_fm_receive      FM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
% 输出参数：
%       sig_fm_demod        解调结果，与 sig_fm_receive 等长
% @author 木三百川

% 第一步：求微分
sig_dfm = [diff(sig_fm_receive),0];

% 第二步：全波整流
sig_fm_abs = abs(sig_dfm);

% 第三步：低通滤波
sig_fm_lpf = lpf_filter(sig_fm_abs, fc/2/(fs/2));

% 第四步：去除直流分量
sig_fm_demod = sig_fm_lpf - mean(sig_fm_lpf);

% 绘图
nfft = length(sig_fm_abs);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_abs));
subplot(3,2,1);
plot(t(1:plot_length), sig_fm_abs(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('全波整流结果');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_abs,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('全波整流结果双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), sig_fm_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('低通滤波结果');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('低通滤波结果双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('（去除直流）解调结果');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('（去除直流）解调结果双边幅度谱');

end