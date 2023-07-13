clc;
clear;
close all;
% VSB ���Ʒ���(�����ź�Ϊȷ֪�ź�)
% @author ľ���ٴ�

% ���Ʋ���
fm = 2500;              % �����źŲ���
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% VSB ����
[ sig_lvsb ] = mod_lvsb(fc, fs, mt, t); % �����±ߴ�
[ sig_uvsb ] = mod_uvsb(fc, fs, mt, t); % �����ϱߴ�