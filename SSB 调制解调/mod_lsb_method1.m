function [ sig_lsb ] = mod_lsb_method1(fc, fs, mt, t)
% MOD_LSB_METHOD1        LSB �±ߴ��������˲�����
% ���������
%       fc      �ز�����Ƶ��
%       fs      �źŲ�����
%       mt      �����ź�
%       t       ����ʱ��
% ���������
%       sig_lsb LSB �±ߴ�����ʵ�ź�
% @author ľ���ٴ�

% ���� DSB �ź�
ct = cos(2*pi*fc*t);  
sig_dsb = mt.*ct;   % DSB ˫�ߴ������ź�

% ʹ�������ͨ�˲������ LSB �ź�
sig_lsb = lpf_filter(sig_dsb, fc/(fs/2));

% ��ͼ
nfft = length(sig_lsb);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_lsb));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����ź�m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����ź�m(t)˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), sig_dsb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('DSB˫�ߴ������ź�s(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(sig_dsb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('DSB˫�ߴ������ź�s(t)˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_lsb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('LSB�±ߴ������ź�s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_lsb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('LSB�±ߴ������ź�s(t)˫�߷�����');

end