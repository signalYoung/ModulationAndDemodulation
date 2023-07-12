function [ sig_usb ] = mod_usb_method2(fc, fs, mt, t)
% MOD_USB_METHOD2        USB �ϱߴ����������Ʒ���
% ���������
%       fc      �ز�����Ƶ��
%       fs      �źŲ�����
%       mt      �����ź�
%       t       ����ʱ��
% ���������
%       sig_usb USB �ϱߴ�����ʵ�ź�
% @author ľ���ٴ�

% ���� m(t) ��ϣ�����ر任�����ƣ�
hmt = imag(hilbert(mt));

% �������ز���ϳ�
sig_usb = 1/2*mt.*cos(2*pi*fc*t)-1/2*hmt.*sin(2*pi*fc*t);

% ��ͼ
nfft = length(sig_usb);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_usb));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����ź�m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����ź�m(t)˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), hmt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����ź�m(t)ϣ�����ر任');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(hmt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����ź�m(t)ϣ�����ر任˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_usb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('USB�ϱߴ������ź�s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_usb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('USB�ϱߴ������ź�s(t)˫�߷�����');

end