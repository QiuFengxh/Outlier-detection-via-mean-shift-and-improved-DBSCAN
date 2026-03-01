%% 这个代码是可视化数据集结果的代码
clc;clear;close all
% 读取数据
data = readmatrix('D:\实验4(高密度迭代)\dataset\data_02.csv');
label = data(:,3);
data1 = data(:,1:2);
data = mapminmax(data(:,1:2)', 0, 1)';

% 分离不同标签的数据
idx_0 = label == 0;
idx_1 = label == 1;
data_class0 = data(idx_0, :);
data_class1 = data(idx_1, :);

%% 图1: 绘制所有数据（两类）
figure('Position', [100, 100, 800, 600], 'Color', 'w');

% 绘制标签0的数据点
scatter(data_class0(:,1), data_class0(:,2), 80, [0.2, 0.4, 0.8], 'filled', ...
    'MarkerFaceAlpha', 0.7, 'MarkerEdgeColor', [0.1, 0.2, 0.5], 'LineWidth', 1);
hold on;

% 绘制标签1的数据点
scatter(data_class1(:,1), data_class1(:,2), 80, [0.9, 0.2, 0.2], 'filled', ...
    'MarkerFaceAlpha', 0.7, 'MarkerEdgeColor', [0.6, 0.1, 0.1], 'LineWidth', 1);

% 设置坐标轴
xlabel('Feature 1', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
ylabel('Feature 2', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
title('Classification Results: Two Classes', 'FontSize', 16, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% 添加图例
legend({'Class 0', 'Class 1'}, 'Location', 'best', 'FontSize', 12, ...
    'FontName', 'Times New Roman', 'Box', 'on');

% 设置网格和背景
grid on;
grid minor;
set(gca, 'GridAlpha', 0.15, 'MinorGridAlpha', 0.05);
set(gca, 'FontSize', 12, 'FontName', 'Times New Roman', 'LineWidth', 1.2, 'Box', 'on');

% 设置坐标轴范围（留出边距）
xlim([min(data(:,1))-0.05, max(data(:,1))+0.05]);
ylim([min(data(:,2))-0.05, max(data(:,2))+0.05]);

hold off;

%% 图2: 仅绘制标签0的数据
figure('Position', [150, 150, 800, 600], 'Color', 'w');

% 绘制标签0的数据点
scatter(data_class0(:,1), data_class0(:,2), 100, [0.2, 0.4, 0.8], 'filled', ...
    'MarkerFaceAlpha', 0.75, 'MarkerEdgeColor', [0.1, 0.2, 0.5], 'LineWidth', 1.2);

% 设置坐标轴
xlabel('Feature 1', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
ylabel('Feature 2', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
title('Data Distribution: Class 0', 'FontSize', 16, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% 添加图例
legend({'Class 0'}, 'Location', 'best', 'FontSize', 12, ...
    'FontName', 'Times New Roman', 'Box', 'on');

% 设置网格和背景
grid on;
grid minor;
set(gca, 'GridAlpha', 0.15, 'MinorGridAlpha', 0.05);
set(gca, 'FontSize', 12, 'FontName', 'Times New Roman', 'LineWidth', 1.2, 'Box', 'on');

% 设置坐标轴范围
xlim([min(data_class0(:,1))-0.05, max(data_class0(:,1))+0.05]);
ylim([min(data_class0(:,2))-0.05, max(data_class0(:,2))+0.05]);

% 添加数据统计信息
text_str = sprintf('Sample size: %d', size(data_class0, 1));
text(0.05, 0.95, text_str, 'Units', 'normalized', ...
    'FontSize', 11, 'FontName', 'Times New Roman', ...
    'BackgroundColor', [1 1 1 0.8], 'EdgeColor', [0.2 0.4 0.8], ...
    'LineWidth', 1, 'Margin', 5);

%% 可选：保存高分辨率图像
% 保存图1
% print(gcf, 'classification_two_classes.png', '-dpng', '-r600');
% 
% % 切换到图1并保存
% figure(1);
% print(gcf, 'classification_all_data.png', '-dpng', '-r600');