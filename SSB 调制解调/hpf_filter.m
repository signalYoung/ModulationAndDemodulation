function sig_hpf = hpf_filter(sig_data, cutfre)
% HPF_FILTER    �Զ��������ͨ�˲���
% ���������
%       sig_data        ���˲�����
%       cutfre          ��ֹƵ�ʣ���Χ (0,1)
% ���������
%       sig_hpf         ��ͨ�˲����
% @author ľ���ٴ�

nfft = length(sig_data);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
sig_fft_hpf = fftshift(fft(sig_data));
sig_fft_hpf(lidx:ridx) = 0;
sig_hpf = real(ifft(fftshift(sig_fft_hpf)));

end