%%
clear all
close all
clc

load(dir('*potentials.mat').name);
data_phi = data;
load(dir('*poincare_gc.mat').name);

% t = round(data{3}.t / 2 / pi, 0);
x = data{3}.x;
y = data{3}.y;


frame_ll = zeros(1024, 1024, 50);
frame_lr = frame_ll;
for i = 1:1024
    for j = 1:1024
        for t = 1:50
            frame_ll(i,j,t) = imag(data_phi(2,i,j) * exp(-1j * t));
            frame_lr(i,j,t) = real((data_phi(3,i,j) - data_phi(4,i,j)) * exp(-2j * t));
        end
    end
end

frame_ur = frame_ll + frame_lr ;
xx = linspace(0, 2*pi, 1024);
%%
t_max = length(data{3}.t)- 10;
[gx, gy] = gradient(frame_ur);
ngx = gx ./ max(gx);
ngy = gy ./ max(gy);
figure('Position', [50 50 1300 700])
n_part = 14;
i = 0;
for tt = 1:2:t_max
i = i + 1;
subplot(5,4,i)
hold on
%contourf(xx, xx, frame_ur(:,:,tt), 25)
%contourf(xx, xx, -gy(:,:,tt), 30)
%contourf(xx, xx, sign(gx(:, :, tt))*abs(gx(:, :, tt)), 25)
contourf(xx, xx, -sign(gy(:, :, tt))*abs(gy(:, :, tt)), 25)
quiver(-gy(:,:,tt), 0.*gy(:,:,tt), 'k', 'LineWidth', 1)
quiver(0.*gx(:,:,tt), gx(:,:,tt), 'k', 'LineWidth', 1)
colormap(brewermap([],"PiYG"))
colorbar
%caxis([min(min(min(frame_ur(:,:,1:t_max)))) max(max(max(frame_ur(:,:,1:t_max))))])
caxis([min(min(min(sign(gy(:, :, t_max))*abs(gy(:, :, t_max))))) max(max(max(sign(gy(:, :, t_max))*abs(gy(:, :, t_max)))))])
%caxis([min(min(min(sign(gx(:, :, t_max))*abs(gx(:, :, t_max))))) max(max(max(sign(gx(:, :, t_max))*abs(gx(:, :, t_max)))))])
plot(x(11:n_part,1:t_max),y(11:n_part,1:t_max), '.r', 'MarkerSize', 10)
plot(x(11:n_part,tt),y(11:n_part,tt), '.b', 'MarkerSize', 15)
xlim([min(min(x(11:n_part,1:tt)))/1.2 max(max(x(11:n_part,1:tt)))*1.2])
%ylim([-0.5 +1])
ylim([min(min(y(11:n_part,1:tt)))/1.2 max(max(y(11:n_part,1:tt)))*1.2])
%drawnow
hold off
end
