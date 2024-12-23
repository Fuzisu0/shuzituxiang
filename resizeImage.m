function resizedImage = resizeImage(image, scaleFactor)
    [height, width, channels] = size(image);
    newHeight = round(height * scaleFactor);
    newWidth = round(width * scaleFactor);
    resizedImage = zeros(newHeight, newWidth, channels);
    
    for newY = 1:newHeight
        for newX = 1:newWidth
            originalY = newY / scaleFactor;
            originalX = newX / scaleFactor;
            i = floor(originalY);
            j = floor(originalX);
            u = originalY - i;
            v = originalX - j;
            i = i + 1;
            j = j + 1;

            % 边界处理
            if (i < 1)
                i = 1;
            end
            if (j < 1)
                j = 1;
            end
            if ((i + 1) > height)
                i = height - 1;
            end
            if ((j + 1) > width)
                j = width - 1;
            end

            % 线性插值公式
            resizedImage(newY, newX, :) = (1 - u) * (1 - v) * image(i, j, :) + ...
                                             (1 - u) * v * image(i, j + 1, :) + ...
                                             u * (1 - v) * image(i + 1, j, :) + ...
                                             u * v * image(i + 1, j + 1, :);
        end
    end
    
    resizedImage = uint8(resizedImage);
end
