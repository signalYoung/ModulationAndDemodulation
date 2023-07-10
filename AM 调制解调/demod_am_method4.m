function [ sig_am_demod ] = demod_am_method4(sig_am_receive, fs, t)
% DEMOD_AM_METHOD1        AM 非相干解调（包络检波，Hilbert变换计算包络）
% 输入参数：
%       sig_am_receive      AM 接收信号，行向量
%       fs                  信号采样率
%       t                   采样时间
% 输出参数：
%       sig_am_demod        解调结果，与 sig_am_receive 等长
% @author 木三百川

% 第一步：计算信号包络
sig_am_envelope = abs(hilbert(sig_am_receive));

% 第二步：去除直流分量
sig_am_demod = sig_am_envelope - mean(sig_am_envelope);

% 绘图
nfft = length(sig_am_envelope);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_envelope));
subplot(2,2,1);
plot(t(1:plot_length), sig_am_envelope(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('Hilbert变换计算包络结果');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_envelope,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('Hilbert变换计算包络结果双边幅度谱');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('（去除直流）解调结果');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('（去除直流）解调结果双边幅度谱');

end