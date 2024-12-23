function rotatedImage = rotateImage(inputImage, angle)
    % 旋转图像的函数
    % 输入参数:
    %   inputImage - 待旋转的图像矩阵
    %   angle - 旋转角度（单位：度）
    
    [height, width, channels] = size(inputImage); 
    
    % 角度转换为弧度
    radians = angle * pi / 180;

    % 原图像四个顶点的行列坐标（逆时针）
    rowCorners = [1, height, height, 1];
    colCorners = [1, 1, width, width];
    
    % 计算旋转后的坐标
    rotatedRowCorners = round(rowCorners * cos(radians) - colCorners * sin(radians));
    rotatedColCorners = round(rowCorners * sin(radians) + colCorners * cos(radians));

    % 计算旋转后图像的大小
    maxRow = max(rotatedRowCorners);
    maxCol = max(rotatedColCorners);
    minRow = min(rotatedRowCorners);
    minCol = min(rotatedColCorners);

    newHeight = maxRow - minRow + 1;
    newWidth = maxCol - minCol + 1;

    % 计算平移量
    deltaRow = max(0, abs(minRow) + 1);
    deltaCol = max(0, abs(minCol) + 1);

    % 初始化新图像矩阵，使用 -1 表示背景
    rotatedImage = ones(newHeight, newWidth, channels) * -1; 

    % 进行图像旋转和映射
    for row = 1:height
        for col = 1:width
            newRow = round(row * cos(radians) - col * sin(radians)) + deltaRow;
            newCol = round(row * sin(radians) + col * cos(radians)) + deltaCol;
            rotatedImage(newRow, newCol, :) = inputImage(row, col, :);
        end
    end

    % 对 R 通道进行插值处理
    rChannel = rotatedImage(:,:,1);

    for i = 1:newHeight
        [validRows, validCols] = find(rChannel(i,:) > 0); 
        
        if ~isempty(validCols)
            % 求第 i 行所有非背景点的列坐标的起止值
            yMin = min(validCols);
            yMax = max(validCols);
            
            % 在 (yMin, yMax) 范围内进行插值
            for j = yMin+1:yMax
                if (rotatedImage(i,j,:) < 0)
                    rotatedImage(i,j,:) = rotatedImage(i,j-1,:);
                end
            end
        end
    end
end
