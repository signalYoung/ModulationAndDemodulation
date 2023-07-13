function [ sig_uvsb ] = mod_uvsb(fc, fs, mt, t)
% MOD_UVSB        VSB 残留边带调幅（滤波法，残留小部分上边带）
% 输入参数：
%       fc      载波中心频率
%       fs      信号采样率
%       mt      调制信号
%       t       采样时间
% 输出参数：
%       sig_uvsb VSB 残留上边带调幅实信号
% @author 木三百川

% 生成DSB信号
ct = cos(2*pi*fc*t);  
sig_dsb = mt.*ct;   % DSB 双边带调幅信号

% 滤波
sig_uvsb = vsblpf_filter(sig_dsb, fc/(fs/2), 0.2*fc/(fs/2));

% 绘图
nfft = length(sig_uvsb);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_uvsb));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('调制信号m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('调制信号m(t)双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('载波c(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('载波c(t)双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_uvsb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('VSB残留上边带调幅信号s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_uvsb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('VSB残留上边带调幅信号s(t)双边幅度谱');

end