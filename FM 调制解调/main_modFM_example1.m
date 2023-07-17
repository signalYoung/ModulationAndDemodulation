clc;
clear;
close all;
% FM ���Ʒ���(�����ź�Ϊȷ֪�ź�)
% @author ľ���ٴ�

% ���Ʋ���
A = 1;                  % �ز��㶨���
fm = 2500;              % �����źŲ���
beta = 1e-6;            % ��Ƶָ��/����ָ��
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mt = sin(2*pi*fm*t)+cos(pi*fm*t);
W = fm;

% FM ����
[ sig_fm, deltaf ] = mod_fm(fc, beta, fs, mt, t, W, A);
fprintf('���Ƶƫ deltaf = %.6f Hz.\n', deltaf);