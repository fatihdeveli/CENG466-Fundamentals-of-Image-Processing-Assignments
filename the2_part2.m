%{
Berk Arslan 2110245
Fatih Develi 2330892
%}

clear;
clc;
warning off;

B1 = imread('the2_input/B1.png');
B1_height = size(B1, 1);
B1_width = size(B1, 2);

B2 = imread('the2_input/B2.png');
B2_height = size(B2, 1);
B2_width = size(B2, 2);

B3 = imread('the2_input/B3.png');
B3_height = size(B3, 1);
B3_width = size(B3, 2);


%%%%% B1 %%%%%
B1_t = fft2(B1);
%figure, imshow(fftshift(abs(B1_t)), [0, 40000]);

% Construct the frequency domain filter
center_x = round(B1_width/2);
center_y = round(B1_height/2);
filter1 = ones(B1_height, B1_width);
for x = 1:B1_width
   for y = 1:B1_height
      distance = sqrt((x-center_x)^2 + (y-center_y)^2);
      if((distance > 63 && distance < 85) || (distance > 280 && distance < 320))
         filter1(y, x) = 0;
      end
   end
end
filter1 = ifftshift(filter1); % shift back
B1_t = B1_t .* filter1; % element-wise multiplication
%figure, imshow(fftshift(abs(B1_t)), [0, 40000]);
B1_new = ifft2(B1_t);

% Transformed values should be mapped.
B1_new = B1_new/255.0; % Adjust the color range to [0, 1]
% Map the gray levels to the range [0.0, 1.0]
B1_new = imadjust(B1_new, [min(B1_new(:)); max(B1_new(:))], [0.0; 1.0]);

%figure, imshow(B3_new); % Display the output image 
imwrite(B1_new, 'B1_output.png');


%%%%% B2 %%%%%
B2_t = fft2(B2);
%figure, imshow(fftshift(abs(B2_t)), [0, 5000]);

% Construct the frequency domain filter
center_x = round(B2_width/2);
center_y = round(B2_height/2);
filter2 = ones(B2_height, B2_width);
for x = 1:B2_width
   for y = 1:B2_height
      distance = sqrt((x-center_x)^2 + (y-center_y)^2);
      if(distance > 310)
         filter2(y, x) = 0;
      end
   end
end
filter2 = ifftshift(filter2); % shift back
B2_t = B2_t .* filter2; % element-wise multiplication

B2_new = ifft2(B2_t); % reconstruct image from its transform

% Transformed values should be mapped.
B2_new = B2_new/255.0; % Adjust the color range to [0, 1]
% Map the gray levels to the range [0.0, 1.0]
B2_new = imadjust(B2_new,[min(B2_new(:)); max(B2_new(:))],[0.0; 1.0]);

%figure, imshow(B2_new); % Display the output image 
imwrite(B2_new, 'B2_output.png');


%%%%% B3 %%%%%
% Transform the input image
B3_t = fft2(B3);
% figure, imshow(fftshift(abs(B3_t)), [0, 500000]);

% Construct the frequency domain filter
center_x = round(B3_width/2);
center_y = round(B3_height/2);
filter3 = ones(B3_height, B3_width);
for x = 1:B3_width
   for y = 1:B3_height
      distance = sqrt((x-center_x)^2 + (y-center_y)^2);
      if(distance > 340)
         filter3(y, x) = 0;
      end
   end
end

filter3 = ifftshift(filter3); % shift back


% Apply the filter
B3_t = B3_t .* filter3; % element-wise multiplication
%figure, imshow(fftshift(abs(B3_t)), [0, 500000]);
B3_new = ifft2(B3_t);

% Transformed values should be mapped.
for x = 1:B3_width % Adjust the color range to [0.0, 1.0]
    for y = 1:B3_height
        B3_new(y,x) = B3_new(y,x)/255.0;
        if B3_new(y,x) > 1.0
            B3_new(y,x) = 1.0;
        end
    end
end

% Map the gray levels to the range [0.0, 1.0]
B3_new = imadjust(B3_new, [min(B3_new(:)); max(B3_new(:))], [0.0; 1.0]);

%figure, imshow(B3_new); % Display the output image
imwrite(B3_new, 'B3_output.png');
