function [ sig_pm_demod ] = demod_pm_method3(sig_pm_receive, fc, fs, t, phi0)
% DEMOD_PM_METHOD4        PM 数字正交解调/相干解调
% 输入参数：
%       sig_pm_receive      PM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                相干载波初始相位
% 输出参数：
%       sig_pm_demod        解调结果，与 sig_pm_receive 等长
% @author 木三百川

% 第一步：乘以正交相干载波
sig_pm_i = sig_pm_receive.*cos(2*pi*fc*t+phi0);
sig_pm_q = -sig_pm_receive.*sin(2*pi*fc*t+phi0);

% 第二步：低通滤波
sig_pm_i_lpf = lpf_filter(sig_pm_i, fc/(fs/2));
sig_pm_q_lpf = lpf_filter(sig_pm_q, fc/(fs/2));

% 第三步：计算相位
sig_pm_demod = unwrap(atan2(sig_pm_q_lpf, sig_pm_i_lpf));

% 第四步：去直流
sig_pm_demod = sig_pm_demod - mean(sig_pm_demod);

end