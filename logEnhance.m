function logEnhancedImg = logEnhance(img)
    % 将输入图像转换为灰度图像并归一化
    grayImg = im2double(RGBToGray(img));
    
    % 应用对数增强
    logEnhancedImg = log(grayImg + 1);
end
