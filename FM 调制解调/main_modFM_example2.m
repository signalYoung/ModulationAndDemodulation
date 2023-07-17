clc;
clear;
close all;
% FM ���Ʒ���(�����ź�Ϊ����ź�)
% @author ľ���ٴ�

% ���Ʋ���
A = 1;                  % �ز��㶨���
fH = 3000;          	% �����źŴ���
beta = 1e-6;            % ��Ƶָ��/����ָ��
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
W = fH;

% FM ����
[ sig_fm, deltaf ] = mod_fm(fc, beta, fs, mt, t, W, A);
fprintf('���Ƶƫ deltaf = %.6f Hz.\n', deltaf);