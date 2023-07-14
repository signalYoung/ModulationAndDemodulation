function [ sig_isb ] = mod_isb(fc, fs, mut, mlt, t)
% MOD_ISB        ISB �����ߴ�����
% ���������
%       fc      �ز�����Ƶ��
%       fs      �źŲ�����
%       mut     �ϱߴ������ź�
%       mlt     �±ߴ������ź�
%       t       ����ʱ��
% ���������
%       sig_isb ISB �����ߴ�����ʵ�ź�
% @author ľ���ٴ�

% ���� mu(t) �� ml(t) ��ϣ�����ر任�����ƣ�
hmut = imag(hilbert(mut));
hmlt = imag(hilbert(mlt));

% �������ز���ϳ�
sig_isb = (mut+mlt).*cos(2*pi*fc*t)-(hmut-hmlt).*sin(2*pi*fc*t);

% ��ͼ
nfft = length(sig_isb);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_isb));
subplot(3,2,1);
plot(t(1:plot_length), mut(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�ϱߴ������ź�mu(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mut,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�ϱߴ������ź�mu(t)˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), mlt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�±ߴ������ź�ml(t)');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(mlt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�±ߴ������ź�ml(t)˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_isb(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('ISB�����ߴ������ź�s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_isb,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('ISB�����ߴ������ź�s(t)˫�߷�����');

end