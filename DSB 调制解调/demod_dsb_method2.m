function [ sig_dsb_demod ] = demod_dsb_method2(sig_dsb_receive, fc, fs, t, phi0)
% DEMOD_DSB_METHOD2        DSB ��ɽ����ͬ����⣩
% ���������
%       sig_dsb_receive     DSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_dsb_demod       ���������� sig_dsb_receive �ȳ�
% @author ľ���ٴ�

% ��һ������������ز�
sig_dsbct = 2*sig_dsb_receive.*cos(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_dsb_demod = lpf_filter(sig_dsbct, fc/(fs/2));

end