function [ sig_pm_demod ] = demod_pm_method2(sig_pm_receive, fc, fs, t, phi0)
% DEMOD_PM_METHOD2        PM 解调(希尔伯特求瞬时相位法)
% 输入参数：
%       sig_pm_receive      PM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                相干载波初始相位
% 输出参数：
%       sig_pm_demod        解调结果，与 sig_pm_receive 等长
% @author 木三百川

% 第一步：使用希尔伯特变换计算瞬时相位
inst_phase = unwrap(angle(hilbert(sig_pm_receive)));

% 第二步：去除载波分量
sig_pm_demod = inst_phase - 2*pi*fc*t - phi0;

end