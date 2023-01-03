%Poincare Section
clear all
close all
clc
interpreter = 'latex';
set(0,'defaulttextinterpreter',interpreter)

PLOT_TRAPPED = 'off'
PLOT_DIFFUSIVE = 'off'
PLOT_BALLISTIC = 'on'

PLOT_R2 = 'off'

Grid            = 'on';
Modulo          = 'on';
sizes           = [1.25, 2.5, 3.5];                  % 0.5 dots, square
col             = {'.b', '.m', '.k', '-g'};     % un, tr, square, thresh
font_sizes      = [25, 15];

load(dir('*.mat').name);
sy = {'$A$';'$\rho$';'$\eta$';'$R2$'};
caption = sprintf('%s = %.3f; %s = %.3f; %s = %.3f', char(sy(1)), A, char(sy(2)), rho, char(sy(3)), eta);
caption_Diff_Poincare = sprintf('$Diffusive$  ; %s = %.3f; %s = %.3f; %s = %.3f', char(sy(1)), A, char(sy(2)), rho, char(sy(3)), eta);

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

x1=0;
x2=2*pi;
y1=0;
y2=2*pi;
xs = [x1, x2, x2, x1, x1];
ys = [y1, y1, y2, y2, y1];

if strcmp(Modulo,'on') == 1
    x_tr = mod(x_tr,2*pi);
    y_tr = mod(y_tr,2*pi);
    x_diff = mod(x_diff,2*pi);
    y_diff = mod(y_diff,2*pi);
    x_ball = mod(x_ball,2*pi);
    y_ball = mod(y_ball,2*pi);
end

figure('Position', [5 30 750 740])
plot(xs, ys, char(col(4)), 'MarkerSize', sizes(2), 'LineWidth', sizes(1));
ax = gca;
ax.FontSize = 0.60*font_sizes(1);
axis vis3d
hold on
if strcmp(PLOT_TRAPPED, 'on')
    plot(x_tr, y_tr, char(col(1)), 'MarkerSize', sizes(1));
    %l1 = plot(nan, nan, char(col(1)));
    %legend([l1], {'trapped particles'},'location','best');
end
if strcmp(PLOT_DIFFUSIVE, 'on')
    plot(x_diff, y_diff, char(col(2)), 'MarkerSize', sizes(1));
    %l1 = plot(nan, nan, char(col(1)));
    %l2 = plot(nan, nan, char(col(2)));
    %legend([l1, l2], {'trapped particles', 'diffusive particles'},'location','best');
end
if strcmp(PLOT_BALLISTIC, 'on')
    plot(x_ball, y_ball, char(col(3)), 'MarkerSize', sizes(3));
    
end
l1 = plot(nan, nan, char(col(1)));
l2 = plot(nan, nan, char(col(2)));
l3 = plot(nan, nan, char(col(3)));
l1.MarkerSize = 12;
l2.MarkerSize = 12;
l3.MarkerSize = 12;
legend([l1, l2, l3], {'trapped particles', 'diffusive particles', 'ballistic particles'},'location','best','FontSize',12);
xlabel('$x$','FontSize',font_sizes(1))
ylabel('$y$','FontSize',font_sizes(1))
title(caption,'FontSize', font_sizes(2))
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
hold off

if strcmp(PLOT_BALLISTIC, 'on')
    if strcmp(PLOT_DIFFUSIVE, 'on')
        figure('Position', [760 30 780 740])
        plot(xs, ys, char(col(4)), 'MarkerSize', sizes(2), 'LineWidth', sizes(2));
        ax = gca;
        ax.FontSize = 0.60*font_sizes(1);
        axis vis3d
        hold on
        if strcmp(PLOT_TRAPPED, 'on')
            plot(x_tr, y_tr, char(col(1)), 'MarkerSize', sizes(1));
            l1 = plot(nan, nan, char(col(1)));
            l1.MarkerSize = 12;
            legend([l1], {'trapped particles'},'location','best');
        end
        if strcmp(PLOT_DIFFUSIVE, 'on')
            plot(x_diff, y_diff, char(col(2)), 'MarkerSize', sizes(1));
            l2 = plot(nan, nan, char(col(2)));
            l2.MarkerSize = 12;
            legend([l1, l2], {'trapped particles', 'diffusive particles'},'location','best','FontSize',12);
        end
        xlabel('$x$','FontSize',font_sizes(1))
        ylabel('$y$','FontSize',font_sizes(1))
        title(caption_Diff_Poincare,'FontSize', font_sizes(2))
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
        hold off
    end
end
if strcmp(PLOT_R2, 'on')
if strcmp(PLOT_DIFFUSIVE, 'on')
    t_diff = data{2}.t;
    r2_diff = data{2}.r2;
    t_win_diff = data{2}.t_win;
    r2_win_diff = data{2}.r2_win;
    D_diff = data{2}.diff_data(1);
    Intercept_diff = data{2}.diff_data(2);
    R2_diff = data{2}.diff_data(3);
    r2_fit_diff = D_diff .* t_win_diff + Intercept_diff;
    figure('Position', [760 30 780 300])
    ax = gca;
    ax.FontSize = 0.60*font_sizes(1);
    caption_Diff = sprintf('$r^2~Diffusive$ ; %s = %.3f; %s = %.3f; %s = %.3f; %s = %.3f', char(sy(4)), R2_diff, char(sy(1)), A, char(sy(2)), rho, char(sy(3)), eta);
    %axis('vis3d')
    hold on
    plot(t_diff, r2_diff, 'LineWidth', sizes(2), "DisplayName", 'r^2');
    plot(t_win_diff, r2_win_diff, 'LineWidth', sizes(2), "DisplayName", 'r^2_{win}');
    plot(t_win_diff, r2_fit_diff, 'LineWidth', sizes(2), "DisplayName", 'r^2_{fit}');
    xlabel('$t$','FontSize',font_sizes(1))
    ylabel('$r^2$','FontSize',font_sizes(1))
    title(caption_Diff,'FontSize', font_sizes(2))
    if strcmp(Grid,'on') == 1
        grid on
    end
    legend('location','best')
    hold off
end
if strcmp(PLOT_BALLISTIC, 'on')
    t_ball = data{3}.t;
    r2_ball = data{3}.r2;
    t_win_ball = data{3}.t_win;
    r2_win_ball = data{3}.r2_win;
    r2_fit_ball = data{3}.r2_fit;
    R2_ball = data{3}.interp_data(3);
    figure('Position', [5 30 700 300])
    ax = gca;
    ax.FontSize = 0.60*font_sizes(1);
    caption_ball = sprintf('$r^2~Ballistic$ ; %s = %.3f; %s = %.3f; %s = %.3f; %s = %.3f', char(sy(4)), R2_ball, char(sy(1)), A, char(sy(2)), rho, char(sy(3)), eta);
    %axis('vis3d')
    hold on
    plot(t_ball, r2_ball, 'LineWidth', sizes(2), "DisplayName", 'r^2');
    plot(t_win_ball, r2_win_ball, 'LineWidth', sizes(2), "DisplayName", 'r^2_{win}');
    plot(t_win_ball, r2_fit_ball, 'LineWidth', sizes(2), "DisplayName", 'r^2_{fit}');
    xlabel('$t$','FontSize',font_sizes(1))
    ylabel('$r^2$','FontSize',font_sizes(1))
    title(caption_ball,'FontSize', font_sizes(2))
    if strcmp(Grid,'on') == 1
        grid on
    end
    legend('location','best')
    hold off
end
end

set(0,'defaulttextinterpreter','default')
