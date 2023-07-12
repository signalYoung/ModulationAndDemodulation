function [ sig_ssb_demod ] = demod_ssb_method1(sig_ssb_receive, fc, fs, t, phi0)
% DEMOD_SSB_METHOD1        SSB 插入载波包络检波法
% 输入参数：
%       sig_ssb_receive     SSB 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                载波初始相位
% 输出参数：
%       sig_ssb_demod       解调结果，与 sig_ssb_receive 等长
% @author 木三百川

% 第一步：插入载波
A0 = max(abs(sig_ssb_receive))/0.8;
sig_ssb2am = sig_ssb_receive + A0*cos(2*pi*fc*t+phi0);

% 第二步：使用 AM 解调器进行解调
[ sig_ssb_demod ] = demod_am_method4(sig_ssb2am, fs, t);

end