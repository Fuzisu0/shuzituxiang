function robert_img = RobertEdgeDetection(img)
    img = RGBToGray(img);
    [h, w] = size(img);
    robertsNum = 0;
    robertThreshold = 0.2;
    robert_img = zeros(h, w); % 初始化输出图像

    for j = 1:h-1
        for k = 1:w-1
            robertsNum = abs(img(j, k) - img(j+1, k+1)) + abs(img(j+1, k) - img(j, k+1));
            if (robertsNum > robertThreshold)
                robert_img(j, k) = 255;
            else
                robert_img(j, k) = 0;
            end
        end
    end
    % Robert 边缘检测
end