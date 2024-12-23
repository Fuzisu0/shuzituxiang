function filteredImage = MedianFilter(img)
    % 将输入图像转换为灰度图像
    img = RGBToGray(img);
    
    % 将灰度图像转换为双精度浮点数
    img = im2double(img);
    
    % 获取图像的高度和宽度
    [height, width] = size(img);
    
    % 初始化输出图像为空数组
    filteredImage = zeros(height, width);
    
    % 对图像进行遍历，从第二行到倒数第二行，从第二列到倒数第二列
    for i = 2:height-1
        for j = 2:width-1
            % 截取当前像素及其周围 3x3 邻域内的像素值
            neighbor = img(i-1:i+1, j-1:j+1);
            
            % 计算邻域内所有像素值的中值，并赋值给输出图像的相应位置
            filteredImage(i, j) = median(neighbor(:));
        end
    end
    
    % 空域中值滤波
end
