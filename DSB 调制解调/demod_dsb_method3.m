function [ sig_dsb_demod ] = demod_dsb_method3(sig_dsb_receive, fc, fs, t, phi0)
% DEMOD_DSB_METHOD3        DSB �����������������ɽ����ͬ����⣩�ǵ�Ч��
% ���������
%       sig_dsb_receive     DSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_dsb_demod       ���������� sig_dsb_receive �ȳ�
% @author ľ���ٴ�

% ��һ����������������ز�
sig_dsb_i = 2*sig_dsb_receive.*cos(2*pi*fc*t+phi0);
sig_dsb_q = -2*sig_dsb_receive.*sin(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_dsb_i_lpf = lpf_filter(sig_dsb_i, fc/(fs/2));
sig_dsb_q_lpf = lpf_filter(sig_dsb_q, fc/(fs/2));
sig_dsb_demod = sig_dsb_i_lpf;

end