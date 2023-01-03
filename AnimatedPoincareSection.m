%%
clear all
close all
clc
interpreter = 'latex';
set(0,'defaulttextinterpreter',interpreter)

PLOT_TRAPPED = 'off'
PLOT_DIFFUSIVE = 'off'
PLOT_BALLISTIC = 'on'

PAUSE = 'on'

PERCENTAGE_OF_TS_SHOWED = 100; % %

TEMPORAL_DISCRETIZATION = 1;

Grid            = 'on';
Modulo          = 'on'
sizes           = [1.25, 2.5, 3.5];                  % 0.5 dots, square
col             = {'.b', '.m', '.k', '-g'};     % un, tr, square, thresh
font_sizes      = [30, 20];

load(dir('*.mat').name);
sy = {'$A$';'$\rho$';'$\eta$';'$R2$'};
caption = sprintf('%s = %.3f; %s = %.3f; %s = %.3f', char(sy(1)), A, char(sy(2)), rho, char(sy(3)), eta);
caption_Diff_Poincare = sprintf('$Diffusive~Particles$  ; %s = %.3f; %s = %.3f; %s = %.3f', char(sy(1)), A, char(sy(2)), rho, char(sy(3)), eta);

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
x = [x_tr; x_diff; x_ball];
y = [y_tr; y_diff; y_ball];
max_time = round(PERCENTAGE_OF_TS_SHOWED / 100 * length(data{2}.t), 0);

x1=0;
x2=2*pi;
y1=0;
y2=2*pi;
xs = [x1, x2, x2, x1, x1];
ys = [y1, y1, y2, y2, y1];

if strcmp(Modulo,'on') == 1



    if strcmp(PLOT_TRAPPED, 'on')
        x_tr = mod(x_tr,2*pi);
        y_tr = mod(y_tr,2*pi);
    end
    if strcmp(PLOT_DIFFUSIVE, 'on')
        x_diff = mod(x_diff,2*pi);
        y_diff = mod(y_diff,2*pi);
    end
    if strcmp(PLOT_BALLISTIC, 'on')
        x_ball = mod(x_ball,2*pi);
        y_ball = mod(y_ball,2*pi);
    end
end
%for i = 16:50
    figure('Position', [10 40 800 740])
    ax = gca;
    ax.FontSize = 0.60*font_sizes(1);
    xlabel('$x$','FontSize',font_sizes(1))
    ylabel('$y$','FontSize',font_sizes(1))
    title(caption,'FontSize', font_sizes(2))
    if strcmp(Modulo, 'off')
        axis vis3d
    end
    hold on
    % l1 = plot(nan, nan, char(col(1)));
    % l2 = plot(nan, nan, char(col(2)));
    % l3 = plot(nan, nan, char(col(3)));
    % l1.MarkerSize = 12;
    % l2.MarkerSize = 12;
    % l3.MarkerSize = 12;
    % %legend([l1, l2, l3], {'trapped particles', 'diffusive particles', 'ballistic particles'},'location','best','FontSize',10);

    if strcmp(Modulo,'on') == 1
        xlim([0 2*pi])
        ylim([0 2*pi])
        xticks([0 pi 2*pi])
        yticks([0 pi 2*pi])
        xticklabels({'0','\pi','2\pi'})
        yticklabels({'0','\pi','2\pi'})
        a = get(gca,'XTickLabel');
        set(gca,'XTickLabel',a,'FontSize',font_sizes(1))
    end
    if strcmp(Grid,'on') == 1
        grid on
    end
    plot(xs, ys, char(col(4)), 'MarkerSize', sizes(2), 'LineWidth', sizes(1));
    for t = 1:TEMPORAL_DISCRETIZATION:max_time

        if strcmp(PLOT_TRAPPED, 'on')
            plot(x_tr(:,1:t), y_tr(:,1:t), char(col(1)), 'MarkerSize', sizes(2));
        end
        if strcmp(PLOT_DIFFUSIVE, 'on')
            plot(x_diff(:,1:t), y_diff(:,1:t), char(col(2)), 'MarkerSize', sizes(2));
        end
        if strcmp(PLOT_BALLISTIC, 'on')
            plot(x_ball(:,1:t), y_ball(:,1:t), char(col(3)), 'MarkerSize', sizes(3));
        end
        %     if strcmp(Modulo, 'off')
        %         xlim([sign(min(min(x(:,1:t))))*abs(min(min(x(:,1:t))))*1.1 max(max(x(:,1:t)))*1.1])
        %         ylim([sign(min(min(y(:,1:t))))*abs(min(min(y(:,1:t))))*1.1 max(max(y(:,1:t)))*1.1])
        %     end
        if strcmp(PAUSE , 'on')
            pause(0.005)
        end

        drawnow limitrate

    end
%end
%
% for t = 1:max_time
%     hold on
%     plot(xs, ys, char(col(4)), 'MarkerSize', sizes(2), 'LineWidth', sizes(2));
%     if strcmp(PLOT_TRAPPED, 'on')
%         plot(x_tr(:,1:max_time), y_tr(:,1:max_time), char(col(1)), 'MarkerSize', sizes(1));
%     end
%     if strcmp(PLOT_DIFFUSIVE, 'on')
%         plot(x_diff(:,1:max_time), y_diff(:,1:max_time), char(col(2)), 'MarkerSize', sizes(1));
%     end
%     if strcmp(PLOT_BALLISTIC, 'on')
%         plot(x_ball(:,1:max_time), y_ball(:,1:max_time), char(col(3)), 'MarkerSize', sizes(1));
%     end
%     drawnow
%     hold off
%     %axis vis3d
% end

%

%
%     for t = 1:max_time
%
%     end
%     x_tr = data{1}.x;
%     y_tr = data{1}.y;
%     r2_diff = data{2}.r2;
%     t_diff = data{2}.t;
%     r2_bal = data{3}.r2;
%     t_bal = data{3}.t;

