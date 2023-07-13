function sig_lpf = vsblpf_filter(sig_data, cutfre, cutband)
% VSBLPF_FILTER    �Զ�������ߴ���ͨ�˲���(������������Ϊֱ��)
% ���������
%       sig_data        ���˲�����
%       cutfre          ��ֹƵ�ʣ���Χ (0,1)
%       cutband         ������ȣ���Χ (0,2*cutfre)
% ���������
%       sig_lpf         ��ͨ�˲����
% @author ľ���ٴ�

% ��ͨ�˲���
nfft = length(sig_data);
widx = round(nfft*cutband/4);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
vsblpf = zeros(size(sig_data));
vsblpf(lidx-widx:lidx+widx) = linspace(0,1,2*widx+1);
vsblpf(lidx+widx:ridx-widx) = 1;
vsblpf(ridx-widx:ridx+widx) = linspace(1,0,2*widx+1);

% �˲�
sig_fft_lpf = fftshift(fft(sig_data)).*vsblpf;
sig_lpf = real(ifft(fftshift(sig_fft_lpf)));

end