function [ sig_ssb_demod ] = demod_ssb_method3(sig_ssb_receive, fc, fs, t, phi0)
% DEMOD_SSB_METHOD3        SSB 数字正交解调，与相干解调（同步检测）是等效的
% 输入参数：
%       sig_ssb_receive     SSB 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                载波初始相位
% 输出参数：
%       sig_ssb_demod       解调结果，与 sig_ssb_receive 等长
% @author 木三百川

% 第一步：乘以正交相干载波
sig_ssb_i = 4*sig_ssb_receive.*cos(2*pi*fc*t+phi0);
sig_ssb_q = -4*sig_ssb_receive.*sin(2*pi*fc*t+phi0);

% 第二步：低通滤波
sig_ssb_i_lpf = lpf_filter(sig_ssb_i, fc/(fs/2));
sig_ssb_q_lpf = lpf_filter(sig_ssb_q, fc/(fs/2));
sig_ssb_demod = sig_ssb_i_lpf;

end