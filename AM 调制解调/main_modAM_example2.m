clc;
clear;
close all;
% AM ���Ʒ���(�����ź�Ϊ����ź�)
% @author ľ���ٴ�

% ���Ʋ���
fH = 3000;          	% �����źŴ���
beta = 0.8;             % �������/����ָ��
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊ����ź�
mt = randn(size(t));
b = fir1(512, fH/(fs/2), 'low');
mt = filter(b,1,mt);
mt = mt - mean(mt);

% AM ����
[ sig_am ] = mod_am(fc, beta, fs, mt, t);