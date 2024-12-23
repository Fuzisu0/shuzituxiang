function laplacianImg = laplacianEdgeDetection(img)
    % 将输入图像转换为灰度图像
    img = RGBToGray(img);
    
    % 获取图像的高度和宽度
    [h, w] = size(img);
    
    % 初始化拉普拉斯操作得到的每个像素的值
    laplacianValue = 0;
    
    % 设定拉普拉斯操作的阈值
    laplacianThreshold = 0.2;
    
    % 初始化输出图像为空数组
    laplacianImg = zeros(h, w);
    
    % 进行边界提取
    for j = 2:h-1
        for k = 2:w-1
            % 计算当前像素及其相邻像素的拉普拉斯算子值
            laplacianValue = abs(4 * img(j, k) - img(j-1, k) - img(j+1, k) - img(j, k+1) - img(j, k-1));
            
            % 如果拉普拉斯算子值大于阈值，则认为是边缘像素，设置为255
            if laplacianValue > laplacianThreshold
                laplacianImg(j, k) = 255;
            else
                % 否则，设置为0
                laplacianImg(j, k) = 0;
            end
        end
    end
    
    % 拉普拉斯边缘检测
end
