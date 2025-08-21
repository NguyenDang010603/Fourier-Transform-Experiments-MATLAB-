% Dùng FFT nhanh chóng để xem tín hiệu có chứa những tần số nào
% Thông số
fs = 1000;               % tần số lấy mẫu (Hz)
t = 0:1/fs:2;            % vector thời gian (0 đến 2s)
N = length(t);           % số mẫu


% Tín hiệu: 2.5*sin(2π4t) + 1.5*sin(2π6.5t)
x = 2.5*sin(2*pi*4*t) + 1.5*sin(2*pi*6.5*t);

% FFT
X = fft(x)/N;            % chuẩn hóa
amp = 2*abs(X);          % biên độ (nhân 2 vì bỏ nửa phổ)
f = linspace(0,fs/2,N/2+1); % trục tần số (Hz)

% Vẽ tín hiệu trong miền thời gian
figure;
subplot(2,1,1);
plot(t,x,'k','LineWidth',2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Time domain');

% Vẽ phổ biên độ trong miền tần số
subplot(2,1,2);
plot(f,amp(1:length(f)),'r.-','LineWidth',2,'MarkerSize',15);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Frequency domain');
xlim([0 10]); ylim([0 3]);
grid on;
