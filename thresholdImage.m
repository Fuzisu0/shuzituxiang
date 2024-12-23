function thresholdedImage = thresholdImage(inputImage)
    % 将输入图像转换为灰度图像
    grayImage = RGBToGray(inputImage);
    
    % 定义线性变换后的范围
    lowerBound = 0;
    upperBound = 255;
    
    % 获取灰度图像的最小和最大灰度值
    minGrayValue = min(min(grayImage));
    maxGrayValue = max(max(grayImage));
    
    % 应用线性变换
    thresholdedImage = lowerBound + (upperBound - lowerBound) / (maxGrayValue - minGrayValue) * (grayImage - minGrayValue);
end
