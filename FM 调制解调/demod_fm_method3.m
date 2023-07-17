function [ sig_fm_demod ] = demod_fm_method3(sig_fm_receive, fc, fs, t, phi0)
% DEMOD_FM_METHOD3        FM 相干解调
% 输入参数：
%       sig_fm_receive      FM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                相干载波初始相位
% 输出参数：
%       sig_fm_demod        解调结果，与 sig_fm_receive 等长
% @author 木三百川

% 第一步：乘以相干载波
sig_fm_ct = -sig_fm_receive.*sin(2*pi*fc*t+phi0);

% 第二步：低通滤波
sig_fm_lpf = lpf_filter(sig_fm_ct, fc/(fs/2));

% 第三步：求微分
sig_fm_demod = [diff(sig_fm_lpf),0]*fs;

% 绘图
nfft = length(sig_fm_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_receive));
subplot(3,2,1);
plot(t(1:plot_length), sig_fm_ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('乘以相干载波结果');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('乘以相干载波结果双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), sig_fm_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('低通滤波结果');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('低通滤波结果双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('（求微分）解调结果');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('（求微分）解调结果双边幅度谱');

end