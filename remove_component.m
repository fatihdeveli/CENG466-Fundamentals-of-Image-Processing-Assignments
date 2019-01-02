%{
Berk Arslan 2110245
Fatih Develi 2330892
%}

function [ output ] = remove_component( image, index )
%REMOVE_COMPONENT Deletes the component with given index from given image.
%   Detailed explanation goes here
height = size(image, 1);
width = size (image, 2);

for y=1:height
    for x=1:width
        if image(y, x) == index
            image(y, x) = 0;
        end        
    end
end
output = image;
end

