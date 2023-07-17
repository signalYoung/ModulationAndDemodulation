function [ sig_fm, deltaf ] = mod_fm(fc, beta, fs, mt, t, W, A)
% MOD_FM        FM ��Ƶ
% ���������
%       fc      �ز�����Ƶ��
%       beta    ��Ƶָ��/����ָ��
%       fs      �źŲ�����
%       mt      �����ź�
%       t       ����ʱ��
%       W       �����źŴ������Ƶ�ʣ�
%       A       �ز��㶨���
% ���������
%       sig_fm  ��Ƶ(FM)ʵ�ź�
%       deltaf  ���Ƶƫ
% @author ľ���ٴ�

% �����Ƶ�����ȼ����Ƶƫ
kf = beta*W/max(abs(mt));
deltaf = beta*W;

% ��������źŻ���
int_mt = cumtrapz(t,mt);

% �����ź�
sig_fm = A*cos(2*pi*fc*t+2*pi*kf*int_mt); % FM��Ƶ�ź�

% ��ͼ
nfft = length(sig_fm);
freq = (-nfft/2:nfft/2-1).'*(fs/nfft);
figure;set(gcf,'color','w');
plot_length = min(500, length(sig_fm));
subplot(3,2,1);
plot(t(1:plot_length), mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����ź�m(t)');
subplot(3,2,2);
plot(freq, 10*log10(fftshift(abs(fft(mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����ź�m(t)˫�߷�����');

subplot(3,2,3);
plot(t(1:plot_length), int_mt(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('�����ź�m(t)����');
subplot(3,2,4);
plot(freq, 10*log10(fftshift(abs(fft(int_mt,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('�����ź�m(t)����˫�߷�����');

subplot(3,2,5);
plot(t(1:plot_length), sig_fm(1:plot_length));xlim([t(1),t(plot_length)]);
xlabel('t/s');ylabel('����');title('FM��Ƶ�ź�s(t)');
subplot(3,2,6);
plot(freq, 10*log10(fftshift(abs(fft(sig_fm,nfft)/nfft))+eps));xlim([freq(1),freq(end)]);
xlabel('Ƶ��/hz');ylabel('����/dB');title('FM��Ƶ�ź�s(t)˫�߷�����');

end