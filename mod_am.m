function [ sig_am ] = mod_am(fc, beta, fs, mt, t)
% MOD_AM        AM 调幅
% 输入参数：
%       fc      载波中心频率
%       beta    调幅深度/调制指数
%       fs      信号采样率
%       mt      调制信号
%       t       采样时间
% 输出参数：
%       sig_am  调幅(AM)实信号
% @author 木三百川

% 计算直流分量
A0 = max(abs(mt))/beta;

% 生成信号
ct = cos(2*pi*fc*t);            % 载波信号
sig_am = (A0+mt).*ct;           % AM调幅信号

% 绘图
nfft = length(sig_am);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('调制信号m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('调制信号m(t)双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('高频载波c(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('高频载波c(t)双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_am(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('AM调幅信号s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_am,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('AM调幅信号s(t)双边幅度谱');

end
