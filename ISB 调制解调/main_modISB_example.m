clc;
clear;
close all;
% ISB 调制仿真(调制信号为确知信号，相移法)
% @author 木三百川

% 调制参数
fm = 2500;              % 调制信号参数
fc = 20000;             % 载波频率
fs = 8*fc;              % 采样率
total_time = 2;         % 仿真时长，单位：秒

% 采样时间
t = 0:1/fs:total_time-1/fs;

% 调制信号为确知信号
mut = sin(2*pi*fm*t)+cos(pi*fm*t);
mlt = sin(3*pi*fm*t)+cos(4*pi*fm*t);

% ISB 调制
[ sig_isb ] = mod_isb(fc, fs, mut, mlt, t);