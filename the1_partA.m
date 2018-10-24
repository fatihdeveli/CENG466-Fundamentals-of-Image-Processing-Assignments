clc;
%%%%%%%%%% A1 %%%%%%%%%%
A1 = imread('./THE1_images/A1.png');

height = size(A1, 1);
width = size(A1, 2);

% create a new image with a width of original image's height, and a height
% of original image's width
new_A1 = zeros(width, height, 3, 'uint8');

% Use affine transform with forward mapping
% T_rotation = [cos90   sin90  0
%               -sin90  cos90  0
%               0       0      1]
T_rotation = [0 1 0; -1 0 0; 0 0 1];
T_translation = [1 0 0; 0 1 0; 334 0 1];
T = T_rotation * T_translation;

% [x y 1] = [v w 1] T

for w = 1:height % y axis
   for v = 1:width % x axis
      new_pixel = [v w 1]*T;
      new_A1(new_pixel(2), new_pixel(1), 1) = A1(w, v, 1); %r
      new_A1(new_pixel(2), new_pixel(1), 2) = A1(w, v, 2); %g
      new_A1(new_pixel(2), new_pixel(1), 3) = A1(w, v, 3); %b
   end
end

imwrite(new_A1, 'A1_output.png');


%%%%%%%%%% A2 %%%%%%%%%%
A2 = imread('./THE1_images/A2.png');
height = size(A2, 1);
width = size(A2, 2);
new_A2 = zeros(900, 800, 3, 'uint8');
original_w = 640;
original_h = 480;

% Required translation distances
shift_h = -1*round((height - original_h)/2);
shift_w = -1*round((width - original_w)/2);

T_rotation = [cos(pi/4) sin(pi/4) 0; 
    -sin(pi/4) cos(pi/4) 0; 0 0 1];
T_translation = [1 0 0; 0 1 0; shift_w shift_h 1];
T = T_rotation * T_translation;
T_inv = inv(T);

% [v w 1] = [x y 1] * T_inv

for y = 1:original_h
   for x = 1:original_w
       source_pixel = [x y 1] / T; % [x y 1] * T_inv
       v = round(source_pixel(1));
       w = round(source_pixel(2));       
       %new_A2(y, x, 1) = A2(w, v, 1);
       %new_A2(y, x, 2) = A2(w, v, 2);
       %new_A2(y, x, 3) = A2(w, v, 3);
       
   end
end


%figure, imshow(A2);
%figure, imshow(new_A2);


%%%%%%%%%% A3 %%%%%%%%%%

A3 = imread('./THE1_images/A3.png');
height = size(A3, 1);
width = size(A3, 2);

edge = [0, 0];
%find the first nonzero pixel
for y = 1:width
    for x = 1:height
      if (A3(y, x) == 0)
        continue
      else
          edge = [y, x];
          break;
      end
    end
    if edge ~= 0
       break;
    end
end

edge(1) = edge(1) - 1;
edge(2) = edge(2) - 1;

newheight = height - edge(1);
newwidth = width - edge(2);

T = [1 0 0; 0 1 0; -edge(2) -edge(1) 1];
% Using inverse mapping: [v w 1] = [x y 1] * T_inv

new_A3 = zeros(newheight, newwidth, 3, 'uint8');

for y = 1:newheight
    for x = 1:newwidth
        source_pixel = [x y 1] / T; % [x y 1] * inv(T)
        new_A3(y, x, 1) = A3(source_pixel(2), source_pixel(1), 1);
        new_A3(y, x, 2) = A3(source_pixel(2), source_pixel(1), 2);
        new_A3(y, x, 3) = A3(source_pixel(2), source_pixel(1), 3);
    end
end

%figure, imshow(A3);
%figure, imshow(new_A3);
imwrite(new_A3, 'A3_output.png');


%%%%%%%%%% A4 %%%%%%%%%%
A4= imread('./THE1_images/A4.png');
height = size(A4,1);
width = size(A4,2);


% find the real image width
realwidth = 0;
for x = 1:width
    if A4(1, x, 1) == 0 && A4(1, x, 2) == 0 && A4(1, x, 3) == 0
       realwidth = x;
       break;
    end
end

emptypixels = width - realwidth;

new = zeros(height, realwidth, 3, 'uint8'); % create the new image
for x = 1:realwidth
    for y = 1:height
        % pixels will be shifted to the left by (emptypixels*(y/height))
        shift = round(emptypixels * (y/height));
        new(y, x, 1) = A4(y, x+shift, 1);
        new(y, x, 2) = A4(y, x+shift, 2);
        new(y, x, 3) = A4(y, x+shift, 3);
    end
end
%figure, imshow(A4)
%figure, imshow(new)
imwrite(new,'A4_output.png');



%%%%%%%%%% A5 %%%%%%%%%%

A5 = imread('./THE1_images/A5.png');
height = size(A5,1);
width = size(A5,2);
new = zeros(height,width,3,'uint8');

for x=1:height
    for y=1:width
        new(x,y,1) = A5(height+1-x,y,1);
        new(x,y,2) = A5(height+1-x,y,2);
        new(x,y,3) = A5(height+1-x,y,3);
    end
end
imwrite(new,'A5_output.png');
