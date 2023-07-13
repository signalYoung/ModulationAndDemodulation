function sig_hpf = vsbhpf_filter(sig_data, cutfre, cutband)
% VSBHPF_FILTER    自定义残留边带高通滤波器(滚降特性曲线为直线)
% 输入参数：
%       sig_data        待滤波数据
%       cutfre          截止频率，范围 (0,1)
%       cutband         残留宽度，范围 (0,2*cutfre)
% 输出参数：
%       sig_hpf         高通滤波结果
% @author 木三百川

% 高通滤波器
nfft = length(sig_data);
widx = round(nfft*cutband/4);
lidx = round(nfft/2-cutfre*nfft/2);
ridx = nfft - lidx;
vsbhpf = ones(size(sig_data));
vsbhpf(lidx-widx:lidx+widx) = linspace(1,0,2*widx+1);
vsbhpf(lidx+widx:ridx-widx) = 0;
vsbhpf(ridx-widx:ridx+widx) = linspace(0,1,2*widx+1);

% 滤波
sig_fft_hpf = fftshift(fft(sig_data)).*vsbhpf;
sig_hpf = real(ifft(fftshift(sig_fft_hpf)));

end