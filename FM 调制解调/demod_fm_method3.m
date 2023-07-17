function [ sig_fm_demod ] = demod_fm_method3(sig_fm_receive, fc, fs, t, phi0)
% DEMOD_FM_METHOD3        FM ��ɽ��
% ���������
%       sig_fm_receive      FM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                ����ز���ʼ��λ
% ���������
%       sig_fm_demod        ���������� sig_fm_receive �ȳ�
% @author ľ���ٴ�

% ��һ������������ز�
sig_fm_ct = -sig_fm_receive.*sin(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_fm_lpf = lpf_filter(sig_fm_ct, fc/(fs/2));

% ����������΢��
sig_fm_demod = [diff(sig_fm_lpf),0]*fs;

% ��ͼ
nfft = length(sig_fm_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_receive));
subplot(3,2,1);
plot(t(1:plot_length), sig_fm_ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��������ز����');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��������ز����˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), sig_fm_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ͨ�˲����');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ͨ�˲����˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('����΢�֣�������');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('����΢�֣�������˫�߷�����');

end