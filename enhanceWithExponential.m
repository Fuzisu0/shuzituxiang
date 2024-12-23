function expEnhancedImg = enhanceWithExponential(img)
    % 对输入图像进行灰度转换
    grayImg = double(RGBToGray(img));
    
    % 应用指数增强公式
    % 使用 1.5 为基数，0.070 作为缩放因子
    expEnhancedImg = uint8(1.5 .^ (grayImg * 0.070) - 1);
    
    % 注意：输出图像的像素值范围可能需要进一步处理以适应 [0, 255]
end
