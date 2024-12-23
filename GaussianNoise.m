function gaussian_img = GaussianNoise(img, a, b)
    [h, w, r] = size(img);
    y = a + b * randn(h, w);
    
    gaussian_img = double(img) / 255; % 将图像转换为双精度并归一化
    gaussian_img = gaussian_img + y;   % 添加高斯噪声
    gaussian_img = gaussian_img * 255;  % 恢复到原始范围
    gaussian_img = uint8(gaussian_img);  % 转换为无符号8位整数
end
