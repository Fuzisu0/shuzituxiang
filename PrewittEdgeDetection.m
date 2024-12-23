function edgeImg = PrewittEdgeDetection(img)
    img = RGBToGray(img);
    [h, w] = size(img);
    edgeNum = 0;
    edgeThreshold = 0.5; % 设定阈值
    edgeImg = zeros(h, w); % 初始化输出图像

    for j = 2:h-1 % 进行边界提取
        for k = 2:w-1
            edgeNum = abs(img(j-1, k+1) - img(j+1, k+1) + img(j-1, k) - img(j+1, k) + img(j-1, k-1) - img(j+1, k-1)) + ...
                        abs(img(j-1, k+1) + img(j, k+1) + img(j+1, k+1) - img(j-1, k-1) - img(j, k-1) - img(j+1, k-1));
            if (edgeNum > edgeThreshold)
                edgeImg(j, k) = 255; % 边缘像素设为白色
            else
                edgeImg(j, k) = 0;   % 非边缘像素设为黑色
            end
        end
    end
    edgeImg = uint8(edgeImg); % 转换为无符号8位整数
end
