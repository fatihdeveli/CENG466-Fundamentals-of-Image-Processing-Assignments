function result = the1_convolution(image, filter)

% This function convolves an image with the given filter.

height = size(image, 1);
width = size(image, 2);
filter_size = size(filter);

if filter_size == 3
    for y = 1:height
        for x = 1:width
            % Special cases needed for y=1, y=height, x=1, x=width since 
            % filter will try to include out of border pixels.
            
            if y == 1 % Upper side 
                
                if x == 0 % Upper left corner
                    
                elseif x == width % Upper right corner
                    
                else
                    
                    
                end
            elseif y == height % Bottom side
                if x == 0 % Bottom left corner
                    
                elseif x == width % Bottom right corner
                    
                else
                    
                end
            elseif x == 1 % Left side
                
            elseif x == width % Right side
                
            else % Not on borders
                new_pixel = image(y-1, x-1) * filter(1,1) + ...
                    image(y-1, x)   * filter(1,2) + ...
                    image(y-1, x+1) * filter(1,3) + ...
                    image(y, x-1)   * filter(2,1) + ...
                    image(y, x)     * filter(2,2) + ...
                    image(y, x+1)   * filter(2,3) + ...
                    image(y+1, x-1) * filter(3,1) + ...
                    image(y+1, x)   * filter(3,2) + ...
                    image(y+1, x+1) * filter(3,3);

                disp(new_pixel);
            end
        end
    end
elseif filter_size == 2
    
else
    error('Invalid filter size.');
end

result = [];
