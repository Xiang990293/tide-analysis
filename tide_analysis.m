clc; clear;

a = load("h362.csv");

components = load("tide_period_table.csv");
K2 = components(1);
S2 = components(2);
K1 = components(5);
Q1 = components(8);
MF = components(9);

eta0 = 44.759;
t0=	42005.000;

timelabel = string(a(:, 1)) + "/" + string(a(:,2)) + "/" + string(a(:, 3)) + " " + string(a(:,4)) + ":00";
SL = a(:,5);

timelabel_start_index = find(timelabel == "2023/1/1 0:00");
timelabel_end_index = find(timelabel == "2024/8/31 14:00");

time_index = timelabel_start_index:timelabel_end_index;
time = floor((time_index'-1)/24)+1 + a(time_index,4)/24;
needSL = a(time_index);

a(find(a==-32767)) = 0;

plot(time, a(time_index,5), "k");
xticklabels(timelabel(time_index));

A = [linspace(1,1,14607)' cos(2*pi/K2*time'*24)' cos(2*pi/S2*time'*24)' cos(2*pi/K1*time'*24)' cos(2*pi/Q1*time'*24)' cos(2*pi/MF*time'*24)' sin(2*pi/K2*time'*24)' sin(2*pi/S2*time'*24)' sin(2*pi/K1*time'*24)' sin(2*pi/Q1*time'*24)' sin(2*pi/MF*time'*24)'];

C = A\needSL';

