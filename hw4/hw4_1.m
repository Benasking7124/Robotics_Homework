clc
clear all
close all

%import data from exel
input1 = readmatrix("HW4-1.xls", 'Range', 'A2:A51');
input2 = readmatrix("HW4-1.xls", 'Range', 'B2:B51');
output = readmatrix("HW4-1.xls", 'Range', 'C2:C51');

input = [input1, input2];

coeffecient = inv(input' * input) * input' * output;

%plot data point
plot3(input1, input2, output, "*");
hold on;

%plot equation
fg = @(x1, x2) coeffecient(1, 1) * x1 + coeffecient(2, 1) * x2;
fsurf(fg,[0 150 0 150], 'w');