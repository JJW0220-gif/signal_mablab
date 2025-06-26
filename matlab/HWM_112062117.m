close all;clear all;clc;
%To use this code, please uncomment the part you want to execute before you
%actually run it.
%Use "%" or ctrl+r to comment your code, ctrl+t to uncomment.

%%%%%%%%%%%%%%%%Part 1%%%%%%%%%%%%%%%%
t = -3:1:5;    %t = start:step:end;


x = [0 0 0 1.5 3 2 1 0 0]; 
h = [0 1 2 0 -1 0 0 0 0]; 

figure('Name', 'Signal x(t)', 'NumberTitle', 'off');
%figure:新的繪圖視窗
%'Name', 'Signal x(t)'：設定視窗名稱為 "Signal x(t)"
%'NumberTitle', 'off'：隱藏視窗標題中的數字（預設會顯示 "Figure 1", "Figure 2", ...）
plot(t, x, 'b', 'LineWidth', 2);  %x(t)，'b':藍色曲線, 'LineWidth', 2：設定曲線線條寬度為 2
title('Signal x(t)');
xlabel('t');
ylabel('x(t)');     
grid on;        %開啟網格線

figure('Name', 'Signal h(t)', 'NumberTitle', 'off');
stem(t, h, "filled");
title('Signal h(t)')
xlabel('t');
ylabel('h(t)');
grid on;

y = conv(x,h);
t_conv = (2 * min(t)):(2 * max(t));    % 計算卷積後的新時間軸
figure('Name', 'Signal y(t)', 'NumberTitle', 'off');
plot(t_conv, y, 'LineWidth', 2);
title('Signal y(t)')
xlabel('t');
ylabel('y(t)');
grid on;

