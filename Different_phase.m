% So sánh phổ biên độ và phổ pha của 2 tín hiệu sin cùng tần số nhưng lệch pha.
% Hai tín hiệu sin có cùng biên độ (2.5), cùng tần số (10 Hz) nhưng khác pha (0 và π/2).
% Trong miền tần số, phổ biên độ của cả 2 tín hiệu là giống nhau (cột tại 10 Hz với biên độ ≈ 2.5).
% Nhưng phổ pha khác nhau:
% Tín hiệu 1 (pha = 0) → pha tại 10 Hz ≈ 0 rad.
% Tín hiệu 2 (pha = π/2) → pha tại 10 Hz ≈ +π/2 rad.

% Tham số mô phỏng
srate = 1000;       % tần số lấy mẫu (Hz)
time  = 0:1/srate:1; 
N     = length(time);

% Tín hiệu 1 và 2 (cùng biên độ, cùng tần số, khác pha)
signal1 = 2.5*sin(2*pi*10*time + 0);      % pha = 0
signal2 = 2.5*sin(2*pi*10*time + pi/2);   % pha = pi/2

% FFT của 2 tín hiệu
fft1 = fft(signal1)/N;  
fft2 = fft(signal2)/N;

% Chỉ lấy nửa phổ (do FFT đối xứng)
hz = linspace(0, srate/2, floor(N/2)+1);

amp1 = 2*abs(fft1(1:length(hz)));   % phổ biên độ tín hiệu 1
amp2 = 2*abs(fft2(1:length(hz)));   % phổ biên độ tín hiệu 2
pha1 = angle(fft1(1:length(hz)));   % phổ pha tín hiệu 1
pha2 = angle(fft2(1:length(hz)));   % phổ pha tín hiệu 2

% Vẽ kết quả
figure;

subplot(321), plot(time,signal1,'k')
title('Signal 1 (time domain)'), xlabel('Time (s)'), ylabel('Amp')

subplot(322), plot(time,signal2,'k')
title('Signal 2 (time domain)'), xlabel('Time (s)'), ylabel('Amp')

subplot(323), stem(hz,amp1,'k')
title('Signal 1 amplitude spectrum'), xlabel('Hz'), ylabel('Amplitude')
xlim([0 20]), ylim([0 3])

subplot(324), stem(hz,amp2,'k')
title('Signal 2 amplitude spectrum'), xlabel('Hz'), ylabel('Amplitude')
xlim([0 20]), ylim([0 3])

subplot(325), stem(hz,pha1,'k')
title('Signal 1 phase spectrum'), xlabel('Hz'), ylabel('Phase (rad)')
xlim([0 20])

subplot(326), stem(hz,pha2,'k')
title('Signal 2 phase spectrum'), xlabel('Hz'), ylabel('Phase (rad)')
xlim([0 20])
