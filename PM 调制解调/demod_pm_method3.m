function [ sig_pm_demod ] = demod_pm_method3(sig_pm_receive, fc, fs, t, phi0)
% DEMOD_PM_METHOD4        PM �����������/��ɽ��
% ���������
%       sig_pm_receive      PM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                ����ز���ʼ��λ
% ���������
%       sig_pm_demod        ���������� sig_pm_receive �ȳ�
% @author ľ���ٴ�

% ��һ����������������ز�
sig_pm_i = sig_pm_receive.*cos(2*pi*fc*t+phi0);
sig_pm_q = -sig_pm_receive.*sin(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_pm_i_lpf = lpf_filter(sig_pm_i, fc/(fs/2));
sig_pm_q_lpf = lpf_filter(sig_pm_q, fc/(fs/2));

% ��������������λ
sig_pm_demod = unwrap(atan2(sig_pm_q_lpf, sig_pm_i_lpf));

% ���Ĳ���ȥֱ��
sig_pm_demod = sig_pm_demod - mean(sig_pm_demod);

end