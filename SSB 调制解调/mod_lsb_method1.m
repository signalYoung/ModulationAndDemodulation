function [ sig_lsb ] = mod_lsb_method1(fc, fs, mt, t)
% MOD_LSB_METHOD1        LSB 下边带调幅（滤波法）
% 输入参数：
%       fc      载波中心频率
%       fs      信号采样率
%       mt      调制信号
%       t       采样时间
% 输出参数：
%       sig_lsb LSB 下边带调幅实信号
% @author 木三百川

% 生成 DSB 信号
ct = cos(2*pi*fc*t);  
sig_dsb = mt.*ct;   % DSB 双边带调幅信号

% 使用理想低通滤波器获得 LSB 信号
sig_lsb = lpf_filter(sig_dsb, fc/(fs/2));

% 绘图
nfft = length(sig_lsb);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_lsb));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('调制信号m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('调制信号m(t)双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), sig_dsb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('DSB双边带调幅信号s(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_dsb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('DSB双边带调幅信号s(t)双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_lsb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('LSB下边带调幅信号s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_lsb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('LSB下边带调幅信号s(t)双边幅度谱');

end