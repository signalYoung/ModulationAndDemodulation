function [ sig_am ] = mod_am(fc, beta, fs, mt, t)
% MOD_AM        AM ����
% ���������
%       fc      �ز�����Ƶ��
%       beta    �������/����ָ��
%       fs      �źŲ�����
%       mt      �����ź�
%       t       ����ʱ��
% ���������
%       sig_am  ����(AM)ʵ�ź�
% @author ľ���ٴ�

% ����ֱ������
A0 = max(abs(mt))/beta;

% �����ź�
ct = cos(2*pi*fc*t);            % �ز��ź�
sig_am = (A0+mt).*ct;           % AM�����ź�

% ��ͼ
nfft = length(sig_am);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_am));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����ź�m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����ź�m(t)˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('��Ƶ�ز�c(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('��Ƶ�ز�c(t)˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_am(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('AM�����ź�s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_am,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('AM�����ź�s(t)˫�߷�����');

end