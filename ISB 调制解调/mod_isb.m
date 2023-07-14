function [ sig_isb ] = mod_isb(fc, fs, mut, mlt, t)
% MOD_ISB        ISB 独立边带调制
% 输入参数：
%       fc      载波中心频率
%       fs      信号采样率
%       mut     上边带调制信号
%       mlt     下边带调制信号
%       t       采样时间
% 输出参数：
%       sig_isb ISB 独立边带调幅实信号
% @author 木三百川

% 计算 mu(t) 与 ml(t) 的希尔伯特变换（相移）
hmut = imag(hilbert(mut));
hmlt = imag(hilbert(mlt));

% 与正交载波相合成
sig_isb = (mut+mlt).*cos(2*pi*fc*t)-(hmut-hmlt).*sin(2*pi*fc*t);

% 绘图
nfft = length(sig_isb);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_isb));
subplot(3,2,1);
plot(t(1:plot_length), mut(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('上边带调制信号mu(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mut,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('上边带调制信号mu(t)双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), mlt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('下边带调制信号ml(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(mlt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('下边带调制信号ml(t)双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_isb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('ISB独立边带调幅信号s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_isb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('ISB独立边带调幅信号s(t)双边幅度谱');

end