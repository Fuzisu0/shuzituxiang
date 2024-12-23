function grayImg = RGBToGray(image)
    % 提取红色通道
    r = image(:,:,1);
    
    % 提取绿色通道
    g = image(:,:,2);
    
    % 提取蓝色通道
    b = image(:,:,3);
    
    % 使用NTSC标准将RGB图像转换为灰度图像
    grayImg = 0.299*r + 0.587*g + 0.114*b;
end
