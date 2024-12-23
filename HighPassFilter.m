function filteredImg = HighPassFilter(img)
    % 将输入图像转换为灰度图像
    img = RGBToGray(img);
    
    % 将灰度图像转换为双精度浮点数
    img = im2double(img);
    
    % 获取图像的高度和宽度
    [h, w] = size(img);
    
    % 定义滤波器的行数和列数
    M = 2 * h;
    N = 2 * w;
    
    % 创建坐标矩阵
    u = -M/2:(M/2-1);
    v = -N/2:(N/2-1);
    [U, V] = meshgrid(u, v); % 生成网格
    
    % 计算距离矩阵
    D = sqrt(U.^2 + V.^2);
    D0 = 40; % 截止频率
    H = double(D > D0); % 理想高通滤波器
    
    % 通过傅里叶变换将时域图像转换到频域图像，并移动到中心位置
    J = fftshift(fft2(img, size(H, 1), size(H, 2))); 
    
    % 滤波处理
    K = J .* H; 
    
    % 傅里叶反转换
    filteredImg = ifft2(ifftshift(K));   
    filteredImg = filteredImg(1:h, 1:w); 
end
