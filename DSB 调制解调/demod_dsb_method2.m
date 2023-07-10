function [ sig_dsb_demod ] = demod_dsb_method2(sig_dsb_receive, fc, fs, t, phi0)
% DEMOD_DSB_METHOD2        DSB 相干解调（同步检测）
% 输入参数：
%       sig_dsb_receive     DSB 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                载波初始相位
% 输出参数：
%       sig_dsb_demod       解调结果，与 sig_dsb_receive 等长
% @author 木三百川

% 第一步：乘以相干载波
sig_dsbct = 2*sig_dsb_receive.*cos(2*pi*fc*t+phi0);

% 第二步：低通滤波
sig_dsb_demod = lpf_filter(sig_dsbct, fc/(fs/2));

end