function myhistogram = calculateGrayHistogram(img)
% 计算输入图像的灰度直方图
% 输入参数:
%   image - 输入的灰度图像矩阵，假设其大小为 h x w，像素值范围为 0 到 255

% 初始化一个长度为 256 的零向量来存储每个灰度级别的计数
myhistogram = zeros(1, 256);

% 统计每个灰度级别的计数
for k = 1:256
    % 计算当前灰度值的出现次数
    myhistogram(k) = sum(img(:) == (k - 1));
end
end
