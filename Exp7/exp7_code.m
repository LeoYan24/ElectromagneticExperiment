% ====================================================
% 二维电位边值问题的有限差分法求解 (矩形域, 直角坐标)
% 方程: d^2φ/dx^2 + d^2φ/dy^2 = -ρ/ε
% ====================================================

clear; clc; close all;

% ---------- 物理与几何参数 ----------
Lx = 1.0;            % x方向长度
Ly = 1.0;            % y方向长度
eps0 = 8.854e-12;    % 真空介电常数 (若ρ=0可忽略)
rho = 0;             % 电荷密度 (C/m^3)，拉普拉斯方程设为0

% ---------- 网格参数 ----------
Nx = 51;             % x方向节点数 (含边界)
Ny = 51;             % y方向节点数 (含边界)
dx = Lx/(Nx-1);      % x方向步长
dy = Ly/(Ny-1);      % y方向步长

% ---------- 初始化 ----------
phi = zeros(Ny, Nx); % 电位矩阵 (行：y, 列：x)

% ---------- 边界条件 ----------
phi(1, :)  = 0.0;    % 下边界
phi(Ny, :) = 0.0;    % 上边界
phi(:, 1)  = 0.0;    % 左边界
phi(:, Nx) = 0.0;    % 右边界

% ---------- 源项（均匀体电荷，泊松方程） ----------
rho = 1e-6;          % 电荷密度 (C/m^3)
f = rho/eps0 * ones(Ny, Nx);

% ---------- 迭代参数 ----------
omega = 1.8;          % 松弛因子 (SOR)
tol = 1e-6;
maxIter = 10000;

% ---------- 迭代求解 (SOR) ----------
for iter = 1:maxIter
    phi_old = phi;
    maxErr = 0;

    for j = 2:Ny-1
        for i = 2:Nx-1
            if dx == dy
                h = dx;
                phi_new = 0.25 * (phi(j, i-1) + phi(j, i+1) + phi(j-1, i) + phi(j+1, i) + h^2 * f(j,i));
            else
                phi_new = ( (phi(j,i-1)+phi(j,i+1))/dx^2 + (phi(j-1,i)+phi(j+1,i))/dy^2 + f(j,i) ) / (2/dx^2 + 2/dy^2);
            end
            phi(j, i) = (1 - omega) * phi(j, i) + omega * phi_new;
            err = abs(phi(j, i) - phi_old(j, i));
            if err > maxErr, maxErr = err; end
        end
    end

    if maxErr < tol
        fprintf('迭代收敛于第 %d 步, 最大误差 = %.2e\n', iter, maxErr);
        break;
    end
end
if iter == maxIter
    fprintf('达到最大迭代次数 %d, 最大误差 = %.2e\n', maxIter, maxErr);
end

% ---------- 后处理与绘图 ----------
x = linspace(0, Lx, Nx);
y = linspace(0, Ly, Ny);
[X, Y] = meshgrid(x, y);

% 确定统一的颜色范围 (由电位数据的最小值和最大值决定)
cmin = min(phi(:));
cmax = max(phi(:));

% 创建图形窗口
figure('Position', [100, 100, 1000, 400]);

% ---- 子图1：三维曲面图 ----
subplot(1, 2, 1);
surf(X, Y, phi);
colormap(jet);
clim([cmin, cmax]);
shading interp;
xlabel('x (m)'); ylabel('y (m)'); zlabel('\phi (V)');
title('电位分布 (3D曲面)');
view(135, 30);
axis tight;

% ---- 子图2：二维等值线填色图 ----
subplot(1, 2, 2);
contourf(X, Y, phi, 20, 'LineColor', 'none');
clim([cmin, cmax]);
xlabel('x (m)'); ylabel('y (m)');
title('电位等值线图');
axis equal tight;

% ---- 添加共用的颜色条 ----
% 在右侧创建一个颜色条，位置与两个子图匹配
hp = get(gcf, 'Position');
cbar = colorbar;
cbar.Label.String = '电位 (V)';
% 将颜色条放在右侧合适位置
cbar.Position = [0.92, 0.15, 0.02, 0.7];
subplot(1,2,1);
daspect([1, 1, 1e4]);   
