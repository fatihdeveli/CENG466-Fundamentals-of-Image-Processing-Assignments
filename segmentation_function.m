%{
Berk Arslan 2110245
Fatih Develi 2330892
%}

function [ segmented_image ] = segmentation_function( image )
%SEGMENTATION_FUNCTION Separates the given image to segments and returns
% segmented image.
%   Detailed explanation goes here

height = size(image, 1);
width = size(image, 2);

% Convert to grayscale
gray = rgb2gray(image);

SE = disk_matrix(15);
processed = imopen(gray, SE);
processed = imclose(processed, SE);

figure, imshow(processed);

% Increase overall contrast by changing brigtness values of some brightness
% bands.
thresholded = zeros(height, width, 'uint8');
for y=1:height
    for x=1:width
        % Set dark areas to 0.
        if (processed(y,x) < 80) 
            thresholded(y, x) = 0;
        % Darken midtones.
        elseif (processed(y,x) < 130)
            thresholded(y, x) = processed(y,x)-34;
        elseif (processed(y,x) < 148)
            thresholded(y,x) = processed(y,x)-27;
        % Brighten upper-mid tones.
        elseif (processed(y,x) < 180)
            thresholded(y,x) = processed(y,x)+15;
        % Leave highlights.
        else
            thresholded(y, x) = processed(y,x);
        end
    end
end
figure, imshow(thresholded);


% Edge map of processed image
edges = edge(thresholded, 'Canny', 0.45);
figure, imshow(edges);
SE = disk_matrix(6);
% Apply closing to complete lines.
edges = imclose(edges, SE);
figure, imshow(edges);
regions = imcomplement(edges);
figure, imshow(edges);
[regions, ~] = bwlabel(regions, 4); % Enumerate regions

% Create the output rgb image
% Need colors for highlighting segments.
colors = [0 0 0;
          180 0 0;     % Red
          128 128 0;   % Olive
          30 144 255;  % DodgerBlue
          147 112 219; % Purple	
          238 238 0;   % Yellow
          173 234 234; % Turquoise
          255 105 180; % Pink
          139 69 19;   % Brown
          130 130 130; % Grey
          0 0 128];    % Navy blue
          
segmented_image = zeros(height, width, 3, 'uint8');
for y=1:height
    for x=1:width
        index = uint8(regions(y,x))+1;
        segmented_image(y, x, 1) = colors(index, 1); %r
        segmented_image(y, x, 2) = colors(index, 2); %g
        segmented_image(y, x, 3) = colors(index, 3); %b
    end
end

figure, imshow(regions);

end

