function [ sig_dsb_demod ] = demod_dsb_method1(sig_dsb_receive, fc, fs, t, phi0)
% DEMOD_DSB_METHOD1        DSB �����ز�����첨��
% ���������
%       sig_dsb_receive     DSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_dsb_demod       ���������� sig_dsb_receive �ȳ�
% @author ľ���ٴ�

% ��һ���������ز�
A0 = max(abs(sig_dsb_receive))/0.8;
sig_dsb2am = sig_dsb_receive + A0*cos(2*pi*fc*t+phi0);

% �ڶ�����ʹ�� AM ��������н��
[ sig_dsb_demod ] = demod_am_method4(sig_dsb2am, fs, t);

end