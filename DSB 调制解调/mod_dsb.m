function [ sig_dsb ] = mod_dsb(fc, fs, mt, t)
% MOD_DSB        DSB ˫�ߴ�����
% ���������
%       fc      �ز�����Ƶ��
%       fs      �źŲ�����
%       mt      �����ź�
%       t       ����ʱ��
% ���������
%       sig_dsb DSB ˫�ߴ�����ʵ�ź�
% @author ľ���ٴ�

% �����ź�
ct = cos(2*pi*fc*t);  
sig_dsb = mt.*ct;   % DSB ˫�ߴ������ź�

% ��ͼ
nfft = length(sig_dsb);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_dsb));
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
plot(t(1:plot_length), sig_dsb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('DSB˫�ߴ������ź�s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_dsb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('DSB˫�ߴ������ź�s(t)˫�߷�����');

end