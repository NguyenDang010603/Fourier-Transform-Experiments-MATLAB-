%2 cách tính phổ trung bình (average spectrum) từ nhiều trial (nhiều lần lặp thí nghiệm)
%Average of Fourier coefficients (complex values) → ave1
%Lấy FFT (hệ số phức) của mỗi trial
%Trung bình trực tiếp các hệ số phức
%Rồi mới lấy biên độ

%Average of amplitudes → ave2
%Lấy FFT của từng trial
%Tính biên độ từng trial
%Rồi mới trung bình các biên độ

% Parameters
ntrials = 100; 
srate   = 200; 
time    = 0:1/srate:1-1/srate; 
pnts    = length(time);

% Tạo dữ liệu: 20 Hz, mỗi trial pha ngẫu nhiên
data = sin(2*pi*20*time + 2*pi*rand(ntrials,1));

% Fourier transform (mỗi trial)
dataX = fft(data,[],2)/pnts;
hz    = linspace(0,srate/2,floor(pnts/2)+1);

% Cách 1: trung bình hệ số phức rồi lấy biên độ
ave1 = 2*abs(mean(dataX));

% Cách 2: lấy biên độ từng trial rồi mới trung bình
ave2 = mean(2*abs(dataX));

% Vẽ
figure, 
subplot(211), plot(time,data,'color',[.7 .7 .7]); hold on
plot(time,mean(data),'k','linew',2)
title('Time domain'), xlabel('Time (s)'), ylabel('Amplitude')

subplot(212), hold on
stem(hz,ave1(1:length(hz)),'ks','linew',2)
stem(hz+.2,ave2(1:length(hz)),'ro','linew',2)
xlim([10 30]), title('Frequency domain')
legend('Avg. coefficients','Avg. amplitudes')
