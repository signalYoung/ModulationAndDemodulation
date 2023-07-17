function [ sig_fm_demod ] = demod_fm_method1(sig_fm_receive, fc, fs, t)
% DEMOD_FM_METHOD1        FM ����ɽ������Ƶ����
% ���������
%       sig_fm_receive      FM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
% ���������
%       sig_fm_demod        ���������� sig_fm_receive �ȳ�
% @author ľ���ٴ�

% ��һ������΢��
sig_dfm = [diff(sig_fm_receive),0];

% �ڶ�����ȫ������
sig_fm_abs = abs(sig_dfm);

% ����������ͨ�˲�
sig_fm_lpf = lpf_filter(sig_fm_abs, fc/2/(fs/2));

% ���Ĳ���ȥ��ֱ������
sig_fm_demod = sig_fm_lpf - mean(sig_fm_lpf);

% ��ͼ
nfft = length(sig_fm_abs);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_abs));
subplot(3,2,1);
plot(t(1:plot_length), sig_fm_abs(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('ȫ���������');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_abs,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('ȫ���������˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), sig_fm_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ͨ�˲����');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ͨ�˲����˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ȥ��ֱ����������');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ȥ��ֱ����������˫�߷�����');

end