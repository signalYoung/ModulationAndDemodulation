function sig_hpf = hpf_filter(sig_data, cutfre)
% HPF_FILTER    自定义理想高通滤波器
% 输入参数：
%       sig_data        待滤波数据
%       cutfre          截止频率，范围 (0,1)
% 输出参数：
%       sig_hpf         高通滤波结果
% @author 木三百川

nfft = length(sig_data);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
sig_fft_hpf = fftshift(fft(sig_data));
sig_fft_hpf(lidx:ridx) = 0;
sig_hpf = real(ifft(fftshift(sig_fft_hpf)));

end