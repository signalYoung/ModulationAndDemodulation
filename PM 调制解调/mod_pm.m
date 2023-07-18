function [ sig_pm ] = mod_pm(fc, beta, fs, mt, t, A)
% MOD_PM        PM 调相
% 输入参数：
%       fc      载波中心频率
%       beta    调频指数/调制指数
%       fs      信号采样率
%       mt      调制信号
%       t       采样时间
%       A       载波恒定振幅
% 输出参数：
%       sig_pm  调相(PM)实信号
% @author 木三百川

% 计算调相灵敏度
Kp = beta/max(abs(mt));

% 生成信号
ct = A*cos(2*pi*fc*t);           % 载波 
sig_pm = A*cos(2*pi*fc*t+Kp*mt); % PM调相信号

% 绘图
nfft = length(sig_pm);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_pm));
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
plot(t(1:plot_length), sig_pm(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('PM调相信号s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_pm,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('PM调相信号s(t)双边幅度谱');

end