% Biến đổi Fourier rời rạc (DFT) và cách khôi phục lại tín hiệu.
%% Tín hiệu mẫu
fs   = 1000;                 % tần số lấy mẫu (Hz)
t    = 0:1/fs:2;             % trục thời gian (2 giây)
N    = length(t);            % số điểm dữ liệu
x    = 2.5*sin(2*pi*4*t) + 1.5*sin(2*pi*6.5*t); % tín hiệu gồm 2 sóng sin

%% Tính DFT theo định nghĩa
X = zeros(1,N);              % mảng chứa hệ số Fourier
for k = 1:N
    % sóng cơ sở phức tại "tần số k"
    base = exp(-1i*2*pi*(k-1)*(0:N-1)/N);
    % tích vô hướng giữa tín hiệu và sóng cơ sở
    X(k) = sum(x .* base) / N;
end

%% Phổ biên độ và pha
amp = 2*abs(X);              % phổ biên độ
pha = angle(X);              % phổ pha
f   = linspace(0,fs/2, floor(N/2)+1); % trục tần số

%% Vẽ kết quả
figure(1), clf

% Tín hiệu theo thời gian
subplot(3,1,1)
plot(t,x,'k','LineWidth',1.5)
xlabel('Thời gian (s)'), ylabel('Biên độ')
title('Tín hiệu gốc')

% Phổ biên độ
subplot(3,1,2)
stem(f,amp(1:length(f)),'k','LineWidth',1.5,'MarkerFaceColor','w')
xlabel('Tần số (Hz)'), ylabel('Biên độ')
title('Phổ biên độ')
xlim([0 10])

% Phổ pha
subplot(3,1,3)
stem(f,pha(1:length(f)),'k','LineWidth',1.5,'MarkerFaceColor','w')
xlabel('Tần số (Hz)'), ylabel('Pha (rad)')
title('Phổ pha')
xlim([0 10]), ylim([-pi pi])

%% Tái tạo tín hiệu từ DFT
x_recon = real(ifft(X))*N;   % dùng ifft để khôi phục tín hiệu
figure(2), clf
plot(t,x,'k','LineWidth',1.5), hold on
plot(t(1:5:end),x_recon(1:5:end),'ro') % vẽ tái tạo thưa điểm cho dễ nhìn
legend('Tín hiệu gốc','Tái tạo')
xlabel('Thời gian (s)'), ylabel('Biên độ')
title('So sánh tín hiệu gốc và tái tạo')