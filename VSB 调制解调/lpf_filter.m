function sig_lpf = lpf_filter(sig_data, cutfre)
% LPF_FILTER    �Զ��������ͨ�˲���
% ���������
%       sig_data        ���˲�����
%       cutfre          ��ֹƵ�ʣ���Χ (0,1)
% ���������
%       sig_lpf         ��ͨ�˲����
% @author ľ���ٴ�

nfft = length(sig_data);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
sig_fft_lpf = fftshift(fft(sig_data));
sig_fft_lpf([1:lidx,ridx:nfft]) = 0;
sig_lpf = real(ifft(fftshift(sig_fft_lpf)));

end