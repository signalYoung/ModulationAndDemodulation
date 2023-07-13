function [ sig_vsb_demod ] = demod_vsb_method2(sig_vsb_receive, fc, fs, t, phi0)
% DEMOD_VSB_METHOD2        VSB ��ɽ����ͬ����⣩
% ���������
%       sig_vsb_receive     VSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_vsb_demod       ���������� sig_vsb_receive �ȳ�
% @author ľ���ٴ�

% ��һ������������ز�
sig_vsbct = 4*sig_vsb_receive.*cos(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_vsb_demod = lpf_filter(sig_vsbct, fc/(fs/2));

end