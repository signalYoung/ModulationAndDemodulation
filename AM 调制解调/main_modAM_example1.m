clc;
clear;
close all;
% AM ���Ʒ���(�����ź�Ϊȷ֪�ź�)
% @author ľ���ٴ�

% ���Ʋ���
fm = 2500;              % �����źŲ���
beta = 0.8;             % �������/����ָ��
fc = 20000;             % �ز�Ƶ��
fs = 8*fc;              % ������
total_time = 2;         % ����ʱ������λ����

% ����ʱ��
t = 0:1/fs:total_time-1/fs;

% �����ź�Ϊȷ֪�ź�
mt = sin(2*pi*fm*t)+cos(pi*fm*t);

% AM ����
[ sig_am ] = mod_am(fc, beta, fs, mt, t);