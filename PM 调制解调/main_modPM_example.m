clc;
clear;
close all;
% PM 调制仿真(调制信号为确知信号)
% @author 木三百川

% 调制参数
A = 1;                  % 载波恒定振幅
fm = 2500;              % 调制信号参数
beta = 4;               % 调相指数/调制指数
fc = 20000;             % 载波频率
fs = 8*fc;              % 采样率
total_time = 2;         % 仿真时长，单位：秒

% 采样时间
t = 0:1/fs:total_time-1/fs;

% 调制信号为确知信号
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% PM 调制
[ sig_pm ] = mod_pm(fc, beta, fs, mt, t, A);