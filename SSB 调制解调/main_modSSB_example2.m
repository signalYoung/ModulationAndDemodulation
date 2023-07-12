clc;
clear;
close all;
% SSB ���Ʒ���(�����ź�Ϊȷ֪�źţ����Ʒ�)
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

% LSB ����
[ sig_lsb ] = mod_lsb_method2(fc, fs, mt, t);

% USB ����
[ sig_usb ] = mod_usb_method2(fc, fs, mt, t);