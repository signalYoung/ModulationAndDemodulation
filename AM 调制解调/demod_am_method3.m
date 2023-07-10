function [ sig_am_demod ] = demod_am_method3(sig_am_receive, fc, fs, t, phi0)
% DEMOD_AM_METHOD3        AM �����������/��ɽ��
% ���������
%       sig_am_receive      AM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                ����ز���ʼ��λ
% ���������
%       sig_am_demod        ���������� sig_am_receive �ȳ�
% @author ľ���ٴ�

% ��һ����������������ز�
sig_am_i = 2*sig_am_receive.*cos(2*pi*fc*t+phi0);
sig_am_q = -2*sig_am_receive.*sin(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�(�������ʱ������)
b = fir1(256, fc/(fs/2), 'low');
sig_am_i_lpf = filter(b,1,[sig_am_i,zeros(1,fix(length(b)/2))]);
sig_am_q_lpf = filter(b,1,[sig_am_q,zeros(1,fix(length(b)/2))]);
sig_am_i_lpf = sig_am_i_lpf(fix(length(b)/2)+1:end);
sig_am_q_lpf = sig_am_q_lpf(fix(length(b)/2)+1:end);

% ���������������
At = sqrt(sig_am_i_lpf.^2 + sig_am_q_lpf.^2);

% ���Ĳ���ȥ��ֱ������
sig_am_demod = At - mean(At);

% ��ͼ
nfft = length(sig_am_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am_receive));
subplot(2,2,1);
plot(t(1:plot_length), sig_am_i(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('������������ز� I ·���');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_i,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('������������ز� I ·���˫�߷�����');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_q(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('������������ز� Q ·���');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_q,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('������������ز� Q ·���˫�߷�����');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), sig_am_i_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ͨ�˲� I ·���');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_i_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ͨ�˲� I ·���˫�߷�����');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_q_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ͨ�˲� Q ·���');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_q_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ͨ�˲� Q ·���˫�߷�����');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), At(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('���������');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(At,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('���������˫�߷�����');
subplot(2,2,3);
plot(t(1:plot_length), sig_am_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ȥ��ֱ����������');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_am_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ȥ��ֱ����������˫�߷�����');

end