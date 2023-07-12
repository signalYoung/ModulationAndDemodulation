function [ sig_ssb_demod ] = demod_ssb_method2(sig_ssb_receive, fc, fs, t, phi0)
% DEMOD_SSB_METHOD2        SSB ��ɽ����ͬ����⣩
% ���������
%       sig_ssb_receive     SSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_ssb_demod       ���������� sig_ssb_receive �ȳ�
% @author ľ���ٴ�

% ��һ������������ز�
sig_ssbct = 4*sig_ssb_receive.*cos(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_ssb_demod = lpf_filter(sig_ssbct, fc/(fs/2));

end