function sig_hpf = vsbhpf_filter(sig_data, cutfre, cutband)
% VSBHPF_FILTER    �Զ�������ߴ���ͨ�˲���(������������Ϊֱ��)
% ���������
%       sig_data        ���˲�����
%       cutfre          ��ֹƵ�ʣ���Χ (0,1)
%       cutband         ������ȣ���Χ (0,2*cutfre)
% ���������
%       sig_hpf         ��ͨ�˲����
% @author ľ���ٴ�

% ��ͨ�˲���
nfft = length(sig_data);
widx = round(nfft*cutband/4);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
vsbhpf = ones(size(sig_data));
vsbhpf(lidx-widx:lidx+widx) = linspace(1,0,2*widx+1);
vsbhpf(lidx+widx:ridx-widx) = 0;
vsbhpf(ridx-widx:ridx+widx) = linspace(0,1,2*widx+1);

% �˲�
sig_fft_hpf = fftshift(fft(sig_data)).*vsbhpf;
sig_hpf = real(ifft(fftshift(sig_fft_hpf)));

end