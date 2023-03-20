clc;
clear all;
close all;
rand("seed",1)
total_arrivals = 0; # initializing values
current_state = 0;
previous_mean_clients = 0;
index = 0;
sigklisi = false;
transitions = 0;
arrivals = zeros (1, 11);
lambda = 1; #1 or 5 or 10
m = 5;
threshold = lambda/(lambda + m); 

#PART1
#the next lines of code were used for debugging the code
#{
while transitions <= 30
	decision = rand (1);
	transitions = transitions + 1;
	disp(strcat("Current state: ", num2str(current_state)));
	if (current_state == 0 || (decision < threshold && current_state < 10))
		disp("New arrival");
		total_arrivals = total_arrivals + 1;
		arrivals(current_state + 1) = arrivals(current_state + 1) + 1;
		current_state = current_state + 1;
	else
		disp("Departure");
		current_state = current_state – 1;
	endif
	disp(strcat("Total arrivals in the system: ", num2str(total_arrivals)));
	disp("\n");
end
#}



#PART2
while (transitions <= 1000000 && !sigklisi)
	decision = rand (1); #generating a random number between 0 and 1
	transitions = transitions + 1; # the system gets an arrival if it is empty or if the random number is less than the threshold and the system isn't full
#else it gets a departure
	if (current_state == 0 || (decision < threshold && current_state < 11))
		total_arrivals = total_arrivals + 1;
		arrivals(current_state + 1) = arrivals(current_state + 1) + 1;
		current_state = current_state + 1;
	else
		current_state = current_state – 1;
	endif
#every 1000 events we check for convergence
	if mod(transitions, 1000) == 0
		index = index +1; 
		#calculating possibilites and average number of clients in the system
		for i = 1:1:length(arrivals)
			P(i) = arrivals(i)/total_arrivals;
		endfor
		mean_clients = 0;
		for i = 1:1:length(arrivals)
			mean_clients = mean_clients + (i-1) * P(i);
		endfor
		to_plot(index) = mean_clients;
		# convergence check here
		if abs(mean_clients - previous_mean_clients) < 0.00001
			sigklisi = true;
		endif
		previous_mean_clients = mean_clients;
	endif
endwhile
states = zeros(1, length(arrivals));
for i=1:1:length(arrivals)
	states(i) = i – 1;
endfor



figure(1);
subplot(2, 1, 1);
bar(states, P, “b”,0.4);
grid on;
xlabel("State");
ylabel("Probability of each State");
title("Probabilities");
subplot(2, 1, 2);
plot(to_plot,"b","linewidth",1.3);
grid on;
xlabel("Transitions in thousands");
ylabel("Average number of clients");
title("Average number of clients in the M/M/1/10 queue until reaching convergence");