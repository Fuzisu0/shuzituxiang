function sobelimg = SobelEdgeDetection(img)
    img = RGBToGray(img);
    [h, w] = size(img);
    sobelNum = 0;
    sobelThreshold = 0.7;
    sobelimg = zeros(h, w); % 初始化输出图像

    for j = 2:h-1
        for k = 2:w-1
            sobelNum = abs(img(j-1, k+1) + 2 * img(j, k+1) + img(j+1, k+1) - ...
                           img(j-1, k-1) - 2 * img(j, k-1) - img(j+1, k-1)) + ...
                       abs(img(j-1, k-1) + 2 * img(j-1, k) + img(j-1, k+1) - ...
                           img(j+1, k-1) - 2 * img(j+1, k) - img(j+1, k+1));
            if (sobelNum > sobelThreshold)
                sobelimg(j, k) = 255; % 边缘点
            else
                sobelimg(j, k) = 0;   % 非边缘点
            end
        end
    end

    % 返回处理后的边缘图像
end
