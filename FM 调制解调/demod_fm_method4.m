function [ sig_fm_demod ] = demod_fm_method4(sig_fm_receive, fc, fs, t, phi0)
% DEMOD_FM_METHOD4        FM 数字正交解调/相干解调
% 输入参数：
%       sig_fm_receive      FM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                相干载波初始相位
% 输出参数：
%       sig_fm_demod        解调结果，与 sig_fm_receive 等长
% @author 木三百川

% 第一步：乘以正交相干载波
sig_fm_i = sig_fm_receive.*cos(2*pi*fc*t+phi0);
sig_fm_q = -sig_fm_receive.*sin(2*pi*fc*t+phi0);

% 第二步：低通滤波
sig_fm_i_lpf = lpf_filter(sig_fm_i, fc/(fs/2));
sig_fm_q_lpf = lpf_filter(sig_fm_q, fc/(fs/2));

% 第三步：计算相位
Pt = unwrap(atan2(sig_fm_q_lpf, sig_fm_i_lpf));

% 第四步：计算差分
sig_fm_demod = [diff(Pt),0];

% % 合并第三步与第四步：反正切近似
% sig_fm_demod = (sig_fm_i_lpf(1:end-1).*sig_fm_q_lpf(2:end)-sig_fm_i_lpf(2:end).* ...
%     sig_fm_q_lpf(1:end-1))./(sig_fm_i_lpf(2:end).^2+sig_fm_q_lpf(2:end).^2);
% sig_fm_demod = [sig_fm_demod, sig_fm_demod(end)];

% 绘图
nfft = length(sig_fm_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_receive));
subplot(2,2,1);
plot(t(1:plot_length), sig_fm_i(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('乘以正交相干载波 I 路结果');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_i,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('乘以正交相干载波 I 路结果双边幅度谱');
subplot(2,2,3);
plot(t(1:plot_length), sig_fm_q(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('乘以正交相干载波 Q 路结果');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_q,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('乘以正交相干载波 Q 路结果双边幅度谱');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), sig_fm_i_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('低通滤波 I 路结果');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_i_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('低通滤波 I 路结果双边幅度谱');
subplot(2,2,3);
plot(t(1:plot_length), sig_fm_q_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('低通滤波 Q 路结果');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_q_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('低通滤波 Q 路结果双边幅度谱');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), Pt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('计算相位结果');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(Pt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('计算相位结果双边幅度谱');
subplot(2,2,3);
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('（计算差分）解调结果');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('（计算差分）解调结果双边幅度谱');

end