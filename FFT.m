% Mối quan hệ giữa tín hiệu trong miền thời gian và miền tần số, và sự khác biệt giữa:
% Time-domain signal (tín hiệu gốc)
% Amplitude spectrum (phổ biên độ)
% Power spectrum (phổ công suất, tuyến tính và dB)

%% Simple Fourier Transform (fixed & clean)

fs = 1000;                 % sampling rate (Hz)
t  = 0:1/fs:1;             % 1 s (note: N may be odd = 1001)
N  = numel(t);

% signal: DC + 10 Hz sine
x = 1.5 + 2.5*sin(2*pi*10*t);

% FFT
X = fft(x);

% one-sided frequency axis
nHalf = floor(N/2);
f = (0:nHalf) * (fs/N);

% one-sided amplitude (proper normalization)
amp = abs(X(1:nHalf+1))/N;
if rem(N,2)==0            % even N: keep Nyquist bin un-doubled
    amp(2:end-1) = 2*amp(2:end-1);
else                      % odd N: double all non-DC bins
    amp(2:end)   = 2*amp(2:end);
end

% power
pow = amp.^2;

% plots
figure;
subplot(3,1,1);
plot(t,x,'k','LineWidth',1.5);
xlabel('Time (s)'); ylabel('Amplitude'); title('Time domain');

subplot(3,1,2);
plot(f,amp,'o-','LineWidth',1.5); hold on;
plot(f,pow,'s-','LineWidth',1.5);
legend('Amplitude','Power');
xlabel('Frequency (Hz)'); ylabel('Amplitude / Power');
xlim([0 30]); title('Frequency domain');

subplot(3,1,3);
plot(f,10*log10(pow),'d-','LineWidth',1.5);
xlabel('Frequency (Hz)'); ylabel('Power (dB)');
xlim([0 30]); title('Power (dB)');
