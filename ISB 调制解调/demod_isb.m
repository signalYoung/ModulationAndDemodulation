function [ sig_isbu_demod,sig_isbl_demod ] = demod_isb(sig_isb_receive, fc, fs, t, phi0)
% DEMOD_ISB                 ISB �����������
% ���������
%       sig_isb_receive     SSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_isbu_demod      �ϱߴ����������� sig_isb_receive �ȳ�
%       sig_isbl_demod      �±ߴ����������� sig_isb_receive �ȳ�
% @author ľ���ٴ�

% ��һ����������������ز�
sig_isb_i = sig_isb_receive.*cos(2*pi*fc*t+phi0);
sig_isb_q = -sig_isb_receive.*sin(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_isb_i_lpf = lpf_filter(sig_isb_i, fc/(fs/2));
sig_isb_q_lpf = lpf_filter(sig_isb_q, fc/(fs/2));

% ������������ϣ�����ر任
sig_isb_q_lpf = imag(hilbert(sig_isb_q_lpf));
sig_isbu_demod = sig_isb_i_lpf-sig_isb_q_lpf;
sig_isbl_demod = sig_isb_i_lpf+sig_isb_q_lpf;

end