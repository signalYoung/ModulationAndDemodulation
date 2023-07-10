function [ sig_am_demod ] = demod_am_method4(sig_am_receive, fs, t)
% DEMOD_AM_METHOD1        AM ����ɽ��������첨��Hilbert�任������磩
% ���������
%       sig_am_receive      AM �����źţ�������
%       fs                  �źŲ�����
%       t                   ����ʱ��
% ���������
%       sig_am_demod        ���������� sig_am_receive �ȳ�
% @author ľ���ٴ�

% ��һ���������źŰ���
sig_am_envelope = abs(hilbert(sig_am_receive));

% �ڶ�����ȥ��ֱ������
sig_am_demod = sig_am_envelope - mean(sig_am_envelope);

% ��ͼ
nfft = length(sig_am_envelope);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_envelope));
subplot(2,2,1);
plot(t(1:plot_length), sig_am_envelope(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('Hilbert�任���������');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_envelope,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('Hilbert�任���������˫�߷�����');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ȥ��ֱ����������');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ȥ��ֱ����������˫�߷�����');

end