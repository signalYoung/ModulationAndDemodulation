function [ sig_ssb_demod ] = demod_ssb_method1(sig_ssb_receive, fc, fs, t, phi0)
% DEMOD_SSB_METHOD1        SSB �����ز�����첨��
% ���������
%       sig_ssb_receive     SSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_ssb_demod       ���������� sig_ssb_receive �ȳ�
% @author ľ���ٴ�

% ��һ���������ز�
A0 = max(abs(sig_ssb_receive))/0.8;
sig_ssb2am = sig_ssb_receive + A0*cos(2*pi*fc*t+phi0);

% �ڶ�����ʹ�� AM ��������н��
[ sig_ssb_demod ] = demod_am_method4(sig_ssb2am, fs, t);

end