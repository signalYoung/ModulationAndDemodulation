function [ sig_am_demod ] = demod_am_method1(sig_am_receive, fc, fs, t)
% DEMOD_AM_METHOD1        AM ����ɽ��������첨��
% ���������
%       sig_am_receive      AM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
% ���������
%       sig_am_demod        ���������� sig_am_receive �ȳ�
% @author ľ���ٴ�

% ��һ����ȫ������
sig_am_abs = abs(sig_am_receive);

% �ڶ�������ͨ�˲�(�������ʱ������)
b = fir1(256, fc/(fs/2), 'low');
sig_am_lpf = filter(b,1,[sig_am_abs,zeros(1, fix(length(b)/2))]);
sig_am_lpf = sig_am_lpf(fix(length(b)/2)+1:end);

% ��������ȥ��ֱ������
sig_am_demod = sig_am_lpf - mean(sig_am_lpf);

% ��ͼ
nfft = length(sig_am_abs);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_abs));
subplot(3,2,1);
plot(t(1:plot_length), sig_am_abs(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('ȫ���������');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_abs,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('ȫ���������˫�߷�����');

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