function [ sig_fm, deltaf ] = mod_fm(fc, beta, fs, mt, t, W, A)
% MOD_FM        FM 调频
% 输入参数：
%       fc      载波中心频率
%       beta    调频指数/调制指数
%       fs      信号采样率
%       mt      调制信号
%       t       采样时间
%       W       基带信号带宽（最高频率）
%       A       载波恒定振幅
% 输出参数：
%       sig_fm  调频(FM)实信号
%       deltaf  最大频偏
% @author 木三百川

% 计算调频灵敏度及最大频偏
kf = beta*W/max(abs(mt));
deltaf = beta*W;

% 计算调制信号积分
int_mt = cumtrapz(t,mt);

% 生成信号
sig_fm = A*cos(2*pi*fc*t+2*pi*kf*int_mt); % FM调频信号

% 绘图
nfft = length(sig_fm);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('调制信号m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('调制信号m(t)双边幅度谱');

subplot(3,2,3);
plot(t(1:plot_length), int_mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('调制信号m(t)积分');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(int_mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('调制信号m(t)积分双边幅度谱');

subplot(3,2,5);
plot(t(1:plot_length), sig_fm(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('幅度');title('FM调频信号s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('频率/hz');ylabel('幅度/dB');title('FM调频信号s(t)双边幅度谱');

end