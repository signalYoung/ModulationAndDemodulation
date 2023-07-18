function [ sig_pm_demod ] = demod_pm_method2(sig_pm_receive, fc, fs, t, phi0)
% DEMOD_PM_METHOD2        PM ���(ϣ��������˲ʱ��λ��)
% ���������
%       sig_pm_receive      PM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                ����ز���ʼ��λ
% ���������
%       sig_pm_demod        ���������� sig_pm_receive �ȳ�
% @author ľ���ٴ�

% ��һ����ʹ��ϣ�����ر任����˲ʱ��λ
inst_phase = unwrap(angle(hilbert(sig_pm_receive)));

% �ڶ�����ȥ���ز�����
sig_pm_demod = inst_phase - 2*pi*fc*t - phi0;

end