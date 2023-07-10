function [ sig_am_demod ] = demod_am_method2(sig_am_receive, fc, fs, t, phi0)
% DEMOD_AM_METHOD2        AM ��ɽ��
% ���������
%       sig_am_receive      AM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                ����ز���ʼ��λ
% ���������
%       sig_am_demod        ���������� sig_am_receive �ȳ�
% @author ľ���ٴ�

% ��һ������������ز�
ct = 2*cos(2*pi*fc*t+phi0);
sig_am_ct = sig_am_receive.*ct;

% �ڶ�������ͨ�˲�(�������ʱ������)
b = fir1(256, fc/(fs/2), 'low');
sig_am_lpf = filter(b,1,[sig_am_ct,zeros(1, fix(length(b)/2))]);
sig_am_lpf = sig_am_lpf(fix(length(b)/2)+1:end);

% ��������ȥ��ֱ������
sig_am_demod = sig_am_lpf - mean(sig_am_lpf);

% ��ͼ
nfft = length(sig_am_ct);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_ct));
subplot(3,2,1);
plot(t(1:plot_length), sig_am_ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��������ز����');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��������ز����˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), sig_am_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ͨ�˲����');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ͨ�˲����˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ȥ��ֱ����������');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ȥ��ֱ����������˫�߷�����');

end