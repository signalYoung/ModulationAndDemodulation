function [ sig_dsb_demod ] = demod_dsb_method1(sig_dsb_receive, fc, fs, t, phi0)
% DEMOD_DSB_METHOD1        DSB 插入载波包络检波法
% 输入参数：
%       sig_dsb_receive     DSB 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                载波初始相位
% 输出参数：
%       sig_dsb_demod       解调结果，与 sig_dsb_receive 等长
% @author 木三百川

% 第一步：插入载波
A0 = max(abs(sig_dsb_receive))/0.8;
sig_dsb2am = sig_dsb_receive + A0*cos(2*pi*fc*t+phi0);

% 第二步：使用 AM 解调器进行解调
[ sig_dsb_demod ] = demod_am_method4(sig_dsb2am, fs, t);

end