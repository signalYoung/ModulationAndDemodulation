function [ sig_ssb_demod ] = demod_ssb_method3(sig_ssb_receive, fc, fs, t, phi0)
% DEMOD_SSB_METHOD3        SSB �����������������ɽ����ͬ����⣩�ǵ�Ч��
% ���������
%       sig_ssb_receive     SSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_ssb_demod       ���������� sig_ssb_receive �ȳ�
% @author ľ���ٴ�

% ��һ����������������ز�
sig_ssb_i = 4*sig_ssb_receive.*cos(2*pi*fc*t+phi0);
sig_ssb_q = -4*sig_ssb_receive.*sin(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_ssb_i_lpf = lpf_filter(sig_ssb_i, fc/(fs/2));
sig_ssb_q_lpf = lpf_filter(sig_ssb_q, fc/(fs/2));
sig_ssb_demod = sig_ssb_i_lpf;

end