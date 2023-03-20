clc;
clear all;
close all;

# TASK A

k = 0:0.00001:8;
l = [0.5, 1, 3];
for i = 1:columns(l)
	exponential(i, :) = exppdf(k, l(i));
endfor

colors = "rbg";
figure(1);
hold on;
for i = 1:columns(l)
	plot(k, exponential(i, :), colors(i), "linewidth",1 .2);
endfor
hold off;

title("Probability density function of Exponential processes");
xlabel("k values");
ylabel("Probability");
legend("1/lamba = 0.5", "1/lambda = 1", "1/lambda = 3");



#TASK B

for i = 1:columns(l)
	exponential(i, :) = expcdf(k, l(i));
endfor
colors = "rbg";
figure(2);
hold on;
for i=1:columns(l)
	plot(k, exponential(i, :), colors(i), "linewidth", 1.2);
endfor
hold off;

title("Cumulative Distribution Function of Exponential processes");
xlabel("k values");
ylabel("Probability");
legend("1/lambda = 0.5", "1/lambda = 1", "1/lambda = 3","location","southeast");


#TASK C

l = 2.5;
exponential = expcdf(k, l);
figure(3);
plot(k, exponential, colors(1), “linewidth”, 1.2);
title("Cumulative Distribution Function of Exponential process");
xlabel("k values");
ylabel("Probability");
legend("1/lambda = 2.5", "location","southeast");
