clear;
clc;

A1 = imread('THE3_inputs/partA/A1.png');
A2 = imread('THE3_inputs/partA/A2.png');
A3 = imread('THE3_inputs/partA/A3.png');
A4 = imread('THE3_inputs/partA/A4.png');
A5 = imread('THE3_inputs/partA/A5.png');

A1_height = size(A1,1);
A1_width = size(A1,2);
A2_height = size(A2,1);
A2_width = size(A2,2);
A3_height = size(A3,1);
A3_width = size(A3,2);
A4_height = size(A4,1);
A4_width = size(A4,2);
A5_height = size(A5,1);
A5_width = size(A5,2);


%%%%%%%%%%%%%%%%%%%% A1 %%%%%%%%%%%%%%%%%%%%
A1_gray = rgb2gray(A1);


% Threshold
A1_binary = zeros(A1_height, A1_width, 'logical'); % Create a binary image
for y=1:A1_height
   for x=1:A1_width
       if (A1_gray(y,x) > 50)
           A1_binary(y, x) = 0;
       else
           A1_binary(y, x) = 1;
       end
   end
end

SE = disk_matrix(3);
A1_binary = imclose(A1_binary, SE); % Apply closing operation

[result, ~] = bwlabel(A1_binary);
% Remove the component that is not a balloon (index 1).
result = remove_component(result, 1);
[result, n] = bwlabel(result);

%figure, imshow(A1_gray);
%figure, imshow(result);
fprintf('There are %d balloons in image A1.\n', n);


%%%%%%%%%%%%%%%%%%%% A2 %%%%%%%%%%%%%%%%%%%%
A2_gray = rgb2gray(A2);

% Threshold
A2_binary = zeros(A2_height, A2_width, 'logical'); % Create a binary image
for y=1:A2_height
    for x=1:A2_width
        if (A2_gray(y,x) > 50)
            A2_binary(y, x) = 0;
        else
            A2_binary(y, x) = 1;
        end
    end
end

SE = disk_matrix(3);
A2_binary = imclose(A2_binary, SE);

[result, ~] = bwlabel(A2_binary);
result = remove_component(result, 2); % Remove the non-balloon element
[result, n] = bwlabel(result);
%figure, imshow(A2_gray);
%figure, imshow(result);
fprintf('There are %d balloons in image A2.\n', n);


%%%%%%%%%%%%%%%%%%%% A3 %%%%%%%%%%%%%%%%%%%%
A3_gray = rgb2gray(A3);


SE = disk_matrix(4); % Structuring element
temp = imerode(A3_gray, SE);
A3_gray = A3_gray - temp;

% Threshold
A3_binary = zeros(A3_height, A3_width, 'logical'); % Create a binary image
for y=1:A3_height
   for x=1:A3_width
       if (A3_gray(y,x) < 70)
           A3_binary(y, x) = 0;
       else
           A3_binary(y, x) = 1;
       end
   end
end

%A3_binary = imerode(A3_binary, disk_matrix(1));

%figure, imshow(A3_binary);
[result, n] = bwlabel(A3_binary);
%figure, imshow(result);
%figure, imshow(A3);
fprintf('There are %d balloons in image A3.\n', n-1);


%%%%%%%%%%%%%%%%%%%% A4 %%%%%%%%%%%%%%%%%%%%
A4_gray = rgb2gray(A4);

% Threshold
A4_binary = zeros(A4_height, A4_width, 'logical'); % Create a binary image
for y=1:A4_height
   for x=1:A4_width
       if (A4_gray(y,x) > 50)
           A4_binary(y, x) = 0;
       else
           A4_binary(y, x) = 1;
       end
   end
end


SE = disk_matrix(5); % Structuring element
A4_binary = imopen(A4_binary, SE);

[result, ~] = bwlabel(A4_binary);
resul = remove_component(result, 1);
[result, n] = bwlabel(result);
figure,imshow(A4_gray);
figure, imshow(result);

fprintf('There are %d balloons in image A4.\n', n);


%%%%%%%%%%%%%%%%%%%% A5 %%%%%%%%%%%%%%%%%%%%
A5_gray = rgb2gray(A5);
SE = disk_matrix(3);
% Threshold
A5_binary = zeros(A5_height, A5_width, 'logical'); % Create a binary image
for y=1:A5_height
   for x=1:A5_width
       if (A5_gray(y,x) > 90)
           A5_binary(y, x) = 0;
       else
           A5_binary(y, x) = 1;
       end
   end
end

A5_binary = imopen(A5_binary, SE);

[result, n] = bwlabel(A5_binary);
%figure, imshow(A5_gray);
%figure, imshow(result);
fprintf('There are %d balloons in image A5.\n', n-1);






