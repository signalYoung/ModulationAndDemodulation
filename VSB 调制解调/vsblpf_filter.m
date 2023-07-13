function sig_lpf = vsblpf_filter(sig_data, cutfre, cutband)
% VSBLPF_FILTER    自定义残留边带低通滤波器(滚降特性曲线为直线)
% 输入参数：
%       sig_data        待滤波数据
%       cutfre          截止频率，范围 (0,1)
%       cutband         残留宽度，范围 (0,2*cutfre)
% 输出参数：
%       sig_lpf         低通滤波结果
% @author 木三百川

% 低通滤波器
nfft = length(sig_data);
widx = round(nfft*cutband/4);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
vsblpf = zeros(size(sig_data));
vsblpf(lidx-widx:lidx+widx) = linspace(0,1,2*widx+1);
vsblpf(lidx+widx:ridx-widx) = 1;
vsblpf(ridx-widx:ridx+widx) = linspace(1,0,2*widx+1);

% 滤波
sig_fft_lpf = fftshift(fft(sig_data)).*vsblpf;
sig_lpf = real(ifft(fftshift(sig_fft_lpf)));

end