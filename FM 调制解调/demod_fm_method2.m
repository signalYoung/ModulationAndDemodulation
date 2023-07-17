function [ sig_fm_demod ] = demod_fm_method2(sig_fm_receive, fs, t)
% DEMOD_FM_METHOD2        FM ����ɽ������Ƶ�� - ϣ�����ر任����
% ���������
%       sig_fm_receive      FM �����źţ�������
%       fs                  �źŲ�����
%       t                   ����ʱ��
% ���������
%       sig_fm_demod        ���������� sig_fm_receive �ȳ�
% @author ľ���ٴ�

% ��һ������΢��
sig_dfm = [diff(sig_fm_receive),0];

% �ڶ����������źŰ���
sig_fm_envelope = abs(hilbert(sig_dfm));

% ��������ȥ��ֱ������
sig_fm_demod = sig_fm_envelope - mean(sig_fm_envelope);

% ��ͼ
nfft = length(sig_fm_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_receive));
subplot(3,2,1);
plot(t(1:plot_length), sig_dfm(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��΢�ֽ��');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_dfm,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��΢�ֽ��˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), sig_fm_envelope(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����źŰ�����');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_envelope,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����źŰ�����˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ȥ��ֱ����������');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ȥ��ֱ����������˫�߷�����');

end