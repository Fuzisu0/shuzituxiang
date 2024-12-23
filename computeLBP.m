function lbpImage = computeLBP(image)
    % 将输入图像转换为双精度浮点数
    image = im2double(image);
    
    % 将图像转换为灰度图像
    grayImage = RGBToGray(image);
    
    % 获取图像的高度和宽度
    [height, width] = size(grayImage);
    
    % 初始化一个长度为8的向量用于存储二进制模式
    binaryPattern = zeros(8, 1);
    
    % 初始化输出图像为空数组
    lbpImage = zeros(height, width);
    
    % 遍历图像的每个像素，从第二行到倒数第二行，从第二列到倒数第二列
    for i = 2:height-1
        for j = 2:width-1
            % 初始化二进制模式索引
            index = 1;
            
            % 遍历当前像素周围的8个邻居像素
            for k = -1:1
                for l = -1:1
                    % 跳过中心像素本身
                    if (k ~= 0) || (l ~= 0)
                        % 比较邻居像素与中心像素的灰度值
                        if (grayImage(i + k, j + l) - grayImage(i, j)) < 0
                            % 如果邻居像素小于等于中心像素，设置为0
                            binaryPattern(index) = 0;
                        else
                            % 否则，设置为1
                            binaryPattern(index) = 1;
                        end
                        % 更新二进制模式索引
                        index = index + 1;
                    end
                end
            end
            
            % 计算当前像素的LBP值
            for t = 0:7
                lbpImage(i, j) = lbpImage(i, j) + ((2^t) * binaryPattern(t + 1));
            end
        end
    end
    
    % 将LBP图像转换为无符号8位整数
    lbpImage = uint8(lbpImage);
    
    % 局部二值模式（LBP）
end
