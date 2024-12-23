% 实现HOG（Histogram of Oriented Gradients）特征提取。
% 输入参数：图像。
% 输出参数：HOG特征图。
function hogFeatures = extractHOG(img)
    img = double(img);
    [height, width] = size(img);
    img = sqrt(img); % 伽马校正

    verticalFilter = [-1 0 1]; % 定义竖直模板
    horizontalFilter = verticalFilter'; % 定义水平模板
    verticalEdges = imfilter(img, verticalFilter, 'replicate'); % 竖直边缘
    horizontalEdges = imfilter(img, horizontalFilter, 'replicate'); % 水平边缘
    edgeMagnitude = sqrt(horizontalEdges.^2 + verticalEdges.^2); % 边缘强度
    edgePhase = verticalEdges ./ horizontalEdges;

    stepSize = 16; % stepSize*stepSize个像素作为一个单元
    numOrientations = 9; % 方向直方图的方向个数
    angleRange = 360 / numOrientations; % 每个方向包含的角度数
    cellArray = cell(1, 1);
    cellRow = 1;
    cellCol = 1;

    for row = 1:stepSize:height - stepSize + 1
        cellCol = 1;
        for col = 1:stepSize:width - stepSize + 1     
            localX = horizontalEdges(row:row + stepSize - 1, col:col + stepSize - 1);
            localEdgeMagnitude = edgeMagnitude(row:row + stepSize - 1, col:col + stepSize - 1);
            localEdgeMagnitude = localEdgeMagnitude / sum(sum(localEdgeMagnitude)); % 局部边缘强度归一化
            localPhase = edgePhase(row:row + stepSize - 1, col:col + stepSize - 1);
            histogram = zeros(1, numOrientations);               

            for p = 1:stepSize
                for q = 1:stepSize
                    if isnan(localPhase(p, q)) % 处理NaN
                        localPhase(p, q) = 0;
                    end
                    angle = atan(localPhase(p, q));    
                    angle = mod(angle * 180 / pi, 360); % 所有角度变为正值
                    if localX(p, q) < 0             
                        if angle < 90
                            angle = angle + 180; % 移到第三象限
                        end
                        if angle > 270
                            angle = angle - 180; % 移到第二象限
                        end
                    end
                    angle = angle + 1e-10; % 避免取整时出现问题
                    histogram(ceil(angle / angleRange)) = histogram(ceil(angle / angleRange)) + localEdgeMagnitude(p, q); % 加权
                end
            end
            histogram = histogram / sum(histogram); % 方向直方图归一化
            cellArray{cellRow, cellCol} = histogram;       
            cellCol = cellCol + 1;                
        end
        cellRow = cellRow + 1;                    
    end

    [numRows, numCols] = size(cellArray);
    featureVector = cell(1, (numRows - 1) * (numCols - 1));
    
    for i = 1:numRows - 1
        for j = 1:numCols - 1           
            combinedFeatures = [];
            combinedFeatures = [combinedFeatures, cellArray{i, j}(:)', cellArray{i, j + 1}(:)', cellArray{i + 1, j}(:)', cellArray{i + 1, j + 1}(:)'];
            featureVector{(i - 1) * (numCols - 1) + j} = combinedFeatures;
        end
    end

    totalFeatures = length(featureVector);
    hogFeatures = [];
    for i = 1:totalFeatures
        hogFeatures = [hogFeatures; featureVector{i}(:)'];  
    end 
    figure;
    mesh(hogFeatures);
end
