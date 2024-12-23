function filteredImg = averageFiltering(img)
    % 将输入图像转换为灰度图像
    img = RGBToGray(img);
    
    % 将灰度图像转换为双精度浮点数
    img = im2double(img);
    
    % 获取图像的高度和宽度
    [h, w] = size(img);
    
    % 初始化输出图像为空数组
    filteredImg = zeros(h, w);
    
    % 对图像进行遍历，从第二行到倒数第二行，从第二列到倒数第二列
    for i = 2:h-1
        for j = 2:w-1
            % 计算当前像素及其相邻像素的均值，并赋值给输出图像的相应位置
            filteredImg(i, j) = (img(i, j-1) + img(i-1, j) + img(i, j) + img(i+1, j) + img(i, j+1)) / 5;
        end
    end
    
    % 空域均值滤波
end
