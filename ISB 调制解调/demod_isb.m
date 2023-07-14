function [ sig_isbu_demod,sig_isbl_demod ] = demod_isb(sig_isb_receive, fc, fs, t, phi0)
% DEMOD_ISB                 ISB 数字正交解调
% 输入参数：
%       sig_isb_receive     SSB 接收信号，行向量
%       fc                  载波中心频率
%       fs                  信号采样率
%       t                   采样时间
%       phi0                载波初始相位
% 输出参数：
%       sig_isbu_demod      上边带解调结果，与 sig_isb_receive 等长
%       sig_isbl_demod      下边带解调结果，与 sig_isb_receive 等长
% @author 木三百川

% 第一步：乘以正交相干载波
sig_isb_i = sig_isb_receive.*cos(2*pi*fc*t+phi0);
sig_isb_q = -sig_isb_receive.*sin(2*pi*fc*t+phi0);

% 第二步：低通滤波
sig_isb_i_lpf = lpf_filter(sig_isb_i, fc/(fs/2));
sig_isb_q_lpf = lpf_filter(sig_isb_q, fc/(fs/2));

% 第三步：计算希尔伯特变换
sig_isb_q_lpf = imag(hilbert(sig_isb_q_lpf));
sig_isbu_demod = sig_isb_i_lpf-sig_isb_q_lpf;
sig_isbl_demod = sig_isb_i_lpf+sig_isb_q_lpf;

end