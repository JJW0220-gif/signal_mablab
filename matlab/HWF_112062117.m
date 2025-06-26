%%
close all; clear all; clc;
Ts = 0.0001;
t = -5:Ts:5-Ts;

% Basic signals
c_t = cos(2 * pi * 100 * t);;
m_t = cos(pi * t);
s_t = m_t .* c_t;
LPF_t = sin(t) ./ t;
LPF_t(t == 0) = 1;

figure('Name','s(t)','NumberTitle','off');
plot(t,s_t);
title('s(t)');
xlabel('t');
ylabel('s(t)');
grid on;

% Fourier Transform
fs = 1 / Ts;
N = length(t);
omega = (-N/2:N/2-1)*fs/N;
C_jW = fftshift(fft(c_t)) * Ts;   
S_jW = fftshift(fft(s_t)) * Ts;
LPF_jW = double(abs(omega) < 1);;

figure('Name','S(jW)','NumberTitle','off');
plot(omega,abs(S_jW));
title('S(jW)');
xlabel('W');
ylabel('S(jW)');
axis([-150 150 0 10]);
grid on;

% Add AWGN
awgn_noise = 0.1 * randn(size(S_jW));
X_jW = S_jW + awgn_noise;

figure('Name','X(jW)','NumberTitle','off');
plot(omega,abs(X_jW));
title('X(jW)');
xlabel('W');
ylabel('X(jW)');
axis([-150 150 0 10]);
grid on;

% Inverse Fourier Transform
x_t = ifft(ifftshift(X_jW)) * fs;
figure('Name','x(t)','NumberTitle','off');
plot(t,real(x_t));
title('x(t)');
xlabel('t');
ylabel('x(t)');
grid on;

% Demodulation, hint: use conv function
Y_jW = conv(X_jW,  C_jW, 'same') / pi;

figure('Name','Y(jW)','NumberTitle','off');
plot(omega,abs(Y_jW));
title('Y(jW)');
xlabel('W');
ylabel('Y(jW)');
axis([-300 300 0 10]);

% Inverse Fourier Transform
y_t = real(ifft(ifftshift(Y_jW))) * fs; 
figure('Name','y(t)','NumberTitle','off');
plot(t,real(y_t));
title('y(t)');
xlabel('t');
ylabel('y(t)');
grid on;


% LPF
 Z_jW = Y_jW .* LPF_jW / 2 ;   

figure('Name','Z(jW)','NumberTitle','off');
plot(omega,abs(Z_jW));
title('Z(jW)');
xlabel('W');
ylabel('Z(jW)');
axis([-1 1 0 5]);


% Inverse Fourier Transform
z_t = real(ifft(ifftshift(Z_jW))) * fs;  % 還原訊號 z(t)，應該近似 m(t)

figure('Name','z(t)','NumberTitle','off');
plot(t,real(z_t));
title('z(t)');
xlabel('t');
ylabel('z(t)');
grid on;