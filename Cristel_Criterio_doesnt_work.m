%Recognise Invariant torus
%%Start
clear all
close all
clc
interpreter = 'latex';
set(0,'defaulttextinterpreter',interpreter)


%%EDITABLE PART
PLOT_TRAPPED = 'on'
PLOT_DIFFUSIVE = 'on'
PLOT_BALLISTIC = 'on'

Grid            = 'on';
sizes           = [1.25, 2.5, 3.5];                  % 0.5 dots, square
col             = {'.b', '.m', '.k', '-g'};     % un, tr, square, thresh
font_sizes      = [25, 15];
%END OF EDITABLE PART

%%lOAD DATA
load(dir('*.mat').name);
sy = {'$A$';'$\rho$';'$\eta$';'$R2$'};
caption = sprintf('%s = %.3f; %s = %.3f; %s = %.3f', char(sy(1)), A, char(sy(2)), rho, char(sy(3)), eta);

x_tr = [];
y_tr = [];
x_diff = [];
y_diff = [];
x_ball = [];
y_ball = [];

if strcmp(PLOT_TRAPPED, 'on')
    x_tr = data{1}.x;
    y_tr = data{1}.y;
end
if strcmp(PLOT_DIFFUSIVE, 'on')
    x_diff = data{2}.x;
    y_diff = data{2}.y;
end
if strcmp(PLOT_BALLISTIC, 'on')
    x_ball = data{3}.x;
    y_ball = data{3}.y;
end

%%Computation
%I make the vectors divisible by two
x_tr(:,end) = [];
y_tr(:,end) = [];
x_diff(:,end) = [];
y_diff(:,end) = [];
x_ball(:,end) = [];
y_ball(:,end) = [];

%n = size(x_ball,2) / 2;
%dummy = nan(1000,ceil(numel(x_ball)./n));
%dummy(1:numel(x_ball)) = x_ball;
%result = nanmedian(dummy)

%v = rand(8812,1);
%b = size(x_ball,2) / 2; % block size
%x_ball_n = numel(x_ball);
%c = mat2cell(x_ball,diff([0:b:x_ball_n-1,x_ball_n]));
%z = cellfun(@median,c);

%I split the vectors
n = size(x_ball,2) / 2;

x_ball_1 = x_ball(:,1:n);
x_ball_2 = x_ball(:,n+1:end);


x_tr_1 = x_tr(:,1:n);
x_tr_2 = x_tr(:,n+1:end);


x_diff_1 = x_diff(:,1:n);
x_diff_2 = x_diff(:,n+1:end);

y_ball_1 = y_ball(:,1:n);
y_ball_2 = y_ball(:,n+1:end);


y_tr_1 = y_tr(:,1:n);
y_tr_2 = y_tr(:,n+1:end);


y_diff_1 = y_diff(:,1:n);
y_diff_2 = y_diff(:,n+1:end);

%I make the average of each piece
x_ball_1_avg = mean(x_ball_1,2);
x_ball_2_avg = mean(x_ball_2,2);

x_tr_1_avg = mean(x_tr_1,2);
x_tr_2_avg = mean(x_tr_2,2);

x_diff_1_avg = mean(x_diff_1,2);
x_diff_2_avg = mean(x_diff_2,2);

y_ball_1_avg = mean(y_ball_1,2);
y_ball_2_avg = mean(y_ball_2,2);

y_tr_1_avg = mean(y_tr_1,2);
y_tr_2_avg = mean(y_tr_2,2);

y_diff_1_avg = mean(y_diff_1,2);
y_diff_2_avg = mean(y_diff_2,2);

%In this case I am interested in the value of Y:

sum_y_ball = y_ball_1_avg + y_ball_2_avg;
diff_y_ball = y_ball_1_avg - y_ball_2_avg;

sum_y_tr = y_tr_1_avg + y_tr_2_avg;
diff_y_tr = y_tr_1_avg - y_tr_2_avg;

sum_y_diff = y_diff_1_avg + y_diff_2_avg;
diff_y_diff = y_diff_1_avg - y_diff_2_avg;

result_y_ball = abs(diff_y_ball ./ sum_y_ball); 
result_y_tr = abs(diff_y_tr ./ sum_y_tr);
result_y_diff = abs(diff_y_diff ./ sum_y_diff);




