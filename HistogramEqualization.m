function histeq = HistogramEqualization(img)
    % 将输入图像转换为灰度图像
    img = RGBToGray(img);

    % 获取图像的高度和宽度
    [h, w] = size(img);

    % 初始化一个长度为 256 的零向量来存储每个灰度级别的概率
    p = zeros(1, 256);

    % 计算每个灰度级别的概率
    for i = 0:255
        % 使用 length 函数计算相同像素的个数，并除以总像素数得到概率
        p(i+1) = length(find(img == i)) / (h * w);
    end

    % 初始化一个长度为 256 的零向量来存储累积概率
    t = zeros(1, 256);

    % 计算累积概率
    for i = 1:256
        for j = 1:i
            % 累加前 i 个灰度级别的概率
            t(i) = p(j) + t(i);
        end
    end

    % 像素点映射
    % 将累积概率乘以 255 并四舍五入得到新的灰度值
    a = round(t * 255);

    % 创建一个新的图像矩阵 b 来存储均衡化后的图像
    b = img;

    % 将原图像中的每个灰度值替换为新的灰度值
    for i = 0:255
        b(img == i) = a(i + 1);
    end

    % 计算均衡化后的直方图
    for i = 0:255
        % 计算每个新灰度级别的概率并存储在 histeq 中
        histeq(i + 1) = sum(p(a == i));
    end
end
