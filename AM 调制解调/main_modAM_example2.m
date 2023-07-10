clc;
clear;
close all;
% AM 调制仿真(调制信号为随机信号)
% @author 木三百川

% 调制参数
fH = 3000;          	% 基带信号带宽
beta = 0.8;             % 调幅深度/调制指数
fc = 20000;             % 载波频率
fs = 8*fc;              % 采样率
total_time = 2;         % 仿真时长，单位：秒

% 采样时间
t = 0:1/fs:total_time-1/fs;

% 调制信号为随机信号
mt = randn(size(t));
b = fir1(512, fH/(fs/2), 'low');
mt = filter(b,1,mt);
mt = mt - mean(mt);

% AM 调制
[ sig_am ] = mod_am(fc, beta, fs, mt, t);