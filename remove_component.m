%{
Berk Arslan 2110245
Fatih Develi 2330892
%}

function [ output ] = remove_component( image, index )
%REMOVE_COMPONENT Deletes the component with given index from given image.
% Goes through whole image and sets the pixels to zero if they have
% the index given as parameter.
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

