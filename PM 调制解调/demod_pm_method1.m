function [ sig_pm_demod ] = demod_pm_method1(sig_pm_receive, fc, fs, t, phi0)
% DEMOD_PM_METHOD1        PM ���(FM ������ַ�)
% ���������
%       sig_pm_receive      PM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                ����ز���ʼ��λ
% ���������
%       sig_pm_demod        ���������� sig_pm_receive �ȳ�
% @author ľ���ٴ�

% ��һ�������� FM ���
[ sig_pm_demod ] = demod_fm_method4(sig_pm_receive, fc, fs, t, phi0);

% �ڶ������� FM ���������л���
sig_pm_demod = cumtrapz(t, sig_pm_demod);

% ��������ȥֱ��
sig_pm_demod = sig_pm_demod - mean(sig_pm_demod);

end