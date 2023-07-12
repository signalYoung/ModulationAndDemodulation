function [ sig_ssb_demod ] = demod_ssb_method4(sig_ssb_receive, fc, t, phi0)
% DEMOD_SSB_METHOD4        SSB 希尔伯特变换解调
% 输入参数：
%       sig_ssb_receive     SSB 接收信号，行向量
%       fc                  载波中心频率
%       t                   采样时间
%       phi0                载波初始相位
% 输出参数：
%       sig_ssb_demod       解调结果，与 sig_ssb_receive 等长
% @author 木三百川

% 第一步：计算希尔伯特变换
hsig_ssb_receive = imag(hilbert(sig_ssb_receive));

% 第二步：乘以正交相干载波
sig_ssb_demod = 2*sig_ssb_receive.*cos(2*pi*fc*t+phi0)+2*hsig_ssb_receive.*sin(2*pi*fc*t+phi0);

end