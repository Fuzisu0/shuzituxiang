function histmatch = myHistogramMatch(img)
% 将输入图像转换为灰度图像
img = myRGBToGray(img);

% 获取图像的高度和宽度
[h, w] = size(img);

% 初始化一个长度为 256 的零向量来存储每个灰度级别的计数
n_1 = zeros(1, 256);

% 计算每个灰度级别的计数
for i = 1:h
    for j = 1:w
        n_1(img(i, j) + 1) = n_1(img(i, j) + 1) + 1;
    end
end

% 计算每个灰度级别的概率
n_1 = n_1 / (h * w);

% 初始化一个长度为 256 的零向量来存储累积概率
p_1 = zeros(1, 256);

% 计算累积概率
for i = 1:256
    for j = 1:i
        p_1(i) = p_1(i) + n_1(j);
    end
end

% 定义目标直方图的概率分布
n_2 = [zeros(1, 50), 0.1, zeros(1, 50), 0.2, zeros(1, 50), 0.3, zeros(1, 50), 0.2, zeros(1, 20), 0.1, zeros(1, 30), 0.1];

% 初始化一个长度为 256 的零向量来存储目标直方图的累积概率
p_2 = zeros(1, 256);

% 计算目标直方图的累积概率
for i = 1:256
    for j = 1:i
        p_2(i) = p_2(i) + n_2(j);
    end
end

% 初始化一个长度为 256 的零向量来存储映射关系
data_1 = zeros(1, 256);

% 找到源图像累积概率与目标直方图累积概率最接近的对应关系
for i = 1:256
    min_diff = abs(p_1(i) - p_2(1));
    for j = 2:256
        if abs(p_1(i) - p_2(j)) < min_diff
            min_diff = abs(p_1(i) - p_2(j));
            data_1(i) = j - 1;
        end
    end
end

% 创建一个新的图像矩阵 histmatch 来存储匹配后的图像
histmatch = img;

% 根据映射关系替换每个像素的灰度值
for i = 1:h
    for j = 1:w
        histmatch(i, j) = data_1(img(i, j) + 1);
    end
end

% 计算匹配后图像的直方图
histmatch = calculateGrayHistogram(histmatch);
