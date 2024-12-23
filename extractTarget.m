function targetImage = extractTarget(image, background)
    % 将输入图像转换为双精度浮点数
    image = im2double(image);
    
    % 将背景图像转换为双精度浮点数
    background = im2double(background);
    
    % 获取输入图像的高度和宽度
    [height, width, ~] = size(image);
    
    % 调整背景图像的大小以匹配输入图像的尺寸
    background = imresize(background, [height, width]);
    
    % 将背景图像复制成三通道图像，使其与输入图像具有相同的维度
    background = repmat(background, [1, 1, 3]);
    
    % 将输入图像与调整后的背景图像相乘，提取目标区域
    targetImage = image .* background;
    
    % 提取目标
end
