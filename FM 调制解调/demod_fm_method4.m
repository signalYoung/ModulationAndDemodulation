function [ sig_fm_demod ] = demod_fm_method4(sig_fm_receive, fc, fs, t, phi0)
% DEMOD_FM_METHOD4        FM �����������/��ɽ��
% ���������
%       sig_fm_receive      FM �����źţ�������
%       fc                  �ز�����Ƶ��
%       fs                  �źŲ�����
%       t                   ����ʱ��
%       phi0                ����ز���ʼ��λ
% ���������
%       sig_fm_demod        ���������� sig_fm_receive �ȳ�
% @author ľ���ٴ�

% ��һ����������������ز�
sig_fm_i = sig_fm_receive.*cos(2*pi*fc*t+phi0);
sig_fm_q = -sig_fm_receive.*sin(2*pi*fc*t+phi0);

% �ڶ�������ͨ�˲�
sig_fm_i_lpf = lpf_filter(sig_fm_i, fc/(fs/2));
sig_fm_q_lpf = lpf_filter(sig_fm_q, fc/(fs/2));

% ��������������λ
Pt = unwrap(atan2(sig_fm_q_lpf, sig_fm_i_lpf));

% ���Ĳ���������
sig_fm_demod = [diff(Pt),0];

% % �ϲ�����������Ĳ��������н���
% sig_fm_demod = (sig_fm_i_lpf(1:end-1).*sig_fm_q_lpf(2:end)-sig_fm_i_lpf(2:end).* ...
%     sig_fm_q_lpf(1:end-1))./(sig_fm_i_lpf(2:end).^2+sig_fm_q_lpf(2:end).^2);
% sig_fm_demod = [sig_fm_demod, sig_fm_demod(end)];

% ��ͼ
nfft = length(sig_fm_receive);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm_receive));
subplot(2,2,1);
plot(t(1:plot_length), sig_fm_i(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('������������ز� I ·���');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_i,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('������������ز� I ·���˫�߷�����');
subplot(2,2,3);
plot(t(1:plot_length), sig_fm_q(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('������������ز� Q ·���');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_q,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('������������ز� Q ·���˫�߷�����');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), sig_fm_i_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ͨ�˲� I ·���');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_i_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ͨ�˲� I ·���˫�߷�����');
subplot(2,2,3);
plot(t(1:plot_length), sig_fm_q_lpf(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��ͨ�˲� Q ·���');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_q_lpf,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��ͨ�˲� Q ·���˫�߷�����');

figure;set(gcf,'color','w');
subplot(2,2,1);
plot(t(1:plot_length), Pt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('������λ���');
subplot(2,2,2);
plot(freq, 10*log10(fftshift(abs(fft(Pt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('������λ���˫�߷�����');
subplot(2,2,3);
plot(t(1:plot_length), sig_fm_demod(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�������֣�������');
subplot(2,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm_demod,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�������֣�������˫�߷�����');

end