function [ sig_pm_demod ] = demod_pm_method1(sig_pm_receive, fc, fs, t, phi0)
% DEMOD_PM_METHOD1        PM 解调(FM 解调积分法)
% 输入参数：
%       sig_pm_receive      PM 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                相干载波初始相位
% 输出参数：
%       sig_pm_demod        解调结果，与 sig_pm_receive 等长
% @author 木三百川

% 第一步：进行 FM 解调
[ sig_pm_demod ] = demod_fm_method4(sig_pm_receive, fc, fs, t, phi0);

% 第二步：对 FM 解调结果进行积分
sig_pm_demod = cumtrapz(t, sig_pm_demod);

% 第三步：去直流
sig_pm_demod = sig_pm_demod - mean(sig_pm_demod);

end