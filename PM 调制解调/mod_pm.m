function [ sig_pm ] = mod_pm(fc, beta, fs, mt, t, A)
% MOD_PM        PM ����
% ���������
%       fc      �ز�����Ƶ��
%       beta    ��Ƶָ��/����ָ��
%       fs      �źŲ�����
%       mt      �����ź�
%       t       ����ʱ��
%       A       �ز��㶨���
% ���������
%       sig_pm  ����(PM)ʵ�ź�
% @author ľ���ٴ�

% �������������
Kp = beta/max(abs(mt));

% �����ź�
ct = A*cos(2*pi*fc*t);           % �ز� 
sig_pm = A*cos(2*pi*fc*t+Kp*mt); % PM�����ź�

% ��ͼ
nfft = length(sig_pm);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_pm));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����ź�m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����ź�m(t)˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), ct(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�ز�c(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(ct,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�ز�c(t)˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_pm(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('PM�����ź�s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_pm,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('PM�����ź�s(t)˫�߷�����');

end