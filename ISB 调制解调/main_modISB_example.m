clc;
clear;
close all;
% ISB ���Ʒ���(�����ź�Ϊȷ֪�źţ����Ʒ�)
% @author ľ���ٴ�

% ���Ʋ���
fm = 2500;              % �����źŲ���
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mut = sin(2*pi*fm*t)+cos(pi*fm*t);
mlt = sin(3*pi*fm*t)+cos(4*pi*fm*t);

% ISB ����
[ sig_isb ] = mod_isb(fc, fs, mut, mlt, t);