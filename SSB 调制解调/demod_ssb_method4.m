function [ sig_ssb_demod ] = demod_ssb_method4(sig_ssb_receive, fc, t, phi0)
% DEMOD_SSB_METHOD4        SSB ϣ�����ر任���
% ���������
%       sig_ssb_receive     SSB �����źţ�������
%       fc                  �ز�����Ƶ��
%       t                   ����ʱ��
%       phi0                �ز���ʼ��λ
% ���������
%       sig_ssb_demod       ���������� sig_ssb_receive �ȳ�
% @author ľ���ٴ�

% ��һ��������ϣ�����ر任
hsig_ssb_receive = imag(hilbert(sig_ssb_receive));

% �ڶ�����������������ز�
sig_ssb_demod = 2*sig_ssb_receive.*cos(2*pi*fc*t+phi0)+2*hsig_ssb_receive.*sin(2*pi*fc*t+phi0);

end