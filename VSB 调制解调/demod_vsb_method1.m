function [ sig_vsb_demod ] = demod_vsb_method1(sig_vsb_receive, fc, fs, t, phi0)
% DEMOD_VSB_METHOD1        VSB �����ز�����첨��
% ���������
%       sig_vsb_receive     VSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_vsb_demod       ���������� sig_vsb_receive �ȳ�
% @author ľ���ٴ�

% ��һ���������ز�
A0 = max(abs(sig_vsb_receive))/0.8;
sig_vsb2am = sig_vsb_receive + A0*cos(2*pi*fc*t+phi0);

% �ڶ�����ʹ�� AM ��������н��
[ sig_vsb_demod ] = demod_am_method4(sig_vsb2am, fs, t);

end