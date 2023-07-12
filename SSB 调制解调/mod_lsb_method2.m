function [ sig_lsb ] = mod_lsb_method2(fc, fs, mt, t)
% MOD_LSB_METHOD2        LSB 下边带调幅（相移法）
% 输入参数：
%       fc      载波中心频率
%       fs      信号采样率
%       mt      调制信号
%       t       采样时间
% 输出参数：
%       sig_lsb LSB 下边带调幅实信号
% @author 木三百川

% 计算 m(t) 的希尔伯特变换（相移）
hmt = imag(hilbert(mt));

% 与正交载波相合成
sig_lsb = 1/2*mt.*cos(2*pi*fc*t)+1/2*hmt.*sin(2*pi*fc*t);

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
plot(t(1:plot_length), hmt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('调制信号m(t)希尔伯特变换');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(hmt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('调制信号m(t)希尔伯特变换双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_lsb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('LSB下边带调幅信号s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_lsb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('LSB下边带调幅信号s(t)双边幅度谱');

end