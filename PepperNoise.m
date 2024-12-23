function noisyImage = PepperNoise(inputImage, saltProb, pepperProb)
    % 获取输入图像的宽度、高度和通道数
    [height, width, channels] = size(inputImage);
    
    % 初始化输出图像为输入图像
    noisyImage = inputImage;
    
    % 生成两个随机矩阵，用于决定哪些像素将被设置为椒盐噪声
    saltMask = rand(height, width) < saltProb;  % 生成一个 height x width 的矩阵，元素为 0 或 1，概率为 saltProb
    pepperMask = rand(height, width) < pepperProb;  % 生成一个 height x width 的矩阵，元素为 0 或 1，概率为 pepperProb
    
    % 分离图像的三个通道
    redChannel = noisyImage(:, :, 1);    % 红色通道
    greenChannel = noisyImage(:, :, 2);  % 绿色通道
    blueChannel = noisyImage(:, :, 3);   % 蓝色通道
    
    % 将同时满足 saltMask 和 pepperMask 条件的像素设置为黑色（椒）
    redChannel(saltMask & pepperMask) = 0;
    greenChannel(saltMask & pepperMask) = 0;
    blueChannel(saltMask & pepperMask) = 0;
    
    % 将满足 saltMask 但不满足 pepperMask 条件的像素设置为白色（盐）
    redChannel(saltMask & ~pepperMask) = 255;
    greenChannel(saltMask & ~pepperMask) = 255;
    blueChannel(saltMask & ~pepperMask) = 255;
    
    % 将处理后的通道重新组合成输出图像
    noisyImage(:, :, 1) = redChannel;
    noisyImage(:, :, 2) = greenChannel;
    noisyImage(:, :, 3) = blueChannel;
    
    % 返回带椒盐噪声的图像
end
