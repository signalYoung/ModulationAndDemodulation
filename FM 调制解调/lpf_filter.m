function sig_lpf = lpf_filter(sig_data, cutfre)
% LPF_FILTER    自定义理想低通滤波器
% 输入参数：
%       sig_data        待滤波数据
%       cutfre          截止频率，范围 (0,1)
% 输出参数：
%       sig_lpf         低通滤波结果
% @author 木三百川

nfft = length(sig_data);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
sig_fft_lpf = fftshift(fft(sig_data));
sig_fft_lpf([1:lidx,ridx:nfft]) = 0;
sig_lpf = real(ifft(fftshift(sig_fft_lpf)));

end